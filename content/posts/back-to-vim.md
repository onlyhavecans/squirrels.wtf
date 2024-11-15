---
date: 2013-04-11
title: Coming back to vim
slug: back-to-vim
tags: [python, vim, development]
---

It's time for my monthly or so post! I wanted to go through and post about my OpenBSD firewall I built but that's not 100%. Also I'm not ready to go on about anything amazing with puppet because without my lab being done puppet isn't useful so lets go back to talking about my dev environment!

I know Justin has been asking for this for a little while.

## Preface: Going "back" to Vim

As a sysadmin at work I use vi a lot. Not even vim; vi. We have lots of unix boxes that default to vi as the installed editor and we don't just go installing vim on everything. Personally I use vim a good amount on my machine since I spend a lot of command line time anyways. I know more than just a few of the commands but I really only consider myself a second or maybe third year vim user[^YEARS] since I never used it full time to write code. I live the motion and use things like `ci[` and `C-v 5j x` but I still fail to use multiple registers, buffers, or tabs… or even the leader commands.

[^YEARS]: See [Just Use Sublime Text - Andrew Ray's Github Blog](http://delvarworld.github.io/blog/2013/03/16/just-use-sublime-text/) for details on what I mean by that.

I'm an amateur software developer at best; I have serious aspirations about seeing if I have the chops to go pro but right now I'm honing edges. Irregardless of how developer or not I may be, I am developer lazy so I spend money on tools that make my life easier. I've been using PyCharm to help me write utilities and my mini apps and it's just the best. Sometimes I worry about leaning on IDE tools stunting my abilities so I took some time a month back to stand up and step back from PyCharm and instead just use vim…

This is the setup.

## Part One: My Keyboard

I use a slick trick on my Mac so I have no access to Caps and my CapsLock key acts as BOTH a Ctrl and Escape. If I tap the Caps it's esc, if I chord it with anything else it registers Ctrl… I pinkie reach for _nothing_. Here is the the instructions, 10.8 approved so YMMV for other versions.

1. Go to System Preferences -> Keyboard -> Modifier Keys. Set Caps Lock to `^ Control`.
2. Install [KeyRemap4MacBook - Software for OS X](http://pqrs.org/macosx/keyremap4macbook/).
3. In KeyRemap4MacBook, enable `Control_L to Control_L (+ when you type Control_L only, send Escape`. Search will help.
4. Reboot and enjoy.

## Part Two: The Development Server

You didn't think I was just going to `vim run.py` and take off did you? No.

If I'm going to work from the shell I want to make it so I can work from anywhere while I am at it. I have a Mac OS X server that would love to be my dev box so away I go. Open some ports, SSH keys, virtualenv, python3 from brew… tada! But it's not ready yet.

OpenSSH is my best friend. I keep keys close at all times and use cools scripts on my laptop to help manage them. However SSH is not enough and this is where [Mosh: the mobile shell](http://mosh.mit.edu/) comes in. Mosh isn't a total end to end transport solution but it's high speed udp style and local echo features make it supreme when then connection starts lagging and you don't want it to slow down your code. Best yet? `brew install mobile-shell` on both boxes… done…

If only we had a windows client already.

If you want some portable keys help check out the following;

- [BunnyMan.Info — SSH Keys on a USB jump drive on Mac OS X (Mountain Lion Edition)](/posts/2013/Feb/25/ssh-on-usb-on-mac-os-x/)
- [BunnyMan.Info — SSH Keys on a USB jump drive on Mac OS X Part 2](/posts/2013/Mar/07/ssh-on-usb-on-mac-os-x-scripts/)

Just remember to not make these your ONLY keys, all posable keys should be password encoded and easily revokable so keep a backup and list of your emergency to revoke when it gets lost.

## Part Three: The Terminal

I need a sweet terminal so I use zsh with oh-my-zsh and a while bunch of personal mods. Remember the whole lazy part? Yes. Here is the highlights of my zsh configs;

- I have my .zsh run `workon` at the end to list all my virtenvs. It's a nice nag
- I use ^p and ^n for fuzzy history find and it's amazing [dotfiles/zsh/keybindings.zsh at master · onlyhavecans/dotfiles · GitHub](https://github.com/onlyhavecans/dotfiles/blob/master/zsh/keybindings.zsh#L20-L21)
- vi-mode!!!!!

The second major part is tmux. Whatever you are using now… drop it and use tmux. I remapped all my common tmux commands to vi-mode style and C-a for my leader because now ctrl and a are touching. For the full list of my configs which I won't get too deep into check out [tmux.conf at master · onlyhavecans/dotfiles · GitHub](https://github.com/onlyhavecans/dotfiles/blob/master/tmux/tmux.conf.symlink).

My main tmux window generally looks like this

     -----------------------
    |    Chat   |           |
    |     or    |           |
    |extra shell|    VIM    |
    |-----------|           |
    |           |           |
    |    IRC    |-----------|
    |           | MiniShell |
    =========================

Chat is my flux buffer that gets changed between a personal chat and second work buffer. IRC is my ever present wee-chat connection. The mini shell is a little shell I keep in the same dir as vim so I can quick run `python -m unittest discover module` over and over or whatever. When I'm playing with [Flask](http://flask.pocoo.org/) it's running there. Depending on where my focus is the vertical split is usually about 65% weighted to the work to squish distractions without cutting them all out or I am on the 11' MacBook Air screen instead of a 20+' external display.

I often have a second window but the latest version added `C-a z` for window zoom and that's GREAT when I really wanna focus on something or blow up the mini-shell while I am debugging something.

## Part Four: Into VIM

First and foremost I keep an 8.5x11 copy of [Beautiful Vim Cheat-Sheet Poster & Printable Downloads](http://vimcheatsheet.com/) on my desk. It's a nice way to keep reminding me of all the features I NEED to be using and if you don't want to give someone 10USD for it there is a free link right on the page for a low res.

### tl;dr The Configs

[dotfiles/vim at master · onlyhavecans/dotfiles · GitHub](https://github.com/onlyhavecans/dotfiles/tree/master/vim)

A lot of my inital vim config like most was stolen from somewhere but over time I have stripped out everything I didn't adapt in. I started with [YADR](http://skwp.github.io/dotfiles/) and then seriously hacked it to death. In the end there is still yadr references but you shouldn't take anything that claims being from yadr in there still is. I'm just lazy about renaming files for scuz.

### Highlights

- Setting toggle line numbers to F2 & toggle NERDTree to F3 is heavenly.
- I use [Solarized - Ethan Schoonover](http://ethanschoonover.com/solarized) and the plugin is great
- I use a lot of markdown but if you use [plasticboy/vim-markdown · GitHub](https://github.com/plasticboy/vim-markdown) you need to set an extra setting to kill that damn folding
- [klen/python-mode · GitHub](https://github.com/klen/python-mode) is just amazing and I only use a little of it
- I really miss snippits but I am not yet ready to dive into $SNIPMANAGER-X
- I'm just now REALLY getting used to the power of [scrooloose/nerdtree · GitHub](https://github.com/scrooloose/nerdtree)
- I just got into using [Lokaltog/powerline · GitHub](https://github.com/Lokaltog/powerline). it's really slick looking but I'm really not sold on a second status line
- I'd love to use [joonty/vdebug · GitHub](https://github.com/joonty/vdebug) more but I haven't gotten it to work yet

There you go! I know it feels like I'm skimming the VIM part of the vim writeup but there is really only so much you can do TO VIM itself. It's the development environment you put around it and what you put out with it. Hopefully I will be putting out great things once I learn how to use tags and rope and all that other stuff to get back to ultra fast code sifting and editing.

## Part Five: Wishlist

### Auto-running Tests

Just something that PyCharm and Komono before that spoiled me on. `:w` running my tests since I very often TDD would save a lot of window jumping

### Snippits

I'll never get deep code intelligence with vim and that's kinda the point but PyCharm saved somewhere around a billion keystrokes when you learned when to hit the auto complete right.

## Part Six: Warnings

This allows me to do some awesome stuff and so far I am happy with with it outside of a few small caveats.

1. It's damn fiddly. So much and learn and fiddle with distracts from the work.
2. Sometimes cruising around inside of vim, inside of tmux can make for some finger dancing that I don't care for; `C-a l C-a k C-w l`… until I trip over my own keystrokes. `C-a ;` is really useful when popping between panes when it comes to mind

## Part Seven: Going forward

I can connect in technically from anything I trust enough to plug my key jump-drive into. I currently have bought a [YubiKey](http://www.yubico.com/) and am seriously considering switching right over to two-factor OTP which makes me LESS afraid of plugging in the key into something.

Another area I am considering going forward with is I technically won't even need my computer to work. I could just work with my iPad and a keyboard! I'm really sure these articles had just a little bit to do with my idea of moving over to all command line vim. I don't know if I am there but it is tempting;

- [I swapped my MacBook for an iPad+Linode](http://yieldthought.com/post/12239282034/swapped-my-macbook-for-an-ipad)
- [iPad + Linode, 1 Year Later](http://yieldthought.com/post/31857050698/ipad-linode-1-year-later)
- [Working in the Cloud](http://yieldthought.com/post/42450188171/working-in-the-cloud)

* * * * * * * * * *

Was this more in depth than you expected? Do you want more? Lemme know.
