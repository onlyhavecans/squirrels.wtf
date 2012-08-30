date: 2012-08-29 21:26
author: tBunnyMan
title: Honing my Git-Fu Part 1
slug: git-fu-01
tags: git

## Backstory

My git-fu sucks. I have to use an awesome git tool called [SourceTree](http://www.sourcetreeapp.com/) to do the git wizardry that I do. It's totally free and for the Mac so if you want to just jump into git and have expert features clicks away go download this. I bought it back when it cost money but now you can have it for free. I'll wait… 

Anyways, I've been rolling around in the lap of GIT/SourceTree luxury these past months; clicking away and using features I only wished SVN could ever touch. However when jumping around between machines and VMs it would be faster to just use the command line. Now a days I'm now on the development team of a well sized open source project and having to fumble around git & github while testing submissions and making patches to help other people test is just NOT COOL. I think it all came to a head when the main project maintainer started flaunting some of his git-fu when submitting and fixing patches… well honestly since I just love cramming as much into my head as possible I thought I would hone my git foo. 

Now back when I bought the [McCullough and Berglund on Mastering Git - O'Reilly Media](http://shop.oreilly.com/product/0636920017462.do) video's while they were on stupid sale and decided to double up with the newly released version of [Version Control with Git, 2nd Edition - O'Reilly Media](http://shop.oreilly.com/product/0636920022862.do). Time to get my learn on.

What? Studying DISASM, Developing software, working a full time job AND now deep studying a VCS is too much? PISH, I'm single and have the time.

## The point

SnowLprd wanted me to get some documenting on and take notes on what I find useful. Over the next month or so I am going to litter this blog with some posts on the "next steps" for git. While I organize my thoughts and really get my git-fu on it may be a bit all over the place. Sorry to anyone who finds this too rudimentary at points but I am going to try to focus on skimming the core concepts while posting lots of gotcha real world commands and why you would use them.


## Starter Commands
I'm not gonna put up how to clone a repo here. SRSLY if you haven't gotten past 101 I'm not going to be useful. This is supposed to be 105b.
	
	git remote set-url origin git@github.com:tbunnyman/pelican.git
	git remote add upstream git://github.com/getpelican/pelican.git
	git remote add MyExBF git://github.com/justinmayer/pelican.git
> Ok, so this one could be obvious but double check to make sure you have everything linked properly. You want the the R/W link to any repos you are pushing to. You might want to change your auth or connect style if you've say… been made a repo maintainer. For sakes of safety/neatness you should still treat your upstream as R/O and make all your changes in push requests and patches. Also add the R/O of your major contributors and co-developers so you can test their patches easier.

	git pull upstream master && git push origin
> There really should be a shortcut in this for git. Maybe I'll discover it later. I don't do my work on getpelican/pelican, I have the tbunnyman/pelican fork! Each time I want to work on something I branch, code, commit, push, pull-request. It's an endless cycle. I never really touch my master, I just want to keep it up to date with the upstream. I don't know an amazing shortcut for that so the above micro shell script does the trick.

	git push origin --delete <branchname>
> I branch for every single patch to maintain tree neatness… however this becomes ugly fast on a good code month. This quickly dumps a branch and deletes it from github. Don't do this before it's been merged into master though, you are asking for pain the first time you make that mistake. Try to remember, branches aren't too expensive disk-wise so don't g too crazy on deleting them.

	git add -p <file||.>
> Don't add whole files to your staging area! Jeez! Who does that anymore! Be 37337 and review every change you make as you add to staging by committing at the _patch level_ instead of at the _file level_ by using the -p flag

	git log HEAD^^ -p
> This one took me a minute to figure out. So `git show` shows the patch for the _last_ commit with patch if applicable but what happens when I want to spew the patches from the last three commits on someone else's branch to get a quick idea of what they are fuffng up? This one! Don't blindly follow my `^^	` syntax either, learn about it below.

	git commit --amend -c HEAD && git push --force
> Ok, for bigger things --fixup or --squash might be better but when you open up a PR and instantly realize you are a total moron and everyone is gonna see how dumb your are because of your misspelling/typo/misscommited line… this squished one liner will recommit your quickly staged fix (letting you tweak the commit message in case that's your problem too) and replace your commit in the Pull Request with this much more awesome one.

## Concepts to think of

	Revision bad4dad
> All revisions are named with SHA-1's of the actual commit contents. Then it uses something called treeish to sparse that down to the first 5-8 unique (to the repo) hex. That's why your commit's name is `bad1dea`. Obviously since repo's are distributed there is no way to create linear counters so all repo's are actually a **linked list** of commits. Everything from branches, to tags, to HEAD is just pointers to SHA-1.

	HEAD^
> Now then what's the `^`? Well everyone knows `HEAD` is an alias to the most recent commit. Well you can add the `^` to any repo name and it's now the previous one. So `bad1dea^` means the previous bad idea, while `HEAD^` literally just means the previous commit. What's better is it's stackable `HEAD^^` is two back. Now you probably don't wanna stack 10 `^`'s so just use the shorthand `HEAD~10` for ten revisions back.

	b4dc0fee..d00d
> Ahhh? History is a Linked list! so this traverses the linked list and returns all the revisions! Good for putting together a change log. To just see the last two commits `git log HEAD^..HEAD` Yea? Thats the cool stuff. 