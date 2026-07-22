---
title: "Cinegram: from rough bot to full platform"
description: "How I picked up an old Telegram bot and, with the help of AI, turned it into a full platform for managing films and series in Jellyfin."
date: 2026-07-23
image: cover.jpg
keywords: [Cinegram, Telegram, Bot, Jellyfin, FastAPI, C#, Vue3, Docker, Self-hosted]
readingTime: true
comments: true
draft: false
categories:
  - Self-hosting
  - Programming
tags:
  - telegram
  - bot
  - self-hosted
  - docker
  - python
  - c#
  - vue
  - fastapi
---
Hey again!

Short post today (hopefully). I keep finishing projects I've had half-done for a while, honestly just to spend my Claude tokens. I've subscribed for another month and wanted to make progress on projects that don't require a huge amount of code analysis. So today I'm publishing Cinegram.
## Origin
About a year ago I started building a Telegram bot that let you send it files, tried to match them against the TMDB database, and referenced them in a database. A bit later I added file downloads. It was a project to learn how to build services with databases and connect to them from outside by creating a backend with FastAPI. And that's where I stopped, because I think something went wrong with my mini PC, I lost some work, and then I couldn't be bothered to keep going.
## Oh, AI
So as I said, I've paid for another month of Claude. I really wanted to give paying for tokens on some Chinese model a try — I've been looking into it — but given how little free time I have and how convenient it is to have Claude accessible from anywhere, I've pushed that to next month. Anyway, that's a topic for another post.

Honestly my idea was to keep the bot going and do everything through Telegram, but since AI is right there, why not have it build a web page? And while we're at it, why not link it to my Jellyfin instance? With AI, the only limits are your imagination, your tokens, and your patience.

So that's what I did, iterating as new ideas came to me. The idea was simple: be able to store all the copyright-free films I have in my Jellyfin in a private Telegram bot to preserve the culture. On the other hand, if I come across royalty-free films, I can send them to the bot and when I want to watch them download them comfortably and have them added to Jellyfin automatically. I think that's pretty clear.

## Might as well ask for everything
I ended up adding quite a lot of stuff, way more than I originally planned. The project is split into 3 parts.

### Backend
The one responsible for storing all the data and supplying it to the other services. I started it in Python out of pure curiosity and to build knowledge with FastAPI. It's honestly very easy to get started with and with very little you can already have a decent, documented API.

When I built it by hand I just thought through the film structure. Each film was unique and could have a collection of collections, and each collection has a set of files. That way, if a film was contained in a single file, it was a collection with one file, but if it's larger due to file size limits, it would be stored as a collection with multiple files. Then with AI I added series, which follow the same pattern: series → season → episode, and upload and download tasks were also added.

To access and manipulate this data there are various routes. Everything used to be in one file because I started it that way when there wasn't much, but it became a monster. I asked Gemini to split it into files and it made a mess of it, then Claude fixed it. Nothing extraordinary: add, modify and delete data, search, and clean up any orphaned collections.

I also added a library for connecting to TMDB to get relevant information on each item.

### Bot
I built the bot with a C# library I really liked, [WTelegramBot](https://github.com/wiz0u/WTelegramBot). It's very simple to set up and blows past the limits of other Telegram bot approaches. It allows file uploads and downloads at very good speed and with normal user limits. I think if I'd used WTelegramClient it could've been even better with a premium account, but for what it is I think it's enough.

It was my first time building a service like this in pure .NET and I genuinely enjoyed the experience and learned quite a few things. I built a system where you'd create a command and it would register itself automatically. I really liked that. The original idea was to be able to do everything through the bot and commands, but it's less convenient than having a dedicated web UI, and the commands ended up pretty unfinished. The bot's purpose now is to receive files, store them, and return them with a nice cover when requested.

![Example of importing a film with fake test files](example_import.jpg)
![Example of an identified film](example_film.jpg)
![Example of how the bot returns files](example_files.jpg)
### Web
The orchestrator of everything. A piece that massively improves the experience. Honestly, I did 95% of the development from my phone. It's built with Vue3 because that's the framework I've been using, even though I barely looked at the web code myself. Near the end of development I wanted to try [Stitch](https://stitch.withgoogle.com/) — not the blue four-armed creature, but a new Google AI design tool that's actually not bad. I exported the project and gave it to Claude and we iterated from there. Honestly the visual side doesn't matter that much to me for these kinds of tools, but I have to admit it doesn't look bad. I focused a lot on mobile since that's where I'm going to be using it most.

It has a section for films and series loaded from Jellyfin, with their cover, an indicator of whether they exist in the database, title and release year. You can filter and sort. Each card has an individual view to upload it to Telegram.

![Films section loaded from Jellyfin](web_example_movies.png)
![Jellyfin library integrated in the web interface](web_example_jellyfin.jpg)

In another section you can see everything that's in the Telegram database. A similar view, but showing the collections it contains. Each one also has an individual page with information and controls to change the cover, re-identify the item, download to Jellyfin, or send it through the bot.

![Items stored in the Telegram database](web_example_telegram.jpg)
![Individual film page with management controls](web_example_telegram_film.jpg)

Finally I added a page to see active downloads and uploads, and a page with instance information and a way to fix items that couldn't be identified.

![Transfers page showing active downloads and uploads](web_transfers.jpg)
![Settings and instance information page](web_settings.jpg)

## Field mouse or city mouse project
I loved the field mouse and city mouse fable from the [Chainsaw Man](https://christt105.github.io/MediaTracker/movies/chainsaw-man---la-pel%C3%ADcula-el-arco-de-reze-2025/) film, and I think we can draw an analogy with projects and AI.

I see two types of projects. Projects where you want everything well-structured and clean, where you'd feel uncomfortable if someone looked at the code, and where you have a close connection to it. You go line by line making sure everything makes sense and you spend long sessions verifying you're doing things the right way.

Then there are projects where you just want the end result and you don't care how it's built inside. You just want it to work and that's it. This was much harder to pull off before AI.

Cinegram started as a field mouse project. It was a personal interest in automating and making my workflows more comfortable, but I wanted to learn FastAPI properly, go deeper into C# development outside of Unity, and learn more about simple databases. But it's turned into a city mouse project, and that's not a bad thing.

Without AI I could've kept working on it, but I doubt it would've gotten to this point — it would've stayed as a simple rough bot and taken way longer to finish if the motivation ever came back.

And here's where the reflection kicks in. Without AI this project would probably have been forgotten, but for a simple €20 subscription and a week's work, I was able to pick the project back up, extend the backend service to add series and other improvements, and add a web interface to manage everything. And honestly, nothing would've been lost if it had stayed forgotten either.

![Chainsaw Man panel with the field mouse and city mouse fable](chainsaw_mouse.jpg)

## Sharing is caring
And as always, it's open source for anyone who wants to use it. If you use it, drop your thoughts in the comments or ask if you have any questions. This time I also wanted to publish the Docker image on GitHub, and you can also find it on Docker Hub, as usual.

{{< github-repo-card owner="christt105" repo="cinegram" >}}

And that's it, hope you enjoyed it and see you soon with more.

Agur!
