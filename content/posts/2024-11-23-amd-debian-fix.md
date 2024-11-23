---
date: 2024-11-23T11:17:37-08:00
title: Fix Crashing on AMD GPU on Debian 12
draft: false
tags:
  - linux
  - debian
---
This year I replaced my work computer with a AMD Ryzen 7 8700G running Debian 12.

This was _mostly_ ok, but I was getting the most random and rare hard lockups. I was super confused and frustrated as all my burn in tests came back clean with no issues. I even tried a short stint on Ubuntu 24.10 to see it it would help, but it still happened. Then I tried a [GPU benchmarking tool](https://benchmark.unigine.com/superposition) and it hard locked my computer every time it tried to load. Since this was a work computer I hardly ever really engaged the GPU seriously. Turns out the GPU was fine, but the drivers were not.

Below is what I did to fix it, as a reference to myself and others. These are my instructions for Debian 12, adapted from some advice I was linked to from the [Linux Mint forum](https://forums.linuxmint.com/viewtopic.php?f=59&t=370633#firmware) and instruction from the [Debian Forum](https://forums.debian.net/viewtopic.php?t=159363) and Wiki.

> [!WARNING]
> This is a rando on the internet advising you to install a bleeding edge kernel, the latest hotness mesa, and the latest AMD kernel drivers _from the HEAD of the git repo_.
>
> This hasn't bit me in the ass yet, but it may blow up your use case.

## Set up Debian 12's Bookworm Backports

```bash
echo "deb http://deb.debian.org/debian bookworm-backports main contrib non-free non-free-firmware" | sudo tee /etc/apt/sources.list.d/backports.list
sudo apt update
```

## Backport Kernel, AMD, & Mesa

This installed the linux kernel 6.11 at the time of this article.

```shell
sudo apt install -t bookworm-backports linux-image-amd64 linux-headers-amd64 libgl1-mesa-dri libglx-mesa0 mesa-vulkan-drivers libglu1-mesa libglu1-mesa-dev
```

## Update the AMD Drivers from the Kernel's Main Branch

Download the `linux-firmware-main.tar.gz` into `~/Downloads` from the [linux firmware git page](https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git/commit/t).

```bash
cd ~/Downloads
tar -xzf linux-firmware-main.tar.gz
sudo cp --update ~/Downloads/linux-firmware-main/amdgpu/* /lib/firmware/amdgpu/
sudo update-initramfs -u -k all
```

This will generate a pile of warnings about missing files, but none of them caused any issues for me.

## Reboot and Pray

```bash
sudo systemctl reboot
```
