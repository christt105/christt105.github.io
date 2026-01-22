---
title: Creating my Media Tracker with Obsidian and Hugo
description: How I migrated my Media Tracker to a self-hosted solution using Obsidian and Hugo, keeping control of my data.
date: 2026-01-03
image: cover.png
keywords:
  - obsidian
  - hugo
  - media tracker
  - notion
  - markdown
readingTime: true
comments: true
draft: true
categories:
  - Web Development
tags:
  - Obsidian
  - Hugo
  - Media Tracker
  - Notion
  - Python
---
Hello again. This time less time has passed since the last post, and I hope it will be somewhat shorter than the previous one.

In this post I am going to explain what I have done regarding my new [media tracker](https://christt105.github.io/MediaTracker/).

## Background
Sorry for the rant, but first I need to recap this topic. If you are not interested you can go directly to [The new solution](#the-new-solution).

### Twitter and TvTime
It all started in 2022 when I realized that I hadn't played anything so far that year nor was I used to watching series or movies. I wanted to keep track of what I watched and played, so I started making a Twitter thread with the games I was beating, and I used [TvTime](https://www.tvtime.com) to keep a record of movies and series. I beat several games in a row that month, but I put it aside. I was using TvTime to keep track of episodes but sometimes I forgot to mark an episode as watched, I'm a bit of a disaster.

In 2023 I started another thread for everything I played and watched that year. Now I was taking it more seriously. When I finished a game, a movie or a series, I wrote a tweet with a comment and added images.

I continued in 2024 with the same thing. I used TvTime to keep track of what I watched so I wouldn't forget the episode I was on and to have perspective on what I was consuming.

### Stash and Backloggd
For movies and series, TvTime was fine, but for video games I had a problem. I was considering several options.

First I found [Stash](https://stash.games/), which is a mobile application to track video games. You can mark games as completed with the main story, main plus extras or 100% completed.

Later I saw [Backloggd](https://backloggd.com/) and I was investigating. It is very similar to Stash but on the web. They had something in the roadmap that interested me a lot and that was the creation of an API. So I could read and modify data externally. They never created it and removed it from the roadmap.

### Notion
With the previously mentioned tools I could keep track of everything, but I didn't own my data, I had no way to extract the data to put it into another tool if they were discontinued. Just in 2024 the [Notion](https://www.notion.com) fever hit me. With this tool I could create my own databases and it occurred to me to have the tracking there. The idea was to continue using Twitter, as a social showcase, and TvTime as an episodic tracker. The main problem with Twitter was that I couldn't modify the tweet if there was an error, it is very volatile information and searching for something was becoming very complicated. TvTime simply worked, it was missing something like being able to see where my friends were in each series, but otherwise it simply worked for me.

On the other hand, with Notion I could generate a database and each item could be a movie, series or video game. I could edit any note at any time and could publish it on the web. Later they added the possibility of making charts to show statistics. Everything was very beautiful, so I created a [template](https://www.notion.com/templates/media-tracker-es) and started migrating everything to Notion. I published [the website](https://christt105.notion.site/media-tracker) with Notion and continued using Twitter and TvTime as usual, I was tracking the series in TvTime and when finishing a series, game or movie, I published it on twitter and added it to Notion.

In Notion I had several sections where the items were shown. Each movie, series or video game has several properties. The essentials are:
- Cover (Image): usually the direct url of the image from [tmdb](https://www.themoviedb.org/) or [thetvdb](https://www.thetvdb.com/), or an uploaded image.
- Type (Select): Movie, Series or Video Game.
- Status (Status): Not Started, In Progress, Paused, Abandoned or Finished.
- Completed (Date): Date completed.
- Release (Date): Release date, with possibility of notification to alert.
- Properties (Multiple selection): Different properties like the game platform, if I saw it in the cinema, if it is anime or if I completed it 100%.

![Example Note in Notion](NotionMarioGalaxy2.png)

Every time I wanted to add a new item, what I had to do was go to [TMDB](https://www.themoviedb.org/), [TVDB](https://www.thetvdb.com/) or [SteamGridDB](https://www.steamgriddb.com/), search for the name, copy it, go back to Notion, create a new note, paste the name, go back to the web, search through the posters for the one I liked the most, copy the url, go back to Notion, paste it in the cover section as url and finally select the type of item it is. It is not excessive work, but nothing comparable to the flow I have achieved now.

There are other properties like buttons that change the status and the date or recommended to people, but they are not interesting. With all these properties a more than decent tracker can be made.

#### The web with Notion
Notion allows you to publish your notes to the web. I published the Media Tracker with Notion and it generated this url: https://christt105.notion.site/media-tracker. The web is basically the Notion interface but without the possibility of interacting. You can't change the style, so the covers are very small and the result leaves much to be desired.

![Web with Notion](NotionFullScreen.png)

#### Media Cover Recap
Before ending 2024, I liked the idea of making a collage with all the covers of everything I had consumed that year and I started working on it. To solve that, Notion has an API that allowed me to take information from my databases and that is how I made the [Media Cover Recap](https://christt105.github.io/es/projects/mediacoverrecap/), a web project of [Godot](https://godotengine.org/es/) that generated collages from the Notion database. Obviously Godot is not the best tool for that, but at that time I was very obsessed with Godot and wanted to try.

It worked decently but the main problem was [CORS](https://developer.mozilla.org/es/docs/Web/HTTP/Guides/CORS), that http requests are not allowed from one service to another. So either I created a small server that redirected the requests or I made it a desktop and mobile application. And it wouldn't be a good solution either because images with links can become unavailable or the Notion API can change and it would stop working. So all the time I dedicated to this project was destined to go to the trash.

![Media Cover Recap in Godot](MediaCoverRecap.png)

## The new solution
Once seen everything until arriving just to the new solution, it's time to explain what it is about.

For my new Media Tracker I wanted to have several points present:
- All my data must belong to me.
- Be able to migrate the data to another application if necessary.
- Accessible from any device. Be able to add, delete and edit any data mainly from my mobile, but also accessible from the computer.
- Be able to add comments, images and videos to each item.
- Have a website that is easily accessible from any device and completely adaptable to my needs.
- Be able to add movies, series and games in the same database and make it comfortable to do so.

After researching, I decided to go for the idea of using [Obsidian](https://obsidian.md/) for the creation and editing of each element of the tracker and [Hugo](https://gohugo.io/) as a generator of the website.

### Obsidian
For those who know how Notion works, you will have raised an eyebrow before saying that with Notion my data belonged to me and it is not true, in Notion the data is not yours, they can revoke access to them when they consider because they are their property, so it was time to make a move.

From one fever to another, [Obsidian](https://obsidian.md/) came into my life. Thanks to my new acquisition, a mini pc, I could synchronize my notes very effectively, as I already explained in my other post [Six months with my first home server](https://christt105.github.io/es/blog/six-months-with-my-first-home-server/), which was the point that pushed me back the most from Obsidian. Now I am going to explain how I have configured Obsidian for the Media Tracker, maybe in the future I will make a post explaining how I have configured all my Obsidian, since it seems to me a very good tool to integrate into your day to day.

#### Organization
I decided to keep the Media Tracker inside my main Obsidian vault. The Media Tracker lives only in one folder, so I avoid it mixing with the other notes and they are easier to differentiate. Within `Juegos/`, `Movies/`, `TVs/` and `Seasons/` live individually each instance of games, movies, series and seasons respectively. The names are weird because of how I have organized the plugins. I also have the `Portadas/` folder where I put the cover images and banners of items that they don't have on the web, especially fan games.

![Folders of my Media Tracker inside Obsidian](MediaTrackerFolders.png)

In `Media Tracker/` is the `Media Tracker Views.base` file which is a base file with several views. The bases is a very recent addition, they had just put it when I started using Obsidian. It is a file that allows you to assist your notes in several ways, similar to Notion views. It has an API so the community is already starting to use them for more complex things. For now I have only created very basic views, I hardly use them, since I have the web.

![Media Tracker Base View All](MediaTrackerBaseAll.png)
![Media Tracker Base View Anime](MediaTrackerBaseAnime.png)
![Media Tracker Base View Table](MediaTrackerBaseTable.png)

#### Series and Seasons
With the series I had a problem. I didn't know what to do with the series with seasons. On the one hand, there are series that have several seasons and I watch them at different times, so I should separate each series by seasons, but on the other hand, making a duplicate series note can look weird if there is only one season. It is also true that there are series that organize seasons very badly, which can become chaotic.

That is why in the end I decided to use a hybrid solution. Each series will have its own note with the same properties as the movies. If a series has only one season, the series note is used. If a season has several seasons, a note is created for each season and the date of the series note is set to the same as the last season watched.

The only bad thing is that I have to take into account to update two statuses and two dates for the same series with the note of the series and the last season watched. I think it is the most feasible solution to this problem.

#### Plugins and Scripts
One of the most incredible things that Obsidian has is the customization with plugins created by the community. It opens a giant field of possibilities. I have mainly used three plugins that have made the experience of using the Media Tracker much better than with the solutions seen before.

##### Templater
The [Templater](obsidian://show-plugin?id=templater-obsidian) plugin is great for using templates, executing actions and adding information when creating new notes. This is going to help us import information from databases of movies, series and games and organize the notes at the moment of creating them.

##### Movie Search
The [Movie Search](obsidian://show-plugin?id=movie-search) plugin is a somewhat old plugin but it still works very well. It has some things I would change, but for now it is more than enough. The plugin adds a button that opens a panel to enter the name of the movie or series.

![Movie Search Plugin panel to search for a movie or series](MovieSearchPluginSearch.png)

When searching it will do a search using the TMDB API and will show you all the results.

![Search results with Movie Search Plugin](MovieSearchPluginResults.png)

When selecting an option, it will create a new note with a template I have configured, replace the variables with the values of the movie or series and execute the Templater code I have put. TMDB has two types `movie` and `tv` that will be added directly to the `type` property to differenciate it. A default poster and banner will be assigned by TMDB using the link to the image and the TMDB id will be stored to be able to reference it later. The genres and synopsis will also be saved formatting them correctly, since the plugin has problems if they include slashes or double quotes. It also checks if it is a series and adds the `temporadas` (seasons) property. Finally, it takes the year and modifies the file name to include it and avoid problems when creating notes for two different movies with the same name. The template I am currently using is this:

```
---
title: "{{title}}"
type: <% "{{media_type}}".toLowerCase() %>
date: 
rewatches: []
release_date: "{{release_date}}"
status: Not Started
cover: "{{poster_path}}"
banner: "{{backdrop_path}}"
rating: 
genres: <%=movie.genres.map(genre=>`\n  - ${genre}`).join('')%>
tmdb_id: <%=movie.id %>
tags: []
related: []
overview: "<%= movie.overview.replace(/[\r\n]+/g, ' ').replace(/"/g, '\\"') %>"
<%* if("{{media_type}}".toLowerCase() == "tv") { -%>
temporadas: []
<%* } -%>
---

<%*
const year = "{{release_date}}".split("-")[0];
if (year) {
        await tp.file.rename(`${tp.file.title} (${year})`);
    }
%>
```

And this would be the final result of the note:
![Result of a note created with Movie Search Plugin](MovieSearchPluginResultNote.png)

With this plugin we have covered the creation of movies and series with very few clicks and without leaving the application. Let's see now the other plugin that will solve video games, seasons and make our lives easier with some features.

##### QuickAdd
The [QuickAdd](obsidian://show-plugin?id=quickadd) plugin allows you to do many things, but mainly I use it to create scripts and execute them through actions. This way I can create and edit my notes easily and accessing external APIs from the Obsidian interface. The scripts are in JavaScript, most are made with AI and then I edit them, it is fast and does not make many mistakes. These are some of the functions I have created:

###### Add Game
For video games I decided to use the [IGDB](https://www.igdb.com/) database. To be able to use the IGDB API you have to log in with Twitch, which is a bit weird. The truth is that databases in the video game field are quite behind movies and series. All are completely in English and the information is not complete for all games. I decided to use IGDB unlike the others because it was the only one that had fan games that I had played.

I used this script from [Elaws/script_videogames_quickAdd](https://github.com/Elaws/script_videogames_quickAdd) and modified it to customize it to my template. This would be a video game note seen from Obsidian:

![Example Note Silksong](NoteSilksong.png)

###### Create Season
After deciding the Series/Seasons structure, I needed a button to create, from a Series type note, a Season type note with all the attributes and reference of the Series. I made a script that when executing it, checks that you are in a series type note, asks you for a season number and generates a note with the name of the series and adding `" - Temporada X"` at the end. The new note copies the images of the series and links them through the `seasons` and `series` property. This is how a season note would look.

![Example Season Note Obsidian](MediaTrackerSeasonObsidian.png)

###### Update Images
Using only the first image provided by TMDB and IGDB is not very customizable and having to search for them manually on the different websites was not an option. I have created a script that shows you different images, you select the one you like and it substitutes it directly. The script works for both covers and banners, when executing the action it asks you which one you want to change. The script identifies what type of item it is, if it is a movie or series, it searches in TMDB with the id saved in the note and shows you covers 5 by 5, if it is a video game, I use the [SteamGridDb](https://www.steamgriddb.com/) api, since the IGDB images are very bad. In video game notes it first searches if there is a SteamGridDb id, if not found, it searches for games in its database with a similar name and upon selecting it, saves the id for future searches.
![ObsidianUpdateCover](ObsidianUpdateCover.png)
![ObsidianUpdateBanner](ObsidianUpdateBanner.png)

#### Template
Writing this post I realized that there are many things configured and it can be a bit messy. I haven't added the scripts or other templates so as not to make the post longer and tedious. If you are interested in me publishing a template of this media tracker and a tutorial, don't hesitate to leave it in the comments.

### Hugo
[Hugo](https://gohugo.io/) is a magnificent tool. It is a static website generator focused on the Markdown format. I already talked about Hugo in my post [Porting my website to hugo](blog/porting-to-hugo/index.md), where I was creating my website and this same blog with Hugo. It seems wonderful to me and integrates very well with Obsidian, since the core of both tools are Markdown files, so I decided to use it to create the website and be the showcase of my Media Tracker.

#### Theme
Hugo works from a theme. Obviously there is no theme (or I haven't found it) that has everything I need. Anyway I wasn't going to make a theme from zero, my idea was to do the same I did with the website, look for a theme and edit it to my liking, since I don't have much knowledge of web programming. I was looking and finally decided on the theme [hugo-blog-awesome](https://github.com/hugo-sid/hugo-blog-awesome). It is a very simple and minimalist theme, just what I was looking for to start.

Once the theme was chosen, I created a [repository on GitHub](https://github.com/christt105/MediaTracker) that will contain the content of the website and the theme modifications. I could have separated the content from the theme modifications, but being a relatively simple project, I decided to put it in the same repository. Hugo works in such a way that if you create a file with the same name, it will use that as priority over the theme's one. So, in the repository lives the content of the web, which is simply a Markdown file for each element, and the files to overwrite the theme with what is necessary.

I also configured in [GitHub Actions](https://docs.github.com/actions), so that every commit generated the web files and published them on a website. You can see the final result at [https://christt105.github.io/MediaTracker/](https://christt105.github.io/MediaTracker/).

##### Changes in the theme
I am not going to go into much detail because most changes have been done by AI. Mainly I have taken the style of the base theme and added new styles and changed practically the entire structure. I have changed the main page to show a gallery view of each item ordered from newest to oldest. The pages of each category are similar to the main one. I have also added a script that loads a random banner every time you access the web.

##### RSS
I don't usually use [RSS](https://wikipedia.org/wiki/RSS) although I find it interesting to notify new content. I have created two files, [one with all items](https://christt105.github.io/MediaTracker/index.xml) and another [only with finished items](https://christt105.github.io/MediaTracker/acabados.xml). I have added it to the Discord server, although my friends still don't know it.

##### Script
Although Hugo works with Markdown, some adjustments have to be made in terms of structure so that everything works correctly, so I created a script in Python to convert the notes. I have the script in the web repository: [https://github.com/christt105/MediaTracker/scripts/migration.py](https://github.com/christt105/MediaTracker/blob/main/scripts/migration.py).

I execute the script every time I want to update the web. First it deletes the content generated by the script previously to always start clean and then goes through each note of my personal vault, creates a folder in the repository with the name and pastes the note inside the folder.

Each note is processed to make some changes. First it changes all Wikilinks, the ones obsidian uses in this way `[[Other Note]]`, for a link in Markdown format, if the referenced note is another movie, series or video game, or for simple text. I do this because I might reference a note from my personal vault that will not be on the web or reference a movie inside another. Next I modify the links to youtube that were in the note and modify them for the Hugo [shortcode](https://gohugo.io/content-management/shortcodes/) so that it shows correctly.

There are several processes surrounding the subject of images. Mainly I have three types of images.

First we have the images of the covers and banners that are in an external service like TMDB or Steamgridb. In this category enter all images that are within the properties `cover` and `banner` and have a url to tmdb, tvdb, steamgriddb or wherever. These images are the only ones that can be lost at some point, the service can close or delete those images. These images are copied to the repository, so I avoid that if an image stops being available on the internet, I have it saved and when loading the web all come from the same server. Each image url is encoded so that it has its identifying name that will always be the same. The script checks if that image is already in the repository and if so ignores it and if not, downloads it. In case the image url changes, I would save it in the repository and at the end of the script delete all images that have not been used.

On the other hand we have the images of the covers and banners that are saved locally in the vault itself. These images are always copied since they can change but have the same name, and being a local process it does not last long. All images are saved in a cache folder and subsequently are copied to each folder of each note that uses it. They are separated into folders for covers and banners and saved with a suffix to know the origin of the file.

Finally we have the images that are inside the notes. These images are copied directly from the vault and saved inside the note folder.

In this way, the script generates an immutable copy of my data, my notes in the main vault will always be the ones that are modified. Thanks to saving the images as cache, the script is very fast and I avoid the web stopping working correctly due to external factors.

##### Collage Generation
One thing remains to be integrated, the collage generator. It is silly but I was excited about it.

I wasn't very sure if I could do it being a static web page, but it is possible. Thanks to the tool [html2canvas-pro](https://yorickshan.github.io/html2canvas-pro/), it is possible to generate an image of a web element.

After several attempts because it generated images with poor quality if there were quite a few elements, I managed to make it download an image with the original quality of each cover. If there are many elements, the image size is quite large. I added several parameters to filter by date and type and modify the number of columns. Now I can generate a collage of the covers from any device and at any time with a click.

![Collage Generator](CollageGenerator.png)

##### Comments
In Hugo it is frequent to have a comments section. I don't think it is very useful, but I was excited to put it. In the blog I am using [Giscus](https://giscus.app), a comment system that uses Github discussions to store them. The main problem is that you need a GitHub account to be able to comment, which adds an significant barrier for someone to comment. For a technology blog it is more than acceptable and works very well, but for a place of movies, series and video games, it is not a system that fits. I was looking at [Disqus](https://disqus.com/), but it adds ads in the free layer and I don't want any of that on my websites. I was also looking at [Cusdis](https://cusdis.com/), which is an opensource and self-hosted alternative, but I'm quite lazy to host it when nobody will really use it. So in the end I used Giscus.

![Comment](ComentarioGiscus.jpg)

##### Automatic Updater
I already have the website configured along with the script to convert my Obsidian notes to Hugo. However, there is a catch: I don't want to manually transfer notes to my computer and run the script every time I want to post an update.

Thanks to my Mini PC and [Syncthing](https://syncthing.net/), I have my Obsidian vault synced across all my devices. This way, any change I make to my notes from my phone is automatically reflected on the Mini PC. With the Media Tracker folder always in sync, the only thing left was to automate the execution.

To do this, I set up a task on the Mini PC using [cron](https://wikipedia.org/wiki/Cron_/(Unix/)) that runs every day at 9:00. This task launches the Python script on the repository, and once finished, and only if it detects changes, it performs a git push. Thus, every morning, the system updates the files and uploads them to GitHub, triggering a new build of the website. I no longer have to worry about deployment, the entire process is completely automated.

## Next steps
And with this I have already explained everything I have, enough. I had to take a break from this post to optimize the web because it used a lot of resources when downloading the images.

I will leave this project for a while but I have many ideas to keep improving. I would like to add charts to show statistics of what I watch and play. I would also like to add a filter system on the main screen, to be able to filter by type and tags, and thus eliminate the sections. Another important point is to use the `rewatches` property and generate an entry in each date included in that property, so that if there is a movie that I have seen twice, it appears in both dates. I would like to add a search engine, to be able to go directly to the note by name. Finally, I should dedicate some time to optimize the web, add related items in each note and improve the logic of series and seasons.

## Conclusions
It is not the most comfortable tool to configure and use, but it has everything I want. This is no tutorial, so there are many files that I haven't put so as not to make the post very long. If you are interested in me publishing a tutorial on how to create this Media Tracker, let me know in the comments below.

Probably I could have created a post for each section because I have been left with a much longer post than I would like.

I hope you liked it and see you in the next post.