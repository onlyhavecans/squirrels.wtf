---
date: 2016-05-02
title: "BaaS: Burnout as a Service"
slug: baas-burnout-as-a-service
categories: [musings]
---

I wanna take a moment to to address what I like to call **Burnout as a Service; how I see burnout as a product of the tech industry and culture**. My friends, coworkers, and I have all experienced it in various levels, sometimes to crippling physical side effects. In this article I'm going to use strong language like _need_, and _should_, and _I won't work with you if you \[don't|do\] $thing_. While I have strong opinions about this subject and feel I have developed a powerful framework for helping avoid burnout it’s bound not to be perfect or complete. I do study this subject at great length in the name of personal development and productivity/energy management so if you have thoughts, opinions, feedback, or insights further into this topic I'd be happy to hear about them in the comments.

I'd like to point to [this article](http://blog.lusis.org/blog/2016/04/28/the-flaw-in-all-things/), written by an amazing operations expert who has reached the jaded level where all things are approached solely by the perceived possible failure points, causing decision paralysis. Having lived the fear of doing for the failure it may cause down the road it I personally identify with this brand of burnout myself.

In my experience I have come to see burnout as a product of our tech industry's culture more than anything else. There is a lot of different little causes that all stack up on each other; the fast evolution of technology, the constant threat from bad actors, high stakes companies built on investors, product first revenue second business models, fickle customers caused by untested in market products, unheard of before uptime requirements on hastily developed systems, etc. The list could go on listing reasons why the industry itself is a primary source of maximum energy drain.

My mother is a healthcare worker who often asks why I make as much if not more than her working on computers. I often have to remind her that every moment, at work or not, I can be more or less responsible for the shut down of an entire company's revenue stream (possibly permanently) not just through negligence but from lack of anticipating the next failure or attack and guarding against it properly.

Let that sink in for a few moments. As an Operations Engineer or Developer not just my negligence but my lack of constant vigilance, research, and forethought can destroy an entire company. From bugs that open security holes, infrastructure mistakes that allow hidden-until-failure single points of failure, to a seemingly solid design choice that causes massive cascading failures in ways I never expected[^1]. Let's not even address what happens when someone makes an oops uh-oh and that backup you _really_ need is coming back corrupt.

However all this is the nature of the industry we buy into often with the understanding of that this is how it works. I love having a job where mentally jogging day in and day out to keep pace or even get ahead of developing technology and security vectors. This is my great mental stimulation and when I tire of it I'll go pour drinks at a bar.

However we all need to both expend and recover energy in equal amounts. This is a core biological imperative that we don't often think about. Our desire to always be creating (which expends great amounts of mental energy) drives us all to burnout. An amount of rest and recuperation in equal volume and type to our expenditures needs to be done regularly. So many of us ignore the daily, weekly, and monthly cycles of stress and rest that are necessary to work at peak optimal shape. Instead we push for days, week, or even months to try to reach a constantly moving goalpost with a promise that we will someday maybe take that vacation we need. This is only assisted by our 24/7/365 pagers and systems that take no rest, constantly waiting to fail or fall over from the ever present threat of bad actors or full hard drives.

I have watched pager fatigue alone completely destroy someone mentally. A poorly managed monitoring system that pages over things that aren't absolutely actionable and urgent or doesn't soft notify well enough in advance things that could be resolved before they become a critical issue is psychological abuse when delivered at the right volume. If someone can't disconnect because of the ever present pages that may or may not be actually actionable and critical then they are being slowly tortured, nerves frayed down with the rasp of their own phones.

At an even higher level I think we actively foster burnout amongst our peers and even ourselves with this great rockstar solo act so many of us pull. The concept of the Bastard Operator From Hell (BOFH) is the singlehanded "everything IT" person who has built everything from ground up and maintains everything even in the face of his users "always breaking everything". Because of this they become so jaded that they begin to torment their own end users and customers for mental relief. The worst part of this is we have formed a whole worship culture about being the lone gunman tech asshole to a point where I have seen a lot of people glorifying and emulating it well above and beyond their own time.

If we built up the proper support systems both mentally and technically we would be able to weather the storms the environment and systems rain down on us much better. If we worked together as much as possible instead of competing we would be well armed against the ever-present threat of burnout. It tends to be a lot to do with the personality types we pulled to technology for years; high on technical knowledge, low on social skills, lots of communication through digital means and not a lot of interpersonal interactions. Mix this in with the E/INTJ Type A personalities that are drawn to this higher stakes world of startups and high payoff companies and we develop this culture where we think everyone needs to be a rockstar or a ninja. We slim down staffing and just "hire the most brilliant mind in tech" to not just design but also implement and support these companies ad infinitum or more realistically, until they burn out, quit, or both.

I understand staffing is expensive and money is tight when your product is still only on the verge of success but in so much of operations and development we are paid to think, not to turn cogs. We design, develop, and foster ideas and solutions to problems no one else has solved. These kinds of ideas are not easily grown in a vacuum, but best cultivated through discourse and experimentation. However difficult it is to measure these expenditures or notice when they are getting strained there are ways we can approach them that helps identify issues faster as well as spread the mental load out more safely.

The best thing that ever happened to me in my experience in operations was learning to foster an interpersonal technical rapport with my co-workers and keeping it open. Constantly jogging ideas back and forth, never letting myself, or them stick on a problem and instead kicking it out to jog between us. I've done it twice and now it's a job requirement for me. The ability to "pair up" with operations to constantly foster and develop the most efficiently.

You see a lot of this starting to bud up in the tech world these days actually;

- Open floor plans and chat based teams open up as much quick and easy discussion on issues as possible.
- Code reviews are becoming the norm not just in development but in several forms of operations[^2].
- The whole DevOps movement has large parts about enhancing communication and working together with others to help pool strengths and minimize weaknesses.
- Some parts of agile/scrum are all about raising concerns and roadblocks as quickly as possible to put them up to the whole group, not trying to stick a single developer to solve a hard problem.
- Pair programming is the next evolution of this, literally putting two minds to a single problem to solve it as efficiently and quickly as possible.

Even with all these trends though I still don't see enough of it, enough brainstorming, enough idea swapping, enough "Hey man I'm trying to do this like this but..." and that's why we are stuck staring at the flaws in every system. We work in our closed loops assuming that Issac Newton really did just sit under a tree staring at apples until he invented the Law of Gravitation so if we stare at our Apples and burn up all our mental energy the best way to handle this new package deploy will come to us. This is really where burnout comes from.

In closing I'd like to talk a little bit more about my mother. She's been a registered nurse her whole professional life. She's started in emergency rooms and for as long as I remember has been a hospice nurse. As you can imagine she's best at dealing with emergencies and the dying. Having dealt with the maimed and dying her whole life she's gone though mandatory on the clock grief therapy all of her professional life as well. In heath care when you deal with extreme emotional situations they regularly put you through therapy to help deal with and recover from what you work with. Whenever I ask someone who works about it it feels obvious to them that someone put though that level of emotional strain regularly would snap and do something horrible if they didn't receive regular emotional therapy. So as someone who goes through regular mental strain what are you doing for mental therapy to prevent your own burnout?

----

## tl;dr

In my opinion burnout is a natural product of the tech industry culture. In order help combat this you need to do all of the following, which is not a panacea but a powerful preventive framework;

- Work with others to help solve problems instead of trying to be a rockstar and solve them all yourself.
- Create review processes around configuration and software changes so that you have reduced liability and risk.
- Work with someone to develop intelligent alerting as well as a support rotation that allows rest and relaxation cycles as frequently as possible to reduce pager fatigue.
- if you have critical failures more than once a quarter you need to review your infrastructure & procedures and ask yourself what your company is doing that's more important than having a reliable, usable product.
- Rest yourself mentally every day, take breaks when you are locked in to a problem, and take regular vacations.
- Bring in as much positivity to your workplace and your life as possible.
- Fight negativity by analyzing it down to its root causes instead of superficially dismissing or accepting it.

And I hear you saying it already; "_This isn't important right now_", "_I/we don't have the bandwidth for this at the moment_", "_I'm doing fine right now_", or the worst "_I'm not gonna burn out_".

But know that when you _do_ burn out I can promise you that you _absolutely will not_ have the bandwidth or mental energy to do these things. By the time you are so far into burnout you actually become self aware of it deadlines will have slipped, everyone's already jaded and unhappy, and maybe you won't even care enough to implement this change.

[^1]: I have some amazing stories about Sybase databases running on a failover Sun Cluster using Veritas Volume Manager and the catastrophic problem with SCSI-3 reservations preventing disks to randomly not be mountable during a fail over event caused only when the LUNs are provided from newer NetApp hardware. Long story short, the database will start without half it's disks and it is not a pretty sight where it goes from there.

[^2]: The third best thing I have ever done in my career so far was take all of a companies critical configurations (haproxy, dns, maintenance crons, backup scripts, monitoring, ect) and put them in git, created a code review process, and used jenkins to deploy to production. Call it CI/CD, call it change control, call it whatever you want; I call it almost never again making that one line stupid oops uh oh that breaks an entire system again.
