---
title: Sant Jordi Game Jam 2026
description: A chronicle of our participation in the Sant Jordi Game Jam 2026, developing a game using the Comet Engine.
date: 2026-04-23
image: cover.jpg
keywords: Sant Jordi Game Jam, Comet Engine, game development, indie dev, C++
readingTime: true
comments: true
draft: false
categories:
  - Game Dev
  - Programming
tags:
  - Game Jam
  - Comet Engine
  - Sant Jordi
  - Indie
---
Hi again!

I convinced some friends to join the [Sant Jordi Game Jam 2026](https://santjordijam.github.io/), a Game Jam themed around Sant Jordi: a beautiful holiday celebrated in Catalonia where people exchange roses and books on April 23rd.

![Sant Jordi Game Jam 2026 Poster](cartel.webp)

The Game Jam gave us about three weeks to develop a game, which was perfect since we don't have much free time. Besides the game, you also have to publish a digital rose.

Another thing we decided on was the engine we'd use, though there wasn't much of a debate. Many of you might think there was no debate because I chose Godot, but that couldn't be further from the truth. One of our team members ([oriorii](https://github.com/OriolCS2)) has been working on a 2D game engine for several years: [Comet Engine](https://github.com/OriolCS2/CometEngine). He’s about to release version 2.0 with a new scripting system and several improvements, so it was really the perfect chance to test it out by making a game. This is the first game ever made with Comet Engine.

It had been a long time since I participated in creating a video game; I’ve spent many years making tools and websites, and honestly, I was craving something more creative.

The theme of the Game Jam is:

> Tota pedra fa paret (Every stone builds the wall)

We had several brainstorming meetings. There were plenty of ideas, some crazier than others. At one point, I wanted to put a twist on the theme: in Catalan, the third person singular of the verb "to do/make" is *fa*, which is also the musical note "F". I thought about making it "longer" with a musical touch. Marc liked the idea and we went for it. We designed a pretty complex system where the player would create a song to defeat the dragon. And so, we started working.

Ori and Marc made some good progress, but after two days, we had another idea to pivot the concept: mixing a bullet hell with an [osu!](https://osu.ppy.sh/)-style rhythm game. The dragon would be in the middle shooting fireballs, and the character would move while clicking on circles to the beat of the music.

Marc and Ori got back to grinding. Marc built a rhythm system with combos and customizable music. Ori handled the dragon's fireball system while simultaneously fixing and improving the engine. Dídac joined the project and handled character movement. Me? As usual, I propose things but never do anything, though I’ve had a pretty busy month. Once things settled down, I started working on the stones falling from the sky that would block the fireballs (hence the theme "Every stone builds the wall"... makes more sense in catalan). I also took charge of testing the engine on Linux and on a Windows machine with integrated graphics; it ran reasonably well.

Then came a period where no one did anything. I kept fighting with the stones, and Ori kept polishing the engine. Until the last day arrived and we had to submit.

There was no way we were making it. Plus, Marc was busy with other stuff and Ori was out because Barça was playing... I decided to take the scissors and cut everything down to the bare minimum. It occurred to me that you could only move if you played the rhythm game correctly, making dodging more intense. I set a 90-second timer and started pushing releases and fixing bugs. Comet had some issues with exporting, but it eventually worked itself out. You can export to web to play on Itch.io, just like with Unity or Godot.

The rose was still missing. My idea was to make a shader that constantly drew a rose, but there was no time. I shared a rose I drew on my phone on Discord, but I wanted something different. I thought of a rose made of text, so I ran the image through an ASCII converter and it turned out decent.

We submitted just in time. The game is honestly quite ugly, but it’s playable. Truth be told, working on a game with a custom engine was a really fun experience.

For anyone who wants to try it:

https://christt105.itch.io/sant-jordi-the-stone-song

This has been a little break; there are many more things coming.

Until next time and Happy Sant Jordi!