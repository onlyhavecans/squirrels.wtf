---
date: 2012-04-30
title: My Contribution to Calibre
slug: my-controbution-to-calibre
tags: [python, open-source, books]
---

## Backstory

When I bought my [NOOK Simple Touch™](http://www.barnesandnoble.com/p/nook-simple-touch-barnes-noble/1102344735) in January of this year I rediscovered [calibre E-book management](http://calibre-ebook.com/). While software always felt clunky in Mac OS X you could never deny it's power and sheer amazing once you got past the UI.

Being a big fan of ReadItLater I immediately tried to have the program pump my massive reading list into my Nook. To my dismay I discovered that the plugin was hardly complete. It piped my entire ~500 article[^size] reading list into a several megabytes large ebook and ordered articles from newest to oldest. Running the plugin a second time… produced the same results. It hadn't even the courtesy to mark articles as read.

[^size]: I should get my reading list under control. My situation with real books looks exactly the same way, stacks and stacks of the latest up read interests. I read plenty but the information overload fills the world; the challenge of sorting fluff from gold increases daily.

After digging about I found a few "close enough but incomplete" and outdated solutions along side plenty of complaints. You can't blame Calibre, the massive project's maintainers likely don't use the service like I do of at all.

## Solution

A python based open source project with something that I want improved? A bunny like me only can do one thing in a situation like this; reach back to grab one of my many 'cans', learn the [API Documentation for recipes](http://manual.calibre-ebook.com/news_recipe.html), and get my money out of PyCharm.

After a few days and learning more than just Calibre api,[^browser] I put out what I called ReadItLater V3 on to [my github](https://github.com/onlyhavecans/ReadItLater-Calibre-Plugin) and reposted it to [Calibre Recipes MobileRead Forums](http://www.mobileread.com/forums/forumdisplay.php?f=228). Other people picked it up and I ended up adding a few extra features per requests

[^browser]: [mechanize Browser](http://wwwsearch.sourceforge.net/mechanize/) and [Beautiful Soup](http://www.crummy.com/software/BeautifulSoup/bs3/documentation.html) are now favorites in my toolbox of handling and scraping web content, something I do more than any bunny should.

All was good with the world.

## Reward

A few weeks ago Read It Later officially rebranded to [Pocket](http://getpocket.com). This prompted me to pull up Calibre and check my plugin was working… all clear. Then, since I like to cover my bases, I pulled up Mobile Reads and dug around… and that's when I found it.

[**Calibre merged my version into the official trunk**](http://bazaar.launchpad.net/~kovid/calibre/trunk/revision/11867.1.2).[^linkchoice]

This invigorated me to put my all into the project. However, all I really managed was the branding, some code cleanup, and docs. Pocket wasn't ready to give out their new API to small beans like me. At one point during this Calibre devs merged in someone else's but quickly pushed my [latest version](http://bazaar.launchpad.net/~kovid/calibre/trunk/revision/11935) once I completed it.

[^linkchoice]: While this link only shows one part of the merge I chose it because it showed when they merged in my name to the top. Eventually they replaced the whole thing with my version.

I find myself flattered to have my code and name, even my pseudonym, in such a prestigious python project. Some of my friends felt my accomplishment was mediocre at best but I reject the haters. I've actively contributed to widely used open source. I don't get a ton of warm fuzzies from my wins but this was one of those times. I'm still stoked as hell and hope that I can do it again.
