---
title: "First day of failure with my 3D printer"
description: "I bought a second-hand Ender 3 Max for about 60 euros and the first day was a disaster: uneven first layer, strings everywhere and retraction that does nothing."
date: 2026-11-23
image: cover.png
keywords:
  - 3D printer
  - Ender 3 Max
  - Ender 3
  - Stringing
  - Retraction
  - Calibration
  - First layer
readingTime: true
comments: true
categories:
  - 3D Printer
tags:
  - ender-3
  - 3d-printing
---
This is day one of a series of diaries about the new 3D printer I've bought. I got it from my cousin for about 60 euros: he wanted to get rid of it and buy a Bambu Lab, for multi-material printing and to spend less time on maintenance. It's an Ender 3 Max that he has modified a bit, and the changes are really good. It's absurdly big, bigger than I expected.

I had an Anet A8 many years ago. I assembled it myself and ended up selling it because I never used it: whenever I wanted to print something it needed a ton of maintenance first. I know this one needs it too, but I bought it basically to scratch the 3D printing itch again and make a few silly things.

The first day was a failure.

## First layer: starting so-so

First I tightened the nuts and adjusted the basics, and ran a test print: the first layer in the four corners and in the center of the bed. It looks fine overall, but there are irregularities. I think it's a calibration issue, because the nozzle was too close to the bed. It's the only thing that came out reasonably well all day.

![First layer test squares in the corners and the center of the bed](first-layer-five-squares.jpg)

![A square with an uneven first layer](first-layer-uneven-square.jpg)
![Another test square, with a clearly worse area](first-layer-worse-square.jpg)

## Temperature: the strings begin

Then I printed a temperature tower and I started seeing ugly things. There were tons of strings everywhere and I got a bit nervous.

A temperature tower is a piece printed in several sections, each at a different temperature (here from 195 to 220 degrees). The idea is to compare the sections and keep the temperature that works best for that filament. It matters because hotter plastic is runnier and oozes more from the nozzle, which is exactly what creates strings (stringing). If temperature were the only problem, lowering it until the strings disappeared, without the print starting to fail from poor melting, would be enough.

![Temperature tower, from 195 to 220 degrees](temperature-tower.jpg)

As you can see in the image, there are tons of strings. The fewest are at 195 °C, the lowest temperature, which is also slightly below the minimum recommended by the filament seller. Temperature has a big influence, but the printer shouldn't print like this. Even so, it gives us plenty of clues to identify the problem.

## Retraction: total disaster

I did some research and it looked like a retraction problem.

Retraction is when the extruder pulls the filament back a little just before the head travels without printing. That relieves the pressure inside the nozzle so plastic doesn't ooze on the way. If retraction isn't doing its job, thin strings are left between the parts of the print, which is exactly what was happening to me. It is set with a distance (how much filament is pulled back) and a speed, and the usual way to tune it is a retraction test: a piece printed with different distances, where you look for the value with the fewest strings.

So I ran that test. It came out terrible, all of it, from 0 to the 6 I tried. The Ender has a Bowden extruder, which works differently from a direct one, and retraction is something important to take into account, but as you can see, nothing changed.

![Retraction test full of strings](retraction-test-stringing.jpg)

To top it off, when a print finishes the nozzle keeps extruding filament and a string is left hanging from the printer. That gave me a hint about what was going on.

![A string of filament hanging from the nozzle after the print](filament-string-hanging-from-nozzle.jpg)

## My sister's part

Then I printed a part my sister wanted for something at the lab. It came out pretty badly, but since it wasn't final I left it as it was, and good thing, because she told me some things need to change. It has strings that can be cut and sanded off, but it shouldn't print like that.

There's another problem, which isn't so much the printer's fault: the part has a lot of overhang, and the strings were left hanging between the pieces.

![My sister's part seen from above, with crossed strings](sister-part-top-view.jpg)
![The strings between the overhangs](sister-part-stringing-overhangs.jpg)
![My sister's part from the front](sister-part-front-view.jpg)
![Another view of the part, with strings in the air](sister-part-strings-in-air.jpg)

![Two bars joined by strings in the air](bridge-bars-strings.jpg)

## A bit of joy: the drawer part

So that it wasn't all negative, I printed the classic IKEA part that holds the screws of a drawer, which kept breaking every other day. I was missing one.

![The part on the bed](ikea-part-on-bed.jpg)
![The part just finished](ikea-part-finished.jpg)
![The part on the table](ikea-part-on-table.jpg)
![The two halves of the part](ikea-part-two-halves.jpg)

The one I chose was a bit wider than the original, but it fits well, and the fact that it sticks out a little is only noticeable when you open the drawer.

![The part installed in the drawer](ikea-part-in-drawer.jpg)

If I had asked IKEA for this part they would have given me ten for free, but still, I got a certain satisfaction from printing it myself.

## Conclusion

A pretty bad first day, but that's a bit of the charm of this printer. It has a fix, and I'm sure it can work way better. See you on the next day, to see if I manage to fix it.
