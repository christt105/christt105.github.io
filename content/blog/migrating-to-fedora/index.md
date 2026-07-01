---
title: "From Zorin OS to Fedora: Chronicles of a Migration and a Rebel USB"
description: My experience migrating the laptop to Fedora, the inexplicable issues with the installation USB, and my first impressions of the hat distro.
date: 2026-07-01
image: cover.png
keywords:
  - Fedora
  - Zorin OS
  - Linux
  - boot
  - USB
  - installation
readingTime: true
comments: true
draft: false
categories:
  - Operating Systems
tags:
  - linux
  - zorin-os
  - fedora
  - installation
  - opinion
---

## Key Points of This Migration

Before diving into the details, here is a quick summary of how the process went:

* **The Decision:** After the bittersweet taste left by Zorin OS (especially regarding old kernels and modern hardware support like wifi), I decided to make the jump to Fedora on the laptop.
* **The USB Obstacle:** Preparing the installer was an unexpected headache. The USB drive kept freezing indefinitely on the Fedora boot screen.
* **The Boot Solution:** I had to struggle with the image flashing tool, tweak a couple of BIOS settings (like disabling Secure Boot), and use basic graphics mode to finally get the installer to load.
* **The Final System:** Fedora 40/41 with Gnome runs like a charm. And best of all: the network card works out of the box without weird scripts.

---

Hello again!

As I teased in the previous post where I told you about my small failure with Zorin OS, it was clear to me that the next step for the home laptop was to try Fedora. Honestly, Zorin looks great, but getting stuck on an old kernel when you have modern hardware at home is a recipe for disaster.

So, taking advantage of some free time this weekend, I set out to perform the migration. Spoiler: it wasn't a walk in the park.

## The Mystery of the Rebel USB

To start, I downloaded the Fedora Workstation ISO. As I always do, I grabbed an old pendrive I had lying around the desk and flashed the image.

Here began the nightmare. I plugged the USB into the laptop, turned it on, selected to boot from the USB device, and... nothing. It froze indefinitely on the Fedora boot screen. That dark loading screen with the Fedora logo and the wheel spinning (or sometimes not even that, just a blinking cursor at the top left in a very dramatic fashion).

Honestly, at first I thought it was just the USB drive itself. Sometimes these cheap promotional pendrives fail more than a cheap shotgun. So I looked for another, better quality USB drive, flashed it again using Ventoy, and tried again. Same result. It just hung there, laughing at me.

I decided to change tactics and use the official tool, **Fedora Media Writer**, instead of Ventoy or Rufus. I also went into the laptop's BIOS to disable *Secure Boot*, which sometimes gets a bit picky with distros that aren't Ubuntu or Windows.

Finally, in the Fedora boot menu (Grub), instead of hitting the default option, I went into the *Troubleshooting* section and selected **Start Fedora in basic graphics mode**. I'm not sure if it was the official tool, Secure Boot, or the basic graphics mode, but the loading screen finally moved forward and I found myself in the Fedora installer. What a relief!

## Installation and Setup

Once inside the Fedora installer, everything went smoothly. Anaconda (the Fedora installer) has improved its interface quite a bit and is now super intuitive. I created the partitions again (this time making sure to leave a decent 8 GB swap partition to prevent the system from freezing my RAM when opening two tabs of VS Code) and hit install.

In about ten minutes, I had the computer restarted and with a clean Fedora desktop ready to play with.

The first thing I did, obviously, was check if the wifi worked. And sure enough: running a very updated Linux kernel (version 6.8+ compared to the kernel 6.2 Zorin dragged along), it recognized the MediaTek card instantly. No shady GitHub scripts and no fear of an update breaking my connection. Now that's the life!

## First Impressions

For now, honestly, I'm delighted. Pure Gnome on Fedora feels extremely smooth and clean. I've reconfigured the entire ecosystem we share:

* **Flatpaks** enabled in the software store (essential for Calibre, Discord, and Spotify).
* **Syncthing** configured in the background to sync my Obsidian vault.
* **VS Code** and the Git client ready for when I feel like coding from the couch.

Although my partner doesn't really care about the distribution as long as she can open Calibre and her books, I really appreciate having a system with updated packages and a robust support cycle.

I know I'm no Fedora expert (I've always been more from the Debian/Ubuntu family), but the stability and freshness this distro conveys is something I'm really liking. I'll let you know if any more issues pop up in the day-to-day.

What about you? Have you had weird issues booting Fedora from a USB? See you in the next post!
