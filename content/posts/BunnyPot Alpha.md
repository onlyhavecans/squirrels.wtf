---
date: 2012-08-04
title: BunnyPot Alpha
tags: [malware, security]
---

Since the beginning of the year I have been mildly obsessed with reversing and malware. Studying ASM and low level debugging is put an awesome edge on my understanding of computer science, programming, and hacking in general.

A week or so ago I started reading the [Malware Analyst's Cookbook and DVD: Tools and Techniques for Fighting Malicious Code](http://search.barnesandnoble.com/Malware-Analysts-Cookbook-and-DVD/Michael-Ligh/e/9780470613030) where they recommend you build up a honeypot to collect malware. Of course I can't a simple suggestions and set up a normal honeypot; Being a SysAdmin at heart I have to _automate the hell_ out of everything.

**If you aren't interested in the scripts or the setup just scroll down for the iPhone pic money shot.**

## Thus is Born BunnyPot 0.5

I started with a Ubuntu VPS, patched but lightly hardened. Obviously being a honeypot the system has to be quasi-disposable.

Setting up dionaea was the **hardest part**!! _Seriously_. The install directions for it are fucked and the whole thing just feels like a one man hack job, however it has the cool features that I want to play with. I wrote up a little batch script that SHOULD one-shot install it. Just like the original install instructions some of the versions might disappear/break so some of the fetch instructions may break and meed to be tweaked. While this script is dirty it's smart enough to exit with error if it fails to download or decompress a file. However if you run it outside of sudo it will fail in ugly ways. Standard disclaimer applies; never run random scripts off the internet without vetting them yourself.

```bash
#!/bin/sh

aptitude install libudns-dev libglib2.0-dev libssl-dev libcurl4-openssl-dev \
libreadline-dev libsqlite3-dev python-dev \
libtool automake autoconf build-essential \
subversion git-core \
flex bison \
pkg-config p0f

mkdir /opt/dionaea


# liblcfg (all)

git clone git://git.carnivore.it/liblcfg.git liblcfg
cd liblcfg/code || exit 1
autoreconf -vi
./configure --prefix=/opt/dionaea
make install
cd ..
cd ..


#libemu (all)

git clone git://git.carnivore.it/libemu.git libemu
cd libemu || exit 1
autoreconf -vi
./configure --prefix=/opt/dionaea
make install
cd ..


#libnl (linux && optional)

git clone git://github.com/tgraf/libnl.git
cd libnl || exit 1
autoreconf -vi
export LDFLAGS=-Wl,-rpath,/opt/dionaea/lib
./configure --prefix=/opt/dionaea
make
make install
cd ..


#libev (all)

wget http://dist.schmorp.de/libev/libev-4.11.tar.gz
tar xfz libev-4.11.tar.gz
cd libev-4.11  || exit 1
./configure --prefix=/opt/dionaea
make install
cd ..


#Python3

wget http://www.python.org/ftp/python/3.2.3/Python-3.2.3.tgz
tar xfz Python-3.2.3.tgz
cd Python-3.2.3/ || exit 1
./configure --enable-shared --prefix=/opt/dionaea --with-computed-gotos \
      --enable-ipv6 LDFLAGS="-Wl,-rpath=/opt/dionaea/lib/ -L/usr/lib/x86_64-linux-gnu/"

make
make install
cd ..

#Cython (all)

#We have to use cython >= 0.15 as previous releases do not support Python3.2 __hash__'s Py_Hash_type for x86.
wget http://cython.org/release/Cython-0.16.tar.gz
tar xfz Cython-0.16.tar.gz
cd Cython-0.16 || exit 1
/opt/dionaea/bin/python3 setup.py install
cd ..


#udns (!ubuntu)
#udns does not use autotools to build.
wget http://www.corpit.ru/mjt/udns/old/udns_0.0.9.tar.gz
tar xfz udns_0.0.9.tar.gz
cd udns-0.0.9/ || exit 1
./configure
make shared
#There is no make install, so we copy the header to our include directory.
cp udns.h /opt/dionaea/include/
#and the lib to our library directory.
cp *.so* /opt/dionaea/lib/
cd /opt/dionaea/lib
ln -s libudns.so.0 libudns.so
cd -
cd ..


#libpcap (most)

wget http://www.tcpdump.org/release/libpcap-1.1.1.tar.gz
tar xfz libpcap-1.1.1.tar.gz
cd libpcap-1.1.1 || exit 1
./configure --prefix=/opt/dionaea
make
make install
cd ..


# FINALLY!!!!

git clone git://git.carnivore.it/dionaea.git dionaea
cd dionaea || exit 1
autoreconf -vi
./configure --with-lcfg-include=/opt/dionaea/include/ \
      --with-lcfg-lib=/opt/dionaea/lib/ \
      --with-python=/opt/dionaea/bin/python3.2 \
      --with-cython-dir=/opt/dionaea/bin \
      --with-udns-include=/opt/dionaea/include/ \
      --with-udns-lib=/opt/dionaea/lib/ \
      --with-emu-include=/opt/dionaea/include/ \
      --with-emu-lib=/opt/dionaea/lib/ \
      --with-gc-include=/usr/include/gc \
      --with-ev-include=/opt/dionaea/include \
      --with-ev-lib=/opt/dionaea/lib \
      --with-nl-include=/opt/dionaea/include \
      --with-nl-lib=/opt/dionaea/lib/ \
      --with-curl-config=/usr/bin/ \
      --with-pcap-include=/opt/dionaea/include \
      --with-pcap-lib=/opt/dionaea/lib/
make
make install

#Fix some permissions
chown -R nobody:nogroup /opt/dionaea/var/dionaea
exit 0
```

WHEW! That's a big one huh? That took me several hours to suss out so I figured it's best shared! I also wrote an update script for the system and all the git based packages, which MOST were.

```bash
#!/bin/bash

aptitude update
aptitude -y safe-upgrade


# liblcfg (all)

cd liblcfg || exit 1
git clean
git pull
cd code
autoreconf -vi
./configure --prefix=/opt/dionaea
make install
cd ..
cd ..


#libemu (all)

cd libemu || exit 1
git clean
git pull
autoreconf -vi
./configure --prefix=/opt/dionaea
make install
cd ..


#libnl (linux && optional)

cd libnl || exit 1
git clean
git pull
autoreconf -vi
export LDFLAGS=-Wl,-rpath,/opt/dionaea/lib
./configure --prefix=/opt/dionaea
make
make install
cd ..


# FINALLY!!!!

cd dionaea || exit 1
git clean
git pull
autoreconf -vi
./configure --with-lcfg-include=/opt/dionaea/include/ \
      --with-lcfg-lib=/opt/dionaea/lib/ \
      --with-python=/opt/dionaea/bin/python3.2 \
      --with-cython-dir=/opt/dionaea/bin \
      --with-udns-include=/opt/dionaea/include/ \
      --with-udns-lib=/opt/dionaea/lib/ \
      --with-emu-include=/opt/dionaea/include/ \
      --with-emu-lib=/opt/dionaea/lib/ \
      --with-gc-include=/usr/include/gc \
      --with-ev-include=/opt/dionaea/include \
      --with-ev-lib=/opt/dionaea/lib \
      --with-nl-include=/opt/dionaea/include \
      --with-nl-lib=/opt/dionaea/lib/ \
      --with-curl-config=/usr/bin/ \
      --with-pcap-include=/opt/dionaea/include \
      --with-pcap-lib=/opt/dionaea/lib/
make
make install

#Fix some permissions
chown -R nobody:nogroup /opt/dionaea/var/dionaea
exit 0
```

If you are following along at home I really recommend you put both of those scripts into their own `dio-build` directory since they make a mess of any directory you run them in and you want to keep all the installers about.

All you have to do after that is start it all up

```bash
sudo p0f -i any -u root -Q /tmp/p0f.sock -q -l -d -o /dev/null -c 1024 && sudo chown nobody /tmp/p0f.sock
sudo /opt/dionaea/bin/dionaea -u nobody -g nogroup -p /opt/dionaea/var/dionaea.pid -D
```

If it doesn't self destruct then you are up and going. If course I recommend you set this up with something like runit but this will get your honeypot working.

## Where the Cool Automation Comes in

dionaea doesn't seem to have the cool IRC features of other honeypots but it still has web submissions. In fact it's designed to submit to several standard honeypots. I'm greedy so I deleted all of those and put in my Mac OS X server as one. For a quick and dirty python receiving server check through [MNIN Security | Malware Analyst's Cookbook](http://www.malwarecookbook.com/) or buy the book.

Having these md5 named malware files on my OS X server means… what? They get backed up? Whoopty dooo! I guess that means I have easier access to them but so what. Lets make my system do all the pre work for me!

Using the power of the almighty [Noodlesoft Hazel](http://www.noodlesoft.com/hazel.php), [Homebrew](http://mxcl.github.com/homebrew/), and a few python packages the system watches the incoming binary directory for new files and then goes to work.[^WHERE] It runs a series of scans on the files and chimes my phone with the summary on my new gift from the internet!

![iPhone Screenshot](/static/images/malware/iPhone.png)

Sweet huh? The first time I was sitting around and my phone chimed, delivering info on a fresh piece of malware, I did a dance.

[^WHERE]: Where is this awesome collaboration of scripts you ask? Well I'm not giving up all the goods yet, especially since it's incomplete. Eventually I will probably post the whole deal. However most everything I set up is in Chapter 3 of the book I have been talking about the whole time. If you are _super_ curious or want your own bunnypot **now** I can be bribed with beer and liquor like most hackers.

Logging into the box and running a single check against the name nets me a larger summary;

```text
➜  malware  ./pescanner.py binaries/12fb7332920a7797c2d02df29b57c640
################################################################################
Record 0
################################################################################

Meta-data
================================================================================
File:    binaries/12fb7332920a7797c2d02df29b57c640
Size:    57344 bytes
Type:    PE32 executable (GUI) Intel 80386, for MS Windows
MD5:     12fb7332920a7797c2d02df29b57c640
SHA1:    47707d46e3324be11cde22cdfe2be7d17193a5a2
ssdeep:
Date:    0x4AD5C802 [Wed Oct 14 12:45:54 2009 UTC]
EP:      0x40369e .text 0/4
CRC:     Claimed: 0x0, Actual: 0x151d9 [SUSPICIOUS]

Signature scans
================================================================================
Clamav: binaries/12fb7332920a7797c2d02df29b57c640: Trojan.Spy-78857 FOUND

Resource entries
================================================================================
Name               RVA      Size     Lang         Sublang                  Type
--------------------------------------------------------------------------------
RT_RCDATA          0xa0a0   0x4621   LANG_KOREAN  SUBLANG_KOREAN           data
RT_RCDATA          0xe6c8   0x400    LANG_KOREAN  SUBLANG_KOREAN           PE32
  executable (GUI) Intel 80386, for MS Windows, Petite compressed

Suspicious IAT alerts
================================================================================
CreateProcessA
StartServiceA
CreateServiceA

Sections
================================================================================
Name       VirtAddr     VirtSize     RawSize      Entropy
--------------------------------------------------------------------------------
.text      0x1000       0x5196       0x6000       5.959918
.rdata     0x7000       0xc76        0x1000       4.498997
.data      0x8000       0x1cdc       0x1000       3.521438
.rsrc      0xa000       0x4ac8       0x5000       7.283870    [SUSPICIOUS]
```

The next piece of this will involve setting up parallels on the Mac Mini server and getting remote malware deployment and testing going. dionaea also records tcp streams so that it can capture shell codes, something I also want to start indexing and stealing up.
