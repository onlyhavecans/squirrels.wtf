date: 2016-08-02 21:23
title: Building chef-dk on FreeBSD 10
slug: chef-dk-on-freebsd
tags: freebsd chef chef-dk

For those that don’t know I’m a Chef for a living. Not the kind that works with food but one that works with code.
What you may not know is I’m a FreeBSD guy, or at least claim to be one.
I’ve been building a new FreeBSD workstation and discovered that there is no chef-dk for FreeBSD.
Building it isn’t bad, but there is a trick to it.

So without further ado, here is building Chef-DK for FreeBSD 10.3 (and probably most >=10.0)

If this is a fresh box you need pkg, ports, and some base packages.
All this assumes run as root.

```
pkg install pkg
portsnap fetch extract
portsnap fetch update
pkg install sudo
```

Ok, for the rest of this I am assuming you are running as a user that has sudo rights.
If you aren’t then ymmv.

```
sudo pkg install ruby rubygem-bundler portdowngrade git
sudo portdowngrade devel/gecode r345033
cd /usr/ports/devel/gecode/gecode
sudo make deinstall install clean
git clone https://github.com/chef/chef-dk.git
cd chef-dk
USE_SYSTEM_GECODE=1 bundle install --without development
```

There you go! It’s not going to give you the /opt/chef-dk omnibus but you will have all the chef-dk you need to do your stuff!
Maybe later I’ll document how to make a package but this will likely work for me.
