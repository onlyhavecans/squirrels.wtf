---
date: 2025-09-18T22:18:53-07:00
title: "The Great Forgejo Migration: Introduction"
tags:
  - devops
  - forgejo
  - self-hosting
---

Welcome to the Great ~~British Bake-Off~~, I mean Forgejo migration!

I intended this post to be the whole story of how I took a week to migrate nearly 60 repositories to my own forge and set up CI/CD and dependency automation over it. The moment I started writing, I realized it's going to be a long series. Hopefully you will stick along though.

## The Background

I have always been a fan of self-hosting. Since the days of Debian Potato[^1], I have been fixated on the idea of setting up and managing my own servers and services. There is no surprise in my career choices after thinking about this. While that original server's hard drive ate itself a long, long time ago, and I was forced to rebuild it all by hand over the weekend (tequila was involved somehow), I eventually learned how to automate everything. In general, version control was always at the center of my automations and scripts.

[^1]: Please do not look up when that was.

I have been hosting my own git repos for quite a while, often on a random server over SSH. But once I learned about Git LFS, this was no longer enough. I needed a forge to manage my Git LFS files. I started with Atlassian Stash but then moved to Gitea on a colocated server. Some may have even remembered links to <https://onlyhavecans.works>. However, like most tech, that Mac Mini came from sand, and eventually returned to it.

I restored my backups of Gitea internally on my network and used it for extremely sensitive backups and repositories while I moved most of my code and other repositories to either GitLab or GitHub. This was convenient since I used GitHub for work, and GitLab was a popular place to stash things.

But that never changed my desire to self-host and manage all my own stuff.

## The Why

With Gitlab's massive data loss still too fresh in my mind and GitHub's further and further push into using everything ever for AI training, my desire for data-sovereignty started to increase.

Also, the overly centralized internet has been nagging me lately after some conversations. We made a lot of progress by consolidating everything into a few sites, yet I believe the golden age of the internet was more about when we all had our own little corner with smaller audiences, rather than infinite feeds of data.

Self-hosting isn't fully accessible to all, which I think would improve the internet significantly, but I do have the resources and knowledge.

## The Plan

I have been keeping a casual eye on the forking of Forgejo from Gitea and have liked the project's progress and goals, especially the idea of federation and some of their user-driven UX changes. While I was going to take some vacation time, I instead decided to refocus my energy on doing some nerd stuff that takes me back to some of my joy in computing—setting up things, building systems, and making them pretty amazing.

My idea was to move all of my repositories from Gitea, GitHub, and GitLab to a new Forgejo instance, drop my Gitea instance, and sync repositories that were already on GitHub so they continue to receive updates.

## The Prep

I have already mentioned some of my decisions regarding the choice of Forjego, so the next step is to take some time to audit all the code I want to migrate. At the time, I did not realize how quickly the migrations themselves would be, so I decided to start with all of my code in Gitea, none of my GitLab code for now, and only the sources that were significant in GitHub. Since I tend to start with git init, I have a lot of throw-away one-use code there, and I don't even care that much about hanging on to it.

What am I moving? ✅

The next big decision is then how to host it. I really wanted to host it on a machine in my network behind Caddy for easy SSL, open up the firewall for the necessary ports, and use a combination of dynamic DNS for the outside and a split-horizon DNS internally. The only part of this that is particularly interesting is that I am using unbound to do the split DNS instead of my Pi-Hole. In my testing, it was more reliable and easier to configure this, and since Unbound is what my Pi-Hole uses for resolution, anything in the network sees this. Anything outside comes in through the firewall.

```yaml
  #/etc/unbound/unbound.conf.d/pi-hole.conf
  #...

  # Allow my domains to return private addresses
  private-domain: onlyhavecans.works

  local-zone: "onlyhavecans.works." redirect
  local-data: "onlyhavecans.works. AAAA fd45:4ece:4ead::443"
  local-data: "onlyhavecans.works. A 192.168.1.4"
```

Hosting? ✅

Next is CI/CD. I realized I can't give up GitHub actions without a replacement. I took a moment to look at Jenkins, bringing it back to my roots, until I noticed that the forgejo-runner is not marked anymore as an insecure implementation demonstration. The team over there had been working on completing their action runner. The bonus here is that if I set up a remote Docker-in-Docker setup on another machine, I can put the tax on an old Mac mini for all my workers, and I have an extremely GitHub-like CI/CD process.

The pipelines? ✅

The next thing I realized was that I would be losing Dependabot, which was something I really liked. I spent a bit of time searching for solutions and came up with a very short list. I inevitably went with Renovate and am extremely happy with my choice, but I was initially intimidated by some aspects of it. But I will get there in a later post.

Dependency management? ✅

At this point, I _thought_ I had planned it all generally out. But dear reader, since we are here and now, I will share the one thing I wish I had planned out.

How will I set up my repositories? ❌

## What's Next?

More blog posts! 😆
I think this is too long already to add more. I hope the next few posts will be shorter, but I will also be going into some code examples and processes I went through.

Here are the planned posts:

1. The Great Forgejo Migration: Introduction (this)
2. The Great Forgejo Migration: The Migration of Code & Config
3. The Great Forgejo Migration: Lessons of setting up CI/CD runners
4. The Great Forgejo Migration: Automating DNSControl
5. The Great Forgejo Migration: Renovate is my new best friend
6. The Great Forgejo Migration: Hugo sure, but what about Netlify?
7. The Great Forgejo Migration Side Story: Restoring with Restic (and also backing up, I guess)
8. The Great Forgejo Migration: Bits and Bobs, What else?
