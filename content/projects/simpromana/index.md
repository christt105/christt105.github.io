---
showTranslations: false
title: "Simpromana"
image: cover.webp
banner: banner.webp
description: "Obsidian plugin for project management: task flow graph, kanban board and project panel, all inside your vault."
tags: ["tool", "obsidian", "typescript", "kanban"]
filters: ["tool"]
repo: "christt105/obsidian-simpromana-plugin"
githubDownload: true
page: "https://community.obsidian.md/plugins/simpromana"
weight: 230
---

`Simpromana` is an [Obsidian](https://obsidian.md/) plugin for project and task management. It keeps `Projects`, `Tasks` and `Reference` notes wired together through frontmatter, so everything lives in your vault instead of an external service. It is open source under the MIT license and available from Obsidian's community plugins.

Key features:

- **Flow view**: A graph of tasks and their relations (`blocked_by`, `continues`, `related`), grouped and laid out automatically.
- **Board view**: A kanban board (Todo/Doing/Review/Done) with drag-and-drop status changes and an optional project filter.
- **Project panel**: A side panel listing a project's tasks by status, with quick task creation.
- **Commands**: *New project*, *New task*, *New reference* and *Archive current task*, each scaffolding the right frontmatter.
- **Bases integration**: Works alongside Obsidian's core Bases plugin, with `Tasks.base` and `References.base` views embedded in project notes.

The frontmatter fields and folder conventions are opinionated, built around how I organize my own vault, but names and status values are configurable in the settings.

![The Simpromana kanban board](./preview.webp)
