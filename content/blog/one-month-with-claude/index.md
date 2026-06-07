---
title: I paid for a month of Claude and I have opinions
description: "A reflection on one month using Claude: from Elit3D to TeleDonkey and the Media Tracker, and what thinking about all this makes me feel."
date: 2026-06-07
image: cover.webp
keywords:
  - Claude
  - AI
  - Artificial Intelligence
  - programming
  - projects
readingTime: true
comments: true
draft: true
categories:
  - Programming
tags:
  - ai
  - claude
  - projects
  - reflection
---

Hello again. Today I'm going to step a little outside my usual format. I want to talk about something that has been the hot topic in tech circles for a while now: artificial intelligence. But from a personal angle, no grand proclamations, just sharing what's happened this past month.

## A year with Gemini

Back in December I got a free year of Gemini Pro and honestly, I was pretty happy with it. Not just for small personal coding stuff — at work I ended up rebuilding an entire project in a different technology with its help, and it worked great, in a relatively short time. Having AI as a fast, well-informed second opinion is something you really appreciate when you're stuck on a problem and need a way out.

The issue with Gemini is that over time they kept capping features and cutting down on available tokens. For what I use it for it still works fine, but you can tell they've been tightening the screws.

I'm a programmer, so AI is very much part of my daily life. I can't imagine working without one nearby anymore. That said, it's worth clarifying: AI doesn't program for me. It's more like a very well-informed second opinion. When I face a problem I already know which angle to attack from — AI just makes the whole process much faster.

## Switching to Claude

I've been working on two main personal projects for a while. On one hand there's [Godosters](https://christt105.github.io/projects/godosters/), a Pokémon-style game engine built in Godot, written entirely in GDScript. On the other hand there's [Elit3D](https://christt105.github.io/projects/elit3d/), a 3D tile map editor I started at university. Elit3D has had quite a few lives: at uni it was fully in C++, years later I started rewriting it in Godot with GDScript, then I moved it to C#, and finally I wanted to make it much more professional by splitting it into separate projects — Godot as just the interface, with all the logic running in standard C# projects. I've been jumping between the two over time.

A friend mentioned on Discord that he'd been using Claude for a while and was pretty happy with it. It's €20 for a month (I hope that comment doesn't age badly) and I figured, why not give it a shot. My goal was to learn from the AI while pushing my projects forward at a much faster pace than usual.

And it honestly worked. Within about a week Elit3D improved significantly and I'm very close to having a stable enough alpha to release.

The actual difference between Gemini and Claude isn't that big. What changed was that I finally had time to work on my projects, the motivation to learn, and above all, a way of working I hadn't explored before.

## The Friday I didn't want to waste

Days passed and for life reasons I went about a week without being able to code in my free time. Friday afternoon arrived and I felt guilty about paying for the subscription without making use of it. So I opened Claude intending to tackle one of those projects that always sit in the backlog — the ones that never happen because I either don't have time or they're outside my area of expertise.

First up was [TeleDonkey](https://christt105.github.io/projects/teledonkey/). The idea was simple: a Telegram bot that would connect to my MLDonkey instance and add links to the download queue when sent, along with a few useful commands for managing downloads. While I was telling my friend about it on Discord and setting up the bot on the platform, Claude was already building it. Twenty minutes later it was working.

But the part that surprised me most wasn't that. I told it to push the project to GitHub. Done. Then I asked it to SSH into my local server on the mini PC. And it just did it. I added the project logo, asked it to set up GitHub Actions and publish the image to Docker Hub, add the project to my website and commit everything — and in a short while it was all up and running. Without me looking at a single line of code. I hadn't even had the chance and it was already done.

Doing it on my own would have taken me quite a while. With a rough idea of what needed to happen, in under half an hour it was deployed, on GitHub, on my website and running on my server. It was a project that had been sitting in the backlog with no clear timeline.

## The dog and the Media Tracker

Shortly after, I moved on to another pending project: the [Media Tracker](https://christt105.github.io/MediaTracker/). It's a Hugo website that I'd been wanting to improve for a while, but it was pretty rough around the edges because I don't know much about web development.

That same friend had told me about the remote control feature: you leave your computer on and chat with Claude directly from your phone. So that's what I did. I opened the project on the PC, gave the instructions, and went to walk the dog.

We planned everything that needed to be done and split it into phases. Each phase ended with a commit, and in the meantime I was checking the website on my phone while out on the street, glancing at it every now and then. It fixed style issues, patched several bugs, added a search bar and filters, separated the project into content and theme, created a template project so anyone could use it as a starting point — and more. In one afternoon I did what would have taken me weeks. And it did everything by itself: building, checking, committing, deploying.

## The part that's a bit unsettling

And here's where I stop to think.

What happened with TeleDonkey and the Media Tracker has an important nuance: these are projects where I care much more about the result than the process. Pending projects I wanted to get running and for which I didn't have the time or enough experience in those areas. For that, AI is an incredible tool.

But Elit3D and Godosters are a different story. I'm never going to be sending prompts from my phone while walking the dog for those. Those projects I'll review myself, line by line, sitting in front of the computer and testing every change. They're projects where I enjoy the process as much as the result, and I use AI as support, not as the driver.

The problem — or what's actually unsettling — is something else. We're getting closer and closer to the point where someone with no technical knowledge at all could do exactly what I did with TeleDonkey. What used to require years of study can now be done with the right description. I know I move fast with AI precisely because I've already faced those problems before and I know which angle to attack from, but how far are we going to go?

What makes me a bit melancholic is that something of the craftsmanship of programming has been lost. You don't bang your head against a wall for hours searching forums for how to solve something anymore, you don't get that small personal victory of solving something hard entirely on your own after a lot of effort. The AI sees your code, your folders, the project context, and acts. We're going to code less and less and review more and more, until we reach a point where we stop doing much of anything — if we haven't already hit some kind of breaking point before then.

But I don't want to be a doomer about it. AI is here to stay and the problem, as almost always, will be in how we use it.

## This post is also an experiment

Even this post I'm testing with AI. I'm about to go to sleep, writing from my phone so it sends the prompt to my mini PC, with the typos that come with exhaustion and without rereading anything. Tomorrow when I wake up I'll review how it wrote what I gave it, how it corrected what needed correcting and, above all, how it copied my way of writing — because it has access to all my other blog posts.

If you're reading this, I guess it didn't turn out too badly.

Technology and programming are my hobby and my job, and I don't see AI as a bad thing. It's simply changing the way we do things and we have to adapt. I'll keep making projects, I'll keep writing posts, and if AI lends me a hand every now and then, all the better.

See you in the next post.
