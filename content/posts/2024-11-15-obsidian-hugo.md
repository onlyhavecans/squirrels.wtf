---
date: 2024-11-15T08:29:08-08:00
title: The Union of Obsidian and Hugo
draft: false
tags:
  - obsidian
  - hugo
---

## Preamble

Since I am brining back this blog and plan on writing a lot more I wanted to make it a lot easier. Historically this blog has been written in Vim/NeoVim, which while being a very proficient editor, is not optimal for free flow text for me.

## An Idea

Last year consolidated my journal and all of my notes into [Obsidian](https://obsidian.md). In the past I used MacJournal and then Day One for my journaling and Bear for my notes, but every time I would end up locked out of my data when trying to export to a new system.

Obsidian with a Weekly Journal plugin keeps all my journaling in easy to port text files, and navigating obsidian's wiki style really grooves for my brain.

One of my favorite features of Obsidian is how well it works with git. I am extremely proficient in git these days so being able to both version control, back up, and sync my Obsidian vaults with it has been really amazing.

This got me thinking, why not open my hugo site as an Obsidian vault?

## It Works!

Unsurprisingly it's perfectly smooth. You select your Hugo site directly as a vault and Hugo blissfully ignores the `.obsidian` folder it creates.

Now I have a quick way of editing all of my blog posts. Being able to use all the quick shortcuts for markdown editing, adding code blocks, is very natural to me as a heavy Obsidian user already.

But that's fine and dandy, but how does Obsidian make it _awesome_?

## How Obsidian Makes Blog Writing and Hacking Awesome

In short it's the plugins.
Let's go over them.

### Obsidian Itself

Ok, ok, this isn't a plugin but the way that Obsidian handles the front matter as a formatted properties section is great. It allows for really quick editing of post settings and setup.

The tags pane is also so helpful. Being able to autocomplete tags and see all of the current tags helps keep consistency. Speaking of consistency…

### TagWrangler

[Tag Wrangler](https://github.com/pjeby/tag-wrangler) allows me to get all my tags unified. This blog is very old and the tags (and previously categories) are all over the place.

With tag wrangler a few clicks allows me to edit all my tags across all the posts instantly.

### Obsidian Linter

The more I code the more I love a linter. The consistency of formatting and little things just tickles me. With [Obsidian Linter](https://github.com/platers/obsidian-linter) I can preconfigure it, clean up all of the old posts and now every time I save or leave a file it is formatted and fixed up to offer some consistency.

While this isn't the biggest feature, it really helps me out.

### Git

I generally prefer to keep all my git work to the command line and I will share another blog post soon about how much my git-fu has changed, but making [Obsidian git aware](https://github.com/Vinzent03/obsidian-git) is still nice.

I can check what I have touched and make a quick commit right in a side panel. Nice!

## It (kinda) Works

There is a few things I don't quite have 100% yet.

1. I am still using my `justfile` to create the posts. I will want to set up QuickAdd and Templater at some point to make a single button for 'new post'
2. There is a [hugo preview plugin](https://github.com/fzdwx/hugo-preview-obsidian) but it has some rough edges and didn't work for me better than using my `justfile` and another browser

But I plan on this to be a work in progress. Being in Obsidian makes it really easy to go in and edit stuff in a quick moment and get it committed.

## A Quick Note on Plugins

There is a _lot_ of great writing plugins for Obsidian depending on your style and needs. However the more plugins you install the more piles of publicly developed javascript you are running on your machine.

I generally recommend minimizing the amount of plugins you run. In fact since this vault is just for my blog I disable a majority of the built in plugins as well.

I develop this blog in a [public repo](https://github.com/onlyhavecans/squirrels.wtf) currently so you can go check out all of my obsidian settings and how they have changed since I posted this!
