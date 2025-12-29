---
date: 2026-01-01T08:13:38-07:00
title: Setting up Streaming for your own Music
draft: false
tags:
  - music
  - self-hosting
---


This is part... what? Four in the series on owning and keeping your own music instead of streaming. 

There is one critical peice I haven't gone over though.

## But… How Do Listen Music?

The easiest way to enjoy your digital music before everything became mobile and phone based was that you created a music folder on your computer and like, dumped all the album folders into it. or maybe organized them like

```text
music > artist > album > coolfile.mp3
```

Then you open up the music in winamp and enjoy the sweet tunes.
And if you wanted music on the go? You burn a CD!

## Ok, grandma. Nobody has a cd player anymore

You mibut that doesn't cut it anymore.

We need our phones to do everything and ALL OF OUR MUSIC ALL THE TIME.

I don't actually believe this. i think it's an interesting experiment to give yourself like three albums or 75 minute playlists and stick to that for a week. And if that's all you need… Music Players STILL exist and you can buy them and load them up with music.

But let's assume you want to be able to "stream" all your music all the time. Then files on your laptop are not going to cut it…

### A Solution for the Least Technical

I did some research for this one, I don't actually do this but it is from a dev of software I use.

Put all your music on some sort of random cloud service like Dropbox, Google Drive, Microsoft Drive, whatever.

Then point this $50/yr website at it <https://asti.ga>

Your own private streaming service and you don't even have to set up anything at home

### For Those Technical Enough to Have a NAS

Plex & PlexAMP.

For reals.

Unless you have a grudge or concern about Plex™ Inc., then there is nothing better than PlexAmp. I cannot rant and rave enough about how good PlexAmp is. You will need one of their PlexPass subscriptions but my lifetime has paid for itself several times over.

It's an all in one server, plus apps, plus headless, with all the features you could want AND SOME MORE. Hey, you can even link up with your friend's plexes and listen to their music too. Oh, it also can host your video library on the side too but whatever.

It also uses a music DB for metadata so you don't even need to clean up most file's metadata as long as the folders and files are set up right.

### For the Super Nerds that Don't want to Plex

I have been moving away from Plex™ Inc[^2] since the company has been on a struggle bus since it's Pandemic peak.[^3] I am not saying _you_ should leave Plex, but I have enough of concern about them pivoting off being the best personal media server & client to justify experimenting with newer setups.

[^2]: Post Pending, I swear. I have been trying to write this one for months

[^3]: There is the forcing once free features behind paywalls, layoffs after layoffs, removing features from the server, the never released multi-room sync for PlexAmp they talked about in 2021, getting hacked three times, major exploits int he server, the constantly pushed back server rewrite, the disastrous client rewrite, the push of "social" features sharing activity that was only private before by default, the massive push to be a media streaming hub for their own and other major platforms content…

This my current setup is a whole article of content unto itself but I thought I would at least highlight my workflow.

1. Run files through Musicbrainz Picard to tag & sort
1. Rare/Too indie files get cleaned up manually
1. rsync them up to my server
1. Navidrome runs in a container
1. Caddy acts as a https reverse proxy
1. unbound + pi-home is a reverse proxy w/ split horizon dns to route
1. Script running every hour to update public dns at DNSimple
1. Feishin on the desktop to play
1. Ampfery for iOS and Carplay
1. Music Assistant with [Snapcast](https://github.com/badaix/snapcast) to do multi-room audio
