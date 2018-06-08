---
date: 2015-04-24
title: Monitoring Chef runs without Chef
slug: nagios-che-run-check
categories: [sysadmin]
tags: [nagios, chef]
---

I, like many sysadmins, really want to monitor all the things I actually care about. Monitoring is in general *hard*. Not because it’s hard to set up, but it’s hard to get right. It’s really easy to monitor ALL THE THINGS and then just end up with pager fatigue. It’s all about figuring out what you need to know and when you need to know it.

### So in this case I really need to know that my machines are staying in compliance with chef.

There was a few ways you can do this. The first thought I had was adding a hook into all of my runs and having them report in on failure. This is mostly because I’m always looking for another way to hack on Chef and work on my ruby. The big problem with this is:

- What if the node is offline?
- What if the cron doesn’t fire?
- What if chef/or ruby is so borked it can’t even fire the app
- What if someone disabled chef

I need a better solution

### Knife Status

Knife status is just awesome, it has some awesome flags and generally I run it far more than I should. The great part about this query the server approach is that it lets me know;

1. The server is still happy and spitting out cookbooks to nodes
2. The status of ALL of my runs from the “source of truth” for runs

### Not making my chef test rely on chef

But I’m not going to shell knife status. I’m a damn code snob and something about having the chef test rely on the chef client status didn’t seem right.

Instead I wrote a nagios script that I am not going to share in it’s entirety here because $WORK_CODE[^WORKCODE]… *insert sad face* but I will tell you exactly how I did it.

[^WORKCODE]: I don’t yet have any clearance to post or share anything I write for, while, at, or around work. The company owns all that, but we are currently working on getting to the point where we can share some stuff. Especially things not so related to our IP like infrastructure code, cookbook, checks, ect.

## How to python your chef, or how I stopped worrying and learned to love that I can still use python to do anything.

I’m the most experienced in python and almost all of our internal nagios checks we have written in python. So this is in python.

### Step one
Use [pynagioscheck](https://github.com/saj/pynagioscheck) and [pychef](https://github.com/coderanger/pychef). Seriously. Don’t reinvent the wheel here.

### Step two
Create a knife object. have it take all your settings on initialize, then you can create functions for all the different knife commands to recreate them with pychef.

You really only need status for this one. The meat of status is this here, coderanger dropped this on me in IRC

    :::python
    for row in chef.Search('node', '*:*'):
        nodes[row.object['machine name']] = datetime.fromtimestamp(row.object['ohai_time'])

### Step three
Now from here I created a TimeChecker object. It takes the dictionary of `{ server: datetimeObj }` on it’s init. For consistency sake I also init `self.now = datetime.now()`. Then I have a `TimeChecker.runs_not_in_the_last()` that just takes an int.

The magic of `runs_not_in_the_last` I will also share with you because I’m proud of this damn script and want to share it with the world

    :::python
    diff = timedelta(hours=hours)
    return [k for k in self.runtimes.keys() if self.now - self.runtimes[k] > diff]

Bam!

### Step four
Now just extend `NagiosCheck` with `KnifeStatusCheck`, make all your  options and other goods in your init and then make your `check()`

In the check you make knife, Make a `Timechecker` with the status return… then all you have to do is see if you have any `runs_not_in_the_last` for critical and then warning.


## Gotchas and cleanup notes
### USE EXCEPTIONS
seriously, this can and will make them so catch them properly and return errors. You will need to catch and handle AT LEAST
- URLError
- Status
- UsageError
- ChefError
- At least two of your own exceptions

### SSL errors
So there is no trusted_certs here. You need to either give your server a working cert, install the snake oil into the nagios server as acceptable or do the dirtiest of monkey patches.

    :::python
    # Dirty Monkeypatch
    if sys.version_info >= (2, 7, 9):
        import ssl
        ssl._create_default_https_context = ssl._create_unverified_context

But before you do this think of the children!!!

### Weird ass errors with join
I need to maybe open a ticket and patch pynagioscheck but I had the weirdest bug when raising a critical. It would die in the super’s check on `“”.join(bt)` or something of the ilk.

My work around was to not just pass `msg` to the Status exception but to make msg a list and put the main message in `msg[0]` and then put the comma joined list of servers out of compliance in `msg[1]`. This means the standard error comes up on normal returns but if you run the check with `-v` it will give you a list of servers out of compliance for troubleshooting or debugging. Not bad.

### Handling the pem file
Eeeeehhhh This maybe my one cop out in the whole script. Basically I created a nagios user in chef with a insane never to be used again and promptly lost password and put the nagios.pem file alongside the check script. Then I let the script optionally take a pem name, and it just checks that the pemfile is alongside the check script. I was considering letting you specify a pem script somewhere on the server or in the Nagios’s users home directory but decided to bite that and take the simplest route there.


### Don’t destroy your nagios server
Seriously. Did you see this code? Run a search on all nodes and then return an attribute for every node in your nagios server. This is not the worlds fastest check script.

Unless you dedicate some serious power to your solr service on your chef server you should make sure to only check this service once every ten minutes tops. I only check once an hour normally and then follow up with 10 minute checks on fail on my server since I only do converges every four hours so an “out of compliance” warning for me would be at the 12 hour mark and critical at 24 hours[^MATH].

[^MATH]: The reason I picked these numbers is I don’t want to know the FIRST time a converge fails. I use the [omnibus_updater](https://supermarket.chef.io/cookbooks/omnibus_updater) in my runs (Pinned version in attributes of course) so a failed run can be normal. Plus I am deploying something that important I am going to spot check runs and verify everything gets run with `knife ssh`. I just want to know mostly if a machine is out of the loop for more than a day because that’s a node that needs to get shot.
