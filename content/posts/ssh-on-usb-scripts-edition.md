---
date: 2013-03-07
title: SSH Keys on a USB jump drive on Mac OS X Part 2
slug: ssh-on-usb-on-mac-os-x-scripts
tags: [macos, security]
---

All right! You read my post [SSH Keys on a USB jump drive on Mac OS X (Mountain Lion Edition)](http://bunnyman.info/posts/2013/Feb/25/ssh-on-usb-on-mac-os-x/) and want to take this to the next level huh? Maybe having your config posting back to a jump drive and having to have it plugged in _every time_ you want to log into something is sooooo lame! You often just leave it there, plugged in when you walk away from your work station. There has to be a better way…

**I got you bro**

What you need to be doing is adding your keys to ssh-agent on demand then pulling your key except for when you REALLY need it. But how do you do that _easily_?

**I got you bro**

## Windows

Lets start with the basics. [PuTTY Download Page](http://www.chiark.greenend.org.uk/~sgtatham/putty/download.html) - Pageant

- Download it.
- Install it.
- Yes you have to use their crappy ppk so set that up.
- Start Pageant then load your ppk version of your key.
- Eject drive.
- open new session, don't bother manual adding key.
- Party time
- Excellent

The cool part is that Pageant remembers your keys so if you pin it to the start menu then it's highlight, over enter, password… you get the point.

The shitty part is it keeps that key loaded until you reboot. That's ULTRA fucking weak. Sorry windows. If anyone knows better give me a shout out.

## Linux

Linux is easier and way better. Lets assume you do everything in the command line so.

```bash
alias loadkey=ssh-add -t 30m /mnt/whatever/ssh/$1
```

then all you have to do is

```bash
loadkey keyname
```

then POW!!! for 30 minutes you have you key loaded. See the 30m in the command? Change that for maximum moddage of commands. Are you a lazy brogrammer slash skriptkiddie and need the time format table?

Bro… got… you are… by me

```bash
<none>  seconds
s | S   seconds
m | M   minutes
h | H   hours
d | D   days
w | W   weeks

Time format examples:
600     600 seconds (10 minutes)
10m     10 minutes
1h30m   1 hour 30 minutes (90 minutes)
```

Damn! Yea….

## Mac

Ok, this is where the gold is. I slaved over a hot mess of applescript to you guys this so feel the love bro. Since it's my Mac and I wanted key exchange to be as easy as possible I pulled out all my scripting to invoke MAXIMUM lazy.

Maximum lazy engage!

Ok. To start there is no ssh-askpass on Mac OS X Mountain Lion which is fairly un-bro of apple but whatever. I replaced it with an applescript I stole and _slightly_ tweaked to run better.

Take this, it's dangerous to go alone.
[onlyhavecans/mac-ssh-askpass · GitHub](https://github.com/onlyhavecans/mac-ssh-askpass)

Just put it in ~/Applications like me or /usr/local/bin or where ever makes you warmest and fuzziest inside. Either way don't forget where you put our makeshift ssh-askpass

Now break out the applescript editor and take this puppy for a ride.

```applescript
(*
This key adding mini program indexes the keyfiles on your jump drive
then prompts you for what one you want to load into ssh-agent

You need mac-ssh-addpass for this to work as well
https://github.com/onlyhavecans/mac-ssh-askpass
*)

property keyFolder : "KEYDRIVE:ssh"
property askPass : "$HOME/Applications/ssh-askpass"
property keyTime : "1h"

tell application "System Events"
  set theList to the name of every item of folder keyFolder
  set theKeys to {}
  repeat with i from 1 to the count of theList
    set theFile to {item i of theList}
    if (theFile as string) ends with "pem" or (theFile as string) ends with "_dsa" or (theFile as string) ends with "_rsa" then
      set end of theKeys to theFile
    end if
  end repeat

  set frontApp to short name of first process whose frontmost is true
  tell application frontApp
    activate
    set theKey to choose from list theKeys with title "Choose your Destiny" with prompt "What Key do you want to activate for " & keyTime default items {first item of theKeys} without empty selection allowed and multiple selections allowed
  end tell

  do shell script "SSH_ASKPASS=" & askPass & " /usr/bin/ssh-add -t " & keyTime & " \"" & {POSIX path of folder keyFolder} & "/" & theKey & "\""
end tell
```

Now pay attention or this will hurt.

The keyFolder property is in Apple's format because it just worked better that way. It needs to point to _the folder_ that has all your key files. The format is `drive:folder:subfolder:youget:theidea`. Now make sure to set that and the location of our new ask-pass.
Also because I was a lazy scripter the filter is hardcoded. If your key files end in anything other than `.pem`, `_rsa`, or `_dsa` you are perfectly legit but I hate you anyways and you will need to edit the nasty `(theFile as string) ends with blah` line.

Now… toss this applescript in your scripts folder and set the hotkey ctrl-opt-k in [FastScripts](http://www.red-sweater.com/fastscripts/) and if you don't have it then shut up and go buy it in thanks from having this awesomeness rained down upon you… or put it in [Alfred App](http://www.alfredapp.com/)… whatever bro; the point is you should be running all your shell and applescripts from the keyboard so do it.

Now hit that key command and watch the awesome of the menu box you can arrow through! Select your key of the minute and hit enter! Be amazed at the applescript password prompt.

Feel amazing bro. Feel amazing.

## Note for Those Who Are Curious

The applescripts are hooking off the frontmost application. IE it's telling whatever app is in front to activate[^ACT] and then display the dialogs for the scripts. So don't bug out because the icon displayed is some "random seeming" app on your system. I do this so that the box is always to front so it can be keyboard operated and drops you right back into your front most app without fuzzing off the focus elsewhere or in some truly random app of my choosing like Finder.

[^ACT]: I had some weird edge case focus issues and making sure to activate before springing the next dialog box smoothed it all out. Sorry if that has any weirds, it really shouldn't

I'll probably put this in my GitHub later, or forget and leave it as a blog exclusive so enjoy.
