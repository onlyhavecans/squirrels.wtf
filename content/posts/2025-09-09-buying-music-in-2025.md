---
date: 2025-09-09T12:37:19-07:00
title: Buying Music in 2025
draft: false
tags:
  - music
  - self-hosting
---

Recently I wrote about [bandcamp]({{< relref "2025-04-29-use-bandcamp-but-dont-trust-bandcamp.md" >}}) and [[why I buy music in general]], but I thought I would also add, HOW do I buy music right now.

All of these options offer fully drm-free music files without any proprietary formats or anything. This isn't about kracking or anything. It's about ways I can give money to download music that I can use however I see fit whenever I see fit..

## Where I Buy Music

### Top Pick Bandcamp

Currently the best way to buy music… if they have it.

Format: Too many to choose from (but I recommend FLAC or MP3 320)

The Good:
- Lets you listen to an album several times before you buy even
- stream your music right from their page… for now
- Big Money to artists
- All the formats you could want
- Excessively HQ files, some even fancy 24bit

The Bad:
- Very few major artists (but you would be shocked who you will find)
- Their discover is ruined these days.

The Ugly:
- Artists can reupload and edit albums after published. What version is up now? who knows

### Pick #2 Itunes Music Store

Yes, this somehow exists still, but BARELY. You have to open up Apple Music, find the preferences, enable it, then go it the new icon. and GOD FORBID you mistake iTunes Music store with Apple Music subscription.

But the quality, selection, and price make it worth the annoyance

Format: M4A 254

The Good:
- M4A is well supported and decent quality
- Amazing catalogue with albums and singles impossible to find elsewhere
- The best for international releases I have found

The Bad:
- The preview snippets are embarrassing in 2025
- How apple puts the album cover isn't supported anywhere so I have to fix them all manually.

The Ugly:
- You have to use their "Apple Music.app" which is a tyre fire
- Store is slow and sluggish and no multiple tabs
- lots of download problems requiring several app restarts and redownloading

### Pick #3 Amazon

Format: Variable Bit Rate MP3

The Good:
- second largest mainstream catalogue to iTunes
- Everybody loves an MP3 Files

The Bad:
- When you click play on a track or album to preview it shuffles the current album and plays a random track?!

The Ugly:
- Amazon
- Artist pages cannot tell between multiple artists with the same name.

## Pick #4 Direct from Artist

this has been such a tyre fire of bad experiences. I really wish i could endorse this more, I really want to but I have bought music from the following artists directly and only once has it gone well..

1. Gary Numan: No complaints
2. My Life with the Thrill Kill Kult: All files raw wavs with no tagging I had to flac and tag myself
3. Aphex Twin: More expensive than anywhere else and charges based on quality
4. Nine Inch Nails: paid huge shipping to send me a CD
5. Lady Gaga: initially never delivered, had to push support
6. Chance the Rapper: Tracks omitted from album and renumbered

Formats: ??? It depends

The good
1. Most money to artists
2. Sometimes the only place to get a HQ version

The Bad
1. Inconsistent to what you get
2. Prices all over the place
3. Buggy app stores
4. Pages not even saying what format you are paying for
5. No preview before listen

The Ugly
1. Incomplete versions of albums
2. Good luck finding anything but the latest album
3. Welcome to a dozen mailing lists

### The New place I Am not Sure About: Qobuz

I have bought exactly THREE album from Qobuz so far to give it a try. One thing I like is that they are claiming to have tonnes of albums from major labels in lossless formats.

To try it out I bought a Nine Inch Nails album when i realized one of my very old MP3's had a glitch in it.

Then I found out they have some Orbital singles that are not on Orbital's Bandcamp.

I am not 100% ready to recommend them, but they might be the pick just below Bandcamp, again if they have it. My one issue is they are the most expensive of them all and I am not sure how above board they are yet.

## The Fallback: Used Media

Sometimes you just can't find sold digital for reasons.

Something like Discogs or my local Zia Records suddenly becomes amazing. I can pick up good "play copy" of an album. Play Copies are used albums that are in good condition, but not good enough to appease a collector.

Then rip it like it's 2003

## Segueway: File Quality

Why should anybody care about FLACs and or 24-bit audio?
Well, IDK about yall, but I have my reasons.

I prefer FLAC files because they are 1) Uncompressed 2) Open format

This means they are of the highest quality I can get music, and being open means that I never have to worry about being able to open it because all software can freely use it and the standard and libraries are openly available[^1]

And I care about having uncompressed high bitrate music because when i stream it to my phone or computer, it encodes it down, and I would rather have a copy of an original uncompressed version than a copy of a copy with artifacts of artifacts.

[^1]: You can open FLACs anywhere EXCEPT Apple Music, they don't support it even though there is no technical or legal reason stopping them. Mostly just because they made their own closed version ALAC.

## But… How Do Play Music?

The easiest way to enjoy your digital music before everything became mobile and phone based was that you created a music folder on your computer and like, dumped all the album folders into it. or maybe organized them like

```text
music > artist > album > coolfile.mp3
```

And if you wanted music on the go? Burn a CD or spend all the money in the world on an iPod or Zune but that doesn't cut it anymore.

We need phones and ALL OF OUR MUSIC ALL THE TIME.

I don't actually believe this. i think it's an interesting experiment to give yourself like three albums or 75 minute playlists and stick to that for a week. And if that's all you need… Music Players STILL exist and you can buy them and load them up with music.

But let's assume you want to be able to "stream" all your music all the time. Then files on your laptop are not going to cut it…

### A Solution for the Least Technical

I did some research for this one, I don't actually do this but it is from a dev of software I use.

Put all your music on some sort of random cloud service like Dropbox, Google Drive, Microsoft Drive, whatever.

Then point this $50/yr website at it <https://asti.ga>

Your own private streaming service and you don't even have to set up anything at home

### For Those Technical Enough to Have a Nas

Plex & PlexAMP.

For reals.

Unless you have a grudge or concern about Plex™ Inc., then there is nothing better than PlexAmp. I cannot rant and rave enough about how good PlexAmp is. You will need one of their PlexPass subscriptions but my lifetime has paid for itself several times over.

It's an all in one server, plus apps, plus headless, with all the features you could want AND SOME MORE. Hey, you can even link up with your friend's plexes and listen to their music too. Oh, it also can host your video library on the side too but whatever.

It also uses a music DB for metadata so you don't even need to clean up most file's metadata as long as the folders and files are set up right.

### For the Super Nerds that Don't want to Plex

I have been moving away from Plex™ Inc[^2] since the company has been on a struggle bus since it's Pandemic peak. There is the forcing once free features behind paywalls, layoffs after layoffs, removing features from the server, the never released multiroom sync for PlexAmp they talked about in 2021, getting hacked three times, major exploits int he server, the constantly pushed back server rewrite, the disastrous client rewrite, the push of "social" features sharing activity that was only private before by default, the massive push to be a media streaming hub for their own and other major platforms content… I am not saying any of these are reasons _you_ should leave Plex, but I have a huge concern about them pivoting off being the best personal media server & client… and I like to get out before the ship sinks.

[^2]: Post Pending, I swear. I have been trying to write this one for months

This my current setup is a whole article of content unto itself but I thought I would at least highlight my workflow.

1. Run files through Musicbrainz Picard to tag & sort
2. Rare/Too indie files get cleaned up manually in mp3tag
3. rsync them up to my docker host server
4. Navidrome runs in a container to host music
5. Caddy acts as a https reverse proxy
6. unbound + pi-home is a reverse proxy w/ split horizon dns to route
7. Feishin on the desktop to play
8. Ampfery for iOS and Carplay
9. Music Assistant with [Snapcast](https://github.com/badaix/snapcast) to do multi-room audio

## Segueway #2 Backups

I brought this up in the last article but for the love of everything that is holy have backups, have **tested** backups.

Licensing and BS means where you bought a file doesn't mean it will be there when you come back.

## Finally: what about Discovery?

Spotify got popular because it was amazing at shoveling fresh new music into your ears at an astronomical rate.

So what to do?

Honestly, youtube is where I check out new music usually. And Bandcamp lets you "follow" artists and entire labels to get notice when new music drops. I get a lot of music from that.

Navidrome has the ability to track all the music you play by sending a log to ListenBrainz. Now, you might think that sounds like a nightmare, but then ListenBrainz can provide you with playlists of recommended music for you to check out on YouTube or streaming platforms.

Also having music nerd friends to talk to helps.
