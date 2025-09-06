---
date: 2025-09-05T10:47:53-07:00
title: "The Great Forgejo Migration: Introduction"
tags:
  - devops
  - self-hosting
  - forgejo
---

Welcome to the Great ~~British Bake-off~~, I mean Forgejo migration!

This ended up as the first of many posts, but I think after all the work and lessons that came out of a full migration of nearly 60 repos to my own forge, CI/CD, dependency automation, et. al., it is going to be a ride.

## The Background

I have always been a fan of self-hosting. Since the days of Debian Potato[^1] I have been a bit fixated on the idea of setting up and managing my own servers and services. There is no surprise in my career choices after thinking about this. While that original servers hard drive ate itself a long long time ago, and I was forced to rebuild it all by hand over the weekend (tequila was involved somehow). I eventually learned how to automate everything, and in generally version control was always at the center of my automations and scripts.

I have been hosting my own git repos for quite a while, often on a random server over ssh. But once I learned about git-lfs this was no longer enough. I needed a forge to manage my git-lfs files. I started with Atlassian Stash but then moved to Gitea on collocated server. Some may have even remembered links to <https://onlyhavecans.works>. However like most all tech, that Mac Mini came from sand, and eventually returned to it.

I restored my backups of that Gitea internally on my network and used it for extremely sensitive backups and repos while I moved most of my code and other repos to either Gitlab or Github. This was convenient since I used GitHub for work and Gitlab was a popular place to stash things.

But that never changed my desire to self-host and manage all my own stuff.

## The Why

With Gitlab's massive data loss still too fresh in my mind and Github's further and further push into using everything ever for AI training, my desire for data-sovereignty started to increase.

Also, I should admit, the overly centralized internet has been nagging me lately after some conversations. I think we managed to push a lot of progress by cramming everybody and everything into a few sites, but I still think the golden age was more about when we all had our own little corner, not consolidated around a few companies and infinite feeds of data.

Self hosting isn't fully accessible to all, which I think would improve the internet so so much, but I have the resources and knowledge.

## The Plan

I have been keeping a casual eye on the forking of Forgejo from Gitea and have liked the progress and goals of the project, especially the idea of federation and some of their goals of having very user driven UX changes.

While I was going to take some vacation time, I instead decided to refocus my energy on doing some nerd stuff that takes me back to some of my joy in computing. Setting up things, building systems, and making them pretty amazing.

My idea was to move all of my repos from Gitea, Github, and GitLab to a new Forgejo instance, drop my Gitea instance, and sync repos who were already in Github so they keep getting updates.

## The Prep



## What's Next?

More blog posts! 😆

Here are the planned posts:

1. The Great Forgejo Migration: Introductions are in order (this)
2. The Great Forgejo Migration: The Migration of Code & Config
3. The Great Forgejo Migration: Lessons of setting up CI/CD runners
4. The Great Forgejo Migration: Automating DNSControl
5. The Great Forgejo Migration: Renovate is my new best friend
6. The Great Forgejo Migration: Hugo sure, but what about Netlify?
7. The Great Forgejo Migration Side Story: Restoring with Restic (and also backing up I guess)
8. The Great Forgejo Migration: Bits and Bobs, What else?

[^1]: please do not look up when that was
