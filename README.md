# ScribbleStack

Field notes, scripts, apps, and agents from the edge of experimentation.

This repository powers [ScribbleStack](https://shantanuvinze.github.io/ScribbleStack/) — a public collection of writings, scripts, apps, and agents. Built with [Jekyll](https://jekyllrb.com/) and the [Chirpy](https://github.com/cotes2020/jekyll-theme-chirpy) theme, deployed via GitHub Actions.

## Structure

- `_posts/` — published content (writings, scripts, apps, agents — categorized via front matter)
- `_tabs/` — top-level navigation pages (About, Archives, Categories, Tags)
- `assets/` — images and static assets

## Adding new content

Create a new file in `_posts/` named `YYYY-MM-DD-title.md` with front matter:

```yaml
---
title: My New Post
date: YYYY-MM-DD HH:MM:SS +0800
categories: [Writings]   # or Scripts, Apps, Agents
tags: [tag1, tag2]
description: One-line summary shown in previews.
---
```

Push to `main` and GitHub Actions will automatically build and deploy the site.

## License

MIT
