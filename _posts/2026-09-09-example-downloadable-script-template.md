---
title: "Example: Publishing an Article With a Downloadable Script"
date: 2026-09-09 16:30:00 +0800
categories: [Scripts]
tags: [example, template, powershell]
description: A template post showing how to publish an article alongside a downloadable script on ScribbleStack.
---

This post is a **template/example** showing the standard pattern for publishing an article that includes a downloadable script. Use this structure whenever you write about a project that has an accompanying script.

## The pattern

1. Write your article as normal in `_posts/`.
2. Place the script under `assets/downloads/<project-name>/`.
3. Link to it from the article using one of the two methods below.

## Example script

This example script (`list-files-by-size.ps1`) scans a folder and lists files sorted by size — useful for quickly spotting what's eating up disk space.

```powershell
param(
    [string]$Path = "."
)

Get-ChildItem -Path $Path -File -Recurse |
    Sort-Object Length -Descending |
    Select-Object FullName, @{Name = "SizeKB"; Expression = { [math]::Round($_.Length / 1KB, 1) } }
```

## Download options

**Option A — plain Markdown link** (opens/displays in-browser for text-based files like `.ps1`, `.py`, `.txt`):

You can view or save the script [here](/assets/downloads/example-script/list-files-by-size.ps1).

**Option B — forced download** (uses raw HTML with the `download` attribute, always prompts "Save As"):

<a href="/assets/downloads/example-script/list-files-by-size.ps1" download>Download list-files-by-size.ps1</a>

## Usage

```powershell
.\list-files-by-size.ps1 -Path "C:\Projects"
```

---

*Replace this entire post with your real article, and swap the example script for your actual file, when you have real content to publish.*
