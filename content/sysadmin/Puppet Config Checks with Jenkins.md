date: 2013-02-19 19:32
author: tBunnyMan
title: Puppet Configuration Checks with Jenkins
slug: puppet_jenkins
tags: jenkins

Ok, so we have all our Nagios configs being sanitized and checked by Jenkins, why not [Puppet: IT Automation Software for System Administrators](https://puppetlabs.com/)? WHY NOT PUPPET!?

A lot of this is going to be rehash of the PRIOR article but I wanted to document this out for later anyways since it's slightly different.

## Step One: Assumptions and Layout
I'm going to stop and assume we are well past the Jenkins setup phase. Please see the prior article for that… or better yet? make puppet do it for you. That's what it is for.

Now Puppet is a system that hold dynamically updated configurations of your everything and Jenkins is a system that automatically runs random code summated to it to validate it. I think needless to say I'm not even going to _consider_ these two pieces of software running on the same machine. I'm serious the answer is NO.


Ok, now lets start by assuming the following;

1. You are not using anything crazy like githubbing puppet configs nor can you afford github enterprise. 
1. Puppet Master (puppet.domain.ex) runs in DMZ and is locked down tight.
2. _/etc/puppet_ is your config locations on puppet.domain.ex and you have a user that can write to it other than root.
3. Jenkins is hidden away in your network where it belongs, also fairly secured.
4. Your central git server is on the same lan as your Jenkins, if not on the same box for some reason.
5. You solemly swear not to do anything **stupid** and copy paste anything from this document directly into a command prompt. I may toss a bad char in there just to keep you honest.

We have a few caveats to overcome here but it's not impossible.

## Step Two: Prepare your Puppet box
Puppet server should be locked down. So for my it's a box with all the screws down tight as they can be, puppet's web port and ssh passworded key to one user only is enabled. In order to allow pushing changes through git we will set up our friend the hub repo.

    :::bash...
    # Make puppet config directory a git repo
    cd /etc/puppet
    git init
    git add .
    git commit -m"Inital Commit"
    # Make a hub repo in home
    cd ~
    mkdir puppet_configs.git
    ^mkdir^cd^
    git --bare init
    # Link and push to our hub
    cd /etc/puppet
    git remote add hub ~/puppet_configs.git
    git push hub master

There! That wasn't hard at all. In fact it was a short rehash of what I did last yesterday. However, lets add the post-merge hook to THIS hub.

    :::bash...
    cat __EOF__
    #!/bin/sh
    cd /etc/puppet
    unset GIT_DIR
    /usr/bin/git pull hub master
    __EOF__ >  ~/puppet_configs.git/hooks/post-merge
    chmod 755  ~/puppet_configs.git/hooks/post-merge

So now when the hub gets pushed to, puppet gets a fresh load of configs and it does whatever it needs to do from then on out! Yea? Awesome

Now get out of your puppet box and STAY OUT (until it breaks, you did set up Nagios on it right?)

## Step Three: Jenkins
In case you haven't already Jenkins is going to need a few upgrades. Hit it up with the following plugins.

* Warnings Plug-in
* Jenkins GIT plugin

I have been told you can set up this to work with the RVM plugin to deploy this and that but I took the cheap route since puppet is installed on this machine anyways. For this setup we will need one gem though. If this is for a buisness network I'd go the extra hours to learn RVM but it's not, this is my home lab.

* sudo gem install puppet-lint

Now this is where I start to steal heavily from [Continuous Deployment with Jenkins and Puppet](https://gist.github.com/stephenc/3053561).

Now starts the puppet configurations!

* Name: Puppet
* Source Code Management: Git
    * Repositories: Your central git hub, not the one on puppet[^NOT]
* Trigger Builds Remotely: check
    * Authentication Token: _pick something simple but unique here like 'stopHackingRoot'_
* Poll SCM: check
    * Schedule: `H/15 * * * *`[^POLL]

[^NOT]: Seriously, if you don't have a central git server set up a central git repo SOMEWHERE safe, even on your jenkins box if need be (like we did for nagios) Just remember that your going to end up with something sensitive in there someday.

[^POLL]: You still want to regularly poll the git repo regularly just in case a commit script fails, it's no good to have it falling through the cracks.

On your git repo for puppet you need to add a 'post-update' hook. to trigger builds remotely. Don't forget to sub out YOUR_TOKEN with the token you picked above and set the kenkins server proper. The quick and dirty is;

    :::bash...
    cd puppet_configs.git/hooks
    cat __EOL__
    #!/bin/sh
    echo "Sending build command to Jenkins"
    curl -sSL 'http://mycooljenkins:8080/job/Nagios_Config/build?token=YOUR_TOKEN' >> /dev/null
    exec git update-server-info
    __EOL__ >> post-update
    chmod 755 post-update

Now lets add two execute shell actions.

Build Execute Shell Number one:

    :::bash...
    for file in $(find . -iname '*.pp’)
    do
      puppet parser validate \
        --render-as s \
        --modulepath=modules \
        "$file" || exit 1;
    done

Build Execute Shell Number two:

    :::bash...
    find . -iname *.pp -exec puppet-lint --log-format "%{path}:%{linenumber}:%{check}:%{KIND}:%{message}" {}  \;

The second one shouldn't error out but it will toss up style warnings and possible errors so lets check for those with our warning plugin.

* Post-Build Actions
* Scan for compiler warnings
    * Parser: Puppet-Lint

## Step four: The Danger Zone
Now this is where you might expect me to tell you to set up a Post-Build Action using Git Publisher or some script or another to automate your verified go-live puppet, maybe with a cool mcollector call to speed up your push...

**That recomendation is NOT forthcoming**

The simple fact of the matter is that if you are automatically pushing configs to puppet from Jenkins you have;

1. A passwordless key laying around on a CI box (and any boxes Jenkins spawns) to your puppet config (or worse)
2. Much much bigger balls than me
3. Hopefully a whole enterprise security team all over this shit like a hawk.

You _can_ set up an automated push and hope that everything you or anyone else pushes in master is gold but my recommendation is to test in branches, tag, and then have a human eyes verification on the configs before your push to puppet. When you have a bad push to nagios monitoring glitches out. When pupped fucks up... well you are running down a bad road at full speed. 
