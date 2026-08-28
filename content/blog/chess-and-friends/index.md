---
title: "Chess & Friends: a website to keep score of the beatings my brothers give me at chess"
description: How a chart my sister sent me on Discord ended up as a website that pulls data from the chess.com API to track the humiliations my brothers hand me.
date: 2026-08-23
image: cover.webp
keywords:
  - chess
  - chess.com
  - Claude
  - API
  - dashboard
readingTime: true
comments: true
draft: true
categories:
  - Chess & Friends
tags:
  - chess
  - chess.com
  - claude
  - ai
---
Hi again.

My brothers are chess nerds, most of the time I see them they're either playing games or watching videos about it. I play every once in a while, I've always liked it, but that's it, a casual player who plays the occasional game. Every so often my brothers challenge me to a game and it always ends the same way, a beating.

The other day my sister sent me, out of nowhere, an accuracy chart of our latest games on Discord that she'd pulled from who knows where. Honestly the chart was pretty pathetic, it was worse than losing the game itself. But it gave me an idea: instead of a one-off chart, why not something more alive, that kept updating on its own?

![](Chart.webp)

## Getting to work

Chess.com has a public API with no key or anything weird needed: for each player you can request the games archive for a given month, and it returns, among other things, the accuracy for each side when available (since ~2023 chess.com calculates it for almost every game). With that as a base, the plan was a simple website that would go fetch the games between us and plot them in a couple of charts.

I pitched it to Claude just like that, with what I wanted and little else, and from there it was a matter of iterating: a Node script that hits the API and saves a `games.json`, a static website that reads it and plots it with Chart.js, and while at it, giving it a chessboard vibe instead of the typical generic website. We refined things along the way: caching months that were already closed out so as not to repeat requests for no reason, a different icon depending on how each game ended (checkmate, resignation, timeout, draw), and a GitHub Action that runs every night to refresh the data on its own, so the site never needs me to touch it to stay up to date.

{{< github-repo-card owner="christt105" repo="chess-and-friends" >}}

## The website

You can find it here: https://christt105.github.io/chess-and-friends/. It has two views. The individual one, with my accuracy evolution and my numbers solo:

![Individual view of the Chess & Friends dashboard](dashboard-individual.png)

And the "Friends" one, which compares everyone we play among ourselves and adds a head-to-head table:

![Comparison view between siblings in Chess & Friends](dashboard-amigos.png)

Nothing too complicated under the hood (one HTML file, a fetch script and a dashboard script, no build step or frameworks), but for what I needed it's exactly what I wanted: zero maintenance and it looks like a real project.

## The beatings, in numbers

Honestly it's pretty pathetic, and I should probably even be ashamed to publish this. But whatever, it's just a game. I already suspected it, but seeing it in a neat little table is a whole other level of humiliation.

## Sign off

A one-morning project while doing chores around the house, to laugh at myself a bit (as I write this I can already hear my brothers laughing, the bastards). I've made it public, anyone can clone the repo and edit the data file to generate their own website.

See you next time.

{{< youtube c7BVtGnlxT8 >}}
