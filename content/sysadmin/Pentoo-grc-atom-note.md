date: 2015-09-06 15:03
author: tBunnyMan
title: Quick Note on GnuRadio on Pentoo
slug: pentoo-grc-atom
tags: grc

Not a big blog, but a quick problem I got solved on IRC that I thought might help others.

I have a Gateway LT4009u with an Atom N2600. It's my "hacker/workshop" laptop. The atom N processors are a bit gimpy so sometimes things don't run right.
One thing is GNURadio on Pentoo. Pentoo runs hardened and this pisses off the atom n.

So if you get the following error.

```
LLVM ERROR: Allocation failed when allocating new memory in the JIT
Can't Allocate RWX Memory: Operation not permitted
```

Then you need to soft disable hardened with the following command

```
sudo toggle_hardened
```

I hope that helps anyone else on the internet.

Thanks to Zero_Chaos in #pentoo on irc.freenode.net for the fix (and pentoo)

Quick Update: This also happens when running in VirtualBox 5 on my 2015 MacBook i7, but the fix is the same
