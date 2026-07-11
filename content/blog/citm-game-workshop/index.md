---
title: Teaching a Video Game Creation Workshop with Unity and Godot
description: My experience teaching a Unity and Godot workshop for teenagers.
date: 2026-07-11
draft: true
image: cover.png
comments: true
readingTime: true
categories:
  - Development
keywords:
  - Godot
  - Unity
  - Education
  - Games
  - Workshop
tags:
  - Godot
  - Unity
  - Education
  - GameDev
---

Hello again!

This week I've been quite busy teaching a video game development workshop for teenagers. It's the second year I've gotten myself into this mess, and fortunately, it went much better than the last one.

The truth is, I've always liked teaching. I'm not the best teacher in the world, but I try to make concepts clear. I really enjoy preparing the materials, explaining them, and most of all, seeing how they teach me things too.

The opportunity came up at the university where I studied, in collaboration with the city council, as part of a program to promote university studies among teenagers.

## Last year: My first experience

Last year I had students from first to fourth grade of secondary school (ESO), and to be honest, I went a bit overboard with the material. In my defense, I will say that it was my first experience and I was told the students would be older. The format was 4 days, three hours a day.

To add some context, earlier that same year I had done a two-hour workshop with older high school students. Having so little time, I decided to make a Flappy Bird clone in Unity. The idea was to give them an empty project with the sprites and program it together. Just getting the bird to jump and the pipes to spawn was enough for a first contact. 

In case it's useful to anyone, the material for that workshop is here:

{{< github-repo-card owner="christt105" repo="FlappyBirdUnityWorkshop" >}}

![Flappy Bird Clone made in Unity](flappy_bird.png)

Since the summer workshop was four days in a row, I naively thought we would have time to finish the Flappy Bird and that I would need more games to fill the time. I decided to do one game per day so that if someone missed a day, they could start from scratch with everyone else the next day. I prepared a Pong (Unity), Flappy Bird (Unity), Asteroids (Godot) and a 3D platformer (Godot).

Doing the Flappy Bird was somewhat mandatory, since they had advertised the workshop using the Unity logo. I insisted quite a bit that Godot was much better for teenagers. It barely weighs 100MB, you just download it and open it. None of the 15GB of Unity or the torture of forcing kids to create accounts. Also, Unity's compile times on low-end computers are a nightmare, and GDScript is much cleaner for them to understand. I was pretty annoying about sneaking Godot into the syllabus, and the truth is it turned out well. If there's one thing I excel at, it's convincing people to use products I don't get paid for.

In the end, things went a bit worse than I expected. Although they had a great time, we barely had time to finish any game. The younger ones struggled to keep up, and I had to go one by one fixing what they broke, leaving the older ones waiting and bored.

The best day was definitely the last one, with the 3D platformer. I prepared a modified version of Kenney's excellent *Starter-Kit*. I deleted a couple of lines so the character wouldn't move at the start, programmed them together quickly, and from there, I let them create their own levels by dragging platforms and coins. They had a blast. Some even took out paper and pens to design their levels before building them. 

{{< github-repo-card owner="KenneyNL" repo="Starter-Kit-3D-Platformer" >}}

![3D Platformer Game in Godot](platformer3D.png)

## This year: Improving the formula

For this year I wanted to improve the experience. Since I wasn't given much more information, I assumed I would have the same age range. I used the same repository as last year:

{{< github-repo-card owner="christt105" repo="CITMGameWorkshop" >}}

The most important decision was to cut content. Four games were too many, so I kept the two most visual ones: Flappy Bird and the 3D platformer. That way we had two days of Unity and two days of Godot. Maybe using two engines could confuse them a bit, but I wanted them to see that there are different tools with their pros and cons (and because the organization wanted Unity and I wanted Godot, why lie).

I planned the first day the same way: an empty project to make Flappy Bird together. The second day I gave them the project already advanced, deleted some parts to fill in together, and gave them free time to add mechanics and change the sprites.

The third day was dedicated to writing code to create the base mechanics for the platformer, and the last day was entirely for them to create their own level while I helped them program anything they could think of.

## Using AI to improve the material

When I was preparing all this for this year, I still had a Claude subscription, so I decided to use it to do things that I wouldn't have done due to a lack of time (or laziness).

Last year I noticed that the more autonomous kids got bored if I was helping the younger ones. So I asked Claude to generate step-by-step guides so that those who were lost could review, and the advanced ones could add extra mechanics on their own. 

The guides were great, but in file format, they were going to be a bit complex for them to check. Since GitHub Pages is super easy to use, I asked the AI to build a simple website with the guides. It turned out exactly as I wanted: accessible and very visual. I also integrated the presentations using a Markdown slide format (Marp) that Claude taught me. Everything was kept in a single point of reference with download links. The website is this one: [CITMGameWorkshop](https://christt105.github.io/CITMGameWorkshop/).

![Workshop Website](web_screenshot.png)

Finally, having one branch with the solution and another with the template was a chaos to maintain. The AI gave me the idea of using specific comments in the full code. I set up a CI in GitHub Actions that, upon push, looks for those comments, removes the corresponding code snippets, and updates the *release* with the template ready for the students. A marvel that, without AI, would have been totally out of my scope for the time I had.

```python
# Script I use in CI to generate the empty template
import glob, re
for f in glob.glob('FlappyBirdWorkshop/Assets/Scripts/**/*.cs', recursive=True):
    with open(f, 'r', encoding='utf-8') as file:
        content = file.read()
    
    # Removes all solution code between the markers
    content = re.sub(r'([ \t]*)// <SOL>.*?[ \t]*// </SOL>\n?', r'\1\n', content, flags=re.DOTALL)
    
    with open(f, 'w', encoding='utf-8') as file:
        file.write(content)
```

For example, for the 3D platformer in Godot, the code looks like this in the main repository, and the CI takes care of removing the red lines leaving it ready for the students:

```diff
  func _physics_process(delta):
      # TODO: Aplica la gravedad al personaje
-     # <SOL>
-     velocity.y -= gravity * delta
-     # </SOL>
```

## The workshop development

This year's workshop went phenomenally well. To my surprise, all the students were in their third and fourth year of secondary school, so the skill level was much more unified. They were super focused, with no need to go after them, and they didn't stop asking questions and having ideas.

My main goal was to awaken their creativity, and the last day was a total success. One kid discovered that if he parented objects, they moved together. So he made a platform that fell when stepped on and hung a bunch of deadly spikes from it. Basically, if you stepped on it, a rain of spikes fell that you had to dodge. Another student built a very cool "dialogue" system using areas and triggers that we had briefly seen. Everyone finished their level and ended up playing each other's.

At the end, I asked them which engine they liked the most, and the majority said Godot. For a workshop, it is unbeatable: in 10 minutes they all had it downloaded, open, and ready. With Unity, you always lose a lot more time, and if someone's account login fails, you are already behind schedule.

## Conclusions

Even though this year went great, I think it will be the last time I do the workshop, my Last Dance. I changed jobs, the schedule is stricter, and this time I had to use more vacation days to be able to teach it. I really like doing it, but I don't know if it's worth losing those days.

If I were to repeat it, I'm clear about a couple of things: I would do it 100% in Godot. I would make the Flappy Bird in Godot so that the editor is familiar from day one. And on the 3D platformer day, I would give them a project with many mechanics already built so they don't get overwhelmed programming and can focus on designing levels and dragging objects from minute one.

I had a great time these four days. The organization was also very happy seeing what the kids had achieved on the last day. It seems I've already convinced them that everything could be done with Godot. I take away a good learning experience on how to treat and teach teenagers. In the end, the most important thing at these ages is to encourage effort, creativity, and for them to see that they are capable of creating things they can be proud of.

I'll leave it here, the post got a bit long. See you in the next post!
