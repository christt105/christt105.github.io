# Personal Website

A personal portfolio and blog website built with [Hugo](https://gohugo.io/) and the [Stack theme](https://github.com/CaiJimmy/hugo-theme-stack) with custom modifications.

Live site: [https://christt105.github.io/](https://christt105.github.io/)

## Overview

This repository contains the source code for my personal website, featuring a portfolio of projects, technical blog posts, resume information, and contact details. The site is built using the Hugo static site generator and the Stack theme as a base, with custom styling and component modifications.

## Features

- **Multilingual Support**: Available in English, Catalan, and Spanish
- **Project Portfolio**: Showcase of completed projects with descriptions and links
- **Technical Blog**: Articles on software development, game development, and self-hosting
- **Resume Section**: Education and professional experience information
- **Dark Theme**: Default dark color scheme with custom styling
- **Search Functionality**: Built-in search across blog posts and projects
- **Comments**: Integrated Giscus for article discussions
- **Responsive Design**: Mobile-friendly layout
- **Custom Components**: Modified partials for GitHub cards, Docker repositories, project lists, and more

## Project Structure

- `/content/` - Markdown content files organized by section (blog, projects, resume, contact)
- `/config/_default/` - Hugo configuration files (config.toml, params.toml, etc.)
- `/layouts/` - Custom Hugo templates and shortcodes
- `/assets/` - JavaScript, SCSS, and image assets with custom styling
- `/data/` - Additional data files (technology stack information)
- `/static/` - Static files served directly

## Building and Deployment

The site is built with Hugo and deployed as a static site on GitHub Pages.

To build locally:
```bash
hugo server
```

To generate production build:
```bash
hugo
```

## Technologies

- **Hugo** - Static site generator
- **Stack Theme** - Base theme with customizations
- **SCSS** - Styling
- **Giscus** - Comments system

## License

Content is licensed under CC BY-NC-SA 4.0