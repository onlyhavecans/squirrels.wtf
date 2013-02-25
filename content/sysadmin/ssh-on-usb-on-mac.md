date: 2013-02-25 10:39
author: tBunnyMan
title: SSH on a USB jump drive on Mac OS X (Mountain Lion Edition)
slug: ssh-on-usb-on-mac-os-x
tags: Mac

## Here I address the eternal struggle.

I want to store all my private keys on my jump drive I wear around everywhere. I use Win, Linux, but primarily Macs to do to my work so it needs to be some FAT variant formatted. I want to use the absolutely least hacky way.

Windows and Linux were easy to overcome. In short for windows you use putty to make a putty key and in linux you do something shockingly similar to what is below… but I get ahead of myself.

All the searches in duck duck go and google came up with "Nope! Can't do it! Give up!" for the Mac. All these people are horrible liars and don't want you to succeed. After figuring this out it was REALLY EASY as long as you are terminal competent. If you aren't terminal competent I'm not sure why you read my blog, I'd assume most of my stuff is really flying over your head.

As always YMMV and don't copy paste things I write here into the terminal.

## tl;dr jump point
1. Find your uid with "`id -u`". 99% of the time it's 501.
2. Double check your drive name with "`ls -ln /Volumes`".
3. with sudo add a new line to `/etc/fstab`[^NOT]

		#Drive called iamakey and user 501
		LABEL=iamaKey none msdos -u=501,-m=700

There is no step 4; eject & replug your key to enjoy ssh keys used directly from drive.

[^NOT]: On a new 10.8 machine `/etc/fstab` does not exist. You must create a fresh file as root.

## Considerations
- You have to do this on every mac you use. The drive name is always the same but there is a chance the user id is different.

- If you aren't sure if it worked or are having trouble give another "`ls -ln /Volumes`" which should look shockingly similar to this if you did it right:

		lrwxr-xr-x  1 0    80     1 Feb 25 07:01 Macintosh HD -> /
		drwx------  1 501  20  8192 Feb 25 10:17 iamaKey

- You should REALLY make sure this drive name is unique to this drive for your machine. Any drive with the same name will get grabbed up by this now and if it's not msdos formatted or you don't want this havoc can be had.

- In a multi-user environment this could likely cause weird edge case problems unless you are using very unique drive names.

- I'm really sure putting spaces in your drive name will only wreck havoc. However you would assume that having lowercase letters in it would also fail hard but as you can see it works fine for me.

- if you wanna be *really* cool then set up your config file on the jump drive as well and then alias keyssh to 'ssh -F /path/to/usb/config' Then that can ALL follow you around, except for on linux since it would mount on media or whatever instead of /Volumes breaking all your pathing in the config but then you can just create a symlink anyways and it will work again… or something like that.

- While not the point of this article yet your OpenPGP, GnuPG, GPG whateverPG, etc keys should also be WAY happier now placed on the jump drive. I believe they also hate being world readable. 

- This may not work in 10.9 or 11 or whatever comes next. The file `/etc/fstab.hd` says this is on the deprecation list. If Apple does break this down the road and you are reading this from the future the trick is to go looking wherever `diskarbitrationd` or it's successor is getting it's settings.

- Final note, if you are going to do all this _**PLEASE**_ don't use password-less keys. Just don't do it. Especially if you put your config file on the drive too. Then you are just telling people what systems they now have access too. Each key on the drive should have a strong & long passphrase, have it's comment clearly marked as being the jump dive key (on the machines they key is loaded), and should be unique to that jump drive only so it can be easily purged and reissued in case of loss.
