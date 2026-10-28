---
showTranslations: false
title: "Parallax Scene Editor"
image: cover.webp
banner: banner.webp
description: "Browser-based editor for seamlessly looping pixel art parallax scenes. Serverless, nothing is uploaded."
tags: ["tool", "javascript", "pixel-art", "animation"]
filters: ["tool", "web"]
repo: "christt105/parallax-scene-editor"
githubDownload: false
page: "https://christt105.github.io/parallax-scene-editor/"
weight: 220
---

`Parallax Scene Editor` is an editor for looping pixel art parallax scenes. It opens in the browser, reads a folder on your own disk full of your sprites and exports GIF, WebM or a PNG sequence. There is no server, no build step and nothing is uploaded anywhere. It is open source under the MIT license.

A parallax background is easy to draw and a nuisance to assemble: every layer moves at its own speed and the whole thing has to fit into the same number of frames for the loop not to jump. Here a scene is one JSON file with camera, layers, actors and keyframes, and the editor tells you in red when something is not going to close.

Key features:

- **Works on your own folder**: It reads the sprites from a folder on your disk, and the scene file follows the editor, saved automatically a moment after each change.
- **Live reload of sprites**: Repaint a sprite in your pixel art editor, save, and it updates on the canvas on its own.
- **Layers, actors and keyframes**: Positions are keyframed and interpolated, and you edit while watching the scene play on a loop.
- **Loop checks**: The editor warns you when the loop is not going to close.
- **Export**: GIF, WebM or PNG sequence, plus a package export to take the scene elsewhere.

Opening folders with write access needs the File System Access API, which is only available on Chromium desktop browsers. Elsewhere it falls back to a read-only snapshot.

{{< video src="bike-ride" alt="A bike rider and a running Mudkip looping over a parallax forest background, made with the editor" >}}

![The editor with the demo scene](./preview.webp)
