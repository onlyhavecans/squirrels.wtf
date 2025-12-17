---
date: 2014-07-14
title: Chef Frustrations
tags: [musings, open-source, chef-infra]
---

I've spent the last week working on implementing chef. The experience is frustrating to say the least. Instead of whining I wanted to take the time to write out some of my pain points and hopefully offer some constructive fixes to what I see as the wall in the learning curve.

Now to be clear up front. Most of my problems aren't with Chef, Ruby, or most of the core product; it's with implementing it. To be more precise I think the failure REALLY is documentation.

## Anti-pattern One: Getting Started (into a corner)

Also known as the "Just enough to be dangerous but not useful" anti-pattern

I really liked the new learn chef. I have to give them a ton of credit for all the work **but** underneath all the new splash and presentation it's still the exact same old Chef 101 it was two years ago; it teaches you the barest of all basics and then drops you off to docs.opscode.com

I know that most would feel that statement isn't fair, since it teaches you all about the design and system behind how chef works, and that it does; but it still feels like not enough to be useful and here is why.

## Anti-pattern Two: We Have no Patterns

Learn Chef teaches you how chef works but not really how to use it at any level of scale; There is no real world usage taught anywhere. It teaches you to set up a Chef Enterprise server and then re-inventing the wheel with a homemade apache or ntp cookbook, and push it all to a vm _but you would rarely do this in practice right?_

When you leave Chef's documentation you learn about many very important Chef Patterns;

- wrapper cookbooks
- berkshelf way
- one repo per cookbook vs monolithic repo
- application cookbooks
- service cookbooks

Why doesn't chef teach us these? Is this something we save for consultants to teach us at thousands of dollars an hour? Is it that Chef wants to avoid teaching patterns in order to remain as flexible as possible?[^APME]

[^APME]: I believe this is a horrible anti-pattern in documentation. If you believe your power is flexibility then you should highlight that but still outline some predominate patterns for your top two or three use cases.

It's not just chef either. Go to <http://berkshelf.com> and tell me how to use this tool assuming you've never done such before. If I was trying to remember a few commands or learn a new trick on top of something this tools docs would be great but it's missing the meat of what this tool is designed for and how to use it.
A lot of chef's tools are treated this way.

## Anti-pattern Three: …So Please Learn Everyone Else's Anti-patterns

This is my biggest frustration, OPD; Other People's Docs. As someone who has been working in Systems for 10+ years I have lived and learned so much from everyone else's blogs, which is why I feel the need to blog all my own lessons and information.

I feel that chef relies _too much_ on OPD though. Especially because chef is such a fast moving target. It's amazing how many people who use chef that I talk to that use it in some odd, bizarre, and or generally 'not correct' way. It's usually because they learned a bad habit from a predecessor or found a bug in a long ago version and found some OPD that convinced them that "_oh no you have to run everything chef-solo with your own special bootstraps, that is the ONE TRUE WAY™_". I'm not saying that patten doesn't work but I doubt it's the best way for many infrastructures.[^ACTUALLY]

[^ACTUALLY]: I know it's not the best way because they are deprecating chef-solo for chef-zero, which is _good_ but it's a great example about the speed that Chef is changing.

I plan on documenting plenty of chef like things myself; in fact I plan on posting as much of my own OPD as possible but with how fast chef evolves as a product and with the large variance of methods for different environments I really hope people take everything with a grain of salt and read the date on the post when considering my advice.

Here is a great example; where about 2014-07 I went into \#chef and asked about some methods for setting things up and was linked to [this blog](http://misheska.com/blog/2013/06/16/getting-started-writing-chef-cookbooks-the-berkshelf-way/) which is treated like a defacto example of how to do things. But read all those updates… and then notice how it's using a lot of deprecated methods. I was linked to an article that could be titled "How to develop some really bad habits, but learn important things while you are at it." It's not Mischa's fault, It doesn't seem like he is a docs writer for Chef. Honestly I feel the best thing that could be done is this document be updated to the latest methodologies and tacked on to the end of learn chef as "One good method to get your environment up and going".

As a chef user do you even know about chef-dk? you probably should take a break from what you are doing, [read this](http://www.getchef.com/blog/2014/04/15/chef-development-kit/) and then [do this](https://gist.github.com/lamont-granquist/40d26b6fa8178212594f). Seriously don't you feel much better? This also should be on the end of learn chef guide. Hell this should probably be the first half of the learn chef guide.

I get that maybe they don't want to declare a "chef way" to do things… but at least give us some better hints.

## Next Actions

Just to recap;

- I believe chef's biggest weakness is documentation, which creates a wall in the learning curve to hit right after "I can now build and deploy a test apache on a linode" and "I can build and deploy this in a staging environment"
- I think there should be a learn chef 200 series that goes over;
    - Using a wrapper cookbook, and the different types of abstraction you often see with these.
    - Teaching everything chef-dk adds; bootstrapping, runtests, and automated integration testing.
    - Highlighting several useful patterns for cookbook development.
    - Using more of chef's tools; ex ohai
- If chef is going to rely on the community for docs maybe it should create a way where they can contribute to the main docbase just like they do code.
- [go here](http://misheska.com/blog/2013/06/16/getting-started-writing-chef-cookbooks-the-berkshelf-way/), have your life changed
- If you are in the Las Vegas, NV area come hang out at \#lvdevops on freenode and tell me how I make you feel
- I'm going to spend another week or two trying different ways to structure my cookbooks and see what works.
