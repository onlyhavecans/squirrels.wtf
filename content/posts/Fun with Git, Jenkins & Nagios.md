---
date: 2012-09-07
title: Fun with Git, Jenkins, & Nagios
slug: git-jenkins-nagios
tags: [git, jenkins, devops]
---

Welcome to another edition on how to automate the hell out of your workflow.

## Preface

One thing I have been addicted to since I learned it was source control. I don't understand how some developers work without it… and I **really** don't understand how any syadmins live without it. I have actually found it _more_ useful as a sysadmin as a programmer, but only because at my day job I have used it in most of our major configs. Putting our 400+ file bind setup in subversion and using hooks to test and deploy our changes was not only a massive time saver but tail saver as well.

Another system that gets plenty of additions or tweaks is our [Nagios](http://www.nagios.org/) configuration. Server gets deployed? Nagios. New services? Nagios. Something gets moved? Nagios. The list goes on.

The problem is that at work the Nagios commits aren't so automated. You push to the SVN server, then go to the nagios box and then checkout to test your changes. This results in extra commits to fix breaks and just _work_. There doesn't need to be work!

## Getting to the point

The goal is to set up Nagios to have all it's configurations in git. Then I want Jenkins CI to test my commits automatically and push to production if they are solid! This was shocking easy to do with just a few gotcha's. I put this entire setup together in about a few hours, so expect possible areas of improvement.

### Step One: Get Your Install on

Install [Nagios](http://www.nagios.org/) and git. I'm not even gonna get into this, also if you haven't already throw java on the box. I'm going to demonstrate how to do everything on one box but it should be easy to break everything out onto multiple systems where needed.

[Jenkins](http://jenkins-ci.org/) might seem intimidating because it's java but it's not, really. I don't even bother with package installers, just grab the .war file from the website and `java --jar jenkins.war`.[^SECURITY]
You might want to set up an init script and play with all the features but I'm not going to cover that, it's all well documented on [Welcome to Jenkins CI!](http://jenkins-ci.org/). If you are setting this up on a mac server, I tend to steal my LaunchAgent plists from [Homebrew](http://mxcl.github.com/homebrew/)

[^SECURITY]:You'll want to set up authentication, general security, and maybe even want to restrict access by firewall to jenkins in the long run. Jenkins is a well tested system but left unsecured and open on the internet this system can be invoked to execute arbitrary code in a snap.

For simplicities sake, or to mimic me, set up jenkins running as the same user as nagios. In my case I'm going to give nagios it's own dedicated jenkins that can only be accessed by private IPs.

### Step Two: Git-fu

This was the tricky part but it will seem easy when we are done.

Start by initing your nagios configs;

```bash
cd /usr/local/etc/nagios
git init
git add .
git commit -m"initial import of Nagios Configs"
```

Now you will want to set up the "hub" repo. For sakes of simplicity I'm setting it up in Nagios' home directory but as long as Jenkins and you can reach it then you are solid.

```bash
cd ~
mkdir nagios_configs.git
^mkdir^cd^
git --bare init
```

Now we clone over our working data to the "hub";

```bash
cd /usr/local/etc/nagios
git remote add hub ~/nagios_configs.git
git push hub master
```

While we are in the nagios config directory lets script a hook so that when this repo pulls and updates its configs from the hub it automatically reloads nagios.

```bash
cd .git/hooks
vim post-merge
#!/bin/sh
echo Running  'killall -HUP nagios' to reload settings
exec killall -HUP nagios
:wq
chmod 755 post-merge
```

Now leave this repo/directory and NEVER RETURN unless you break the hell out of the repo.

Now we have enough so that you can clone the hub repo and work on your nagios configs on your local workstation git style before pushing them back to your git hub… HA! See what I did there? Sorry…

Now what about testing?! and automation!? How does the data get from hub back to your nagios configs? Well this is where Jenkins comes in.

### Step Three: Putting Jenkins to Work

First you need the Jenkins git plugin. Jenkin's plugins are quick and easy. I'll shortcut you to it just for completion;

- Go to `http://nagiosbox:8080/`
- Click on `Manage Jenkins`
- Click `Manage Plugins`
- Click the `Availible` tab
- Search for and select the `Jenkins GIT plugin`
- Click `Download now and install after restart`

Jenkins; It's just that easy. Now lets set up our tests and deploy!

- From the dashboard click `New Job`.
- Project Name: `Nagios_config`[^CAREFUL]
- Description: Whatever, not really important
- Check `Discard old builds`
- Set `Max # of builds to keep` to something reasonable like 5 or 20
- Under `Source Code Management` check `Git`
- Repository URL: is `$HOME/nagios_configs.git` or wherever you put this[^TILDE]
- Set `Branches to build` to `**`
- Under `Build Triggers` you want to check `Trigger builds remotely`
- You'll need to pick a token; I recommend keeping it simple but not guessable like `caronLovesBronies`
- I like to also set `Poll SCM` and set something like `*/30 * * * *` just in case something doesn't get triggered. I don't think it's necessary though.
- Under `Build` click the `Add Build Step` drop down and select `Execute shell`
- Now we have our box to type our Nagios config Test, `/usr/local/bin/nagios -v nagios.cfg`

[^CAREFUL]: I've noticed that if you put a space in your Jenkins project name it puts a space in the path to the "workspace" that Jenkins uses to test and deploy from. This can break things from time to time so to error for safe sides don't do this.

[^TILDE]: Don't use a tilde in Jenkins paths. It doesn't like them even a little bit. It probably has to do with it's cross system compatibility.

Technically that is all the Jenkins config we need to have it automatically clone the hub to it's own private repo and then nagios -v to test the config. All typed out it seems like a decent amount of steps but by the time you set up your third Jenkin's test you realize most all of that is boilerplate. Most of the time you spend with Jenkin's is checking to see why your build failed and sometimes tweaking tests for the environment. It's really a get set up and get out of your way kinda tool.

Now BEFORE we move on let's make Jenkin's do a little extra work and deploy from the hub to the live configs if the tests pass… oh crap you clicked save already didn't you… If you did just go back to the project and hit `Configure`.

Now Under `Build` click `Add Build Step` and add a _second_ `Execute Shell`. Then put the following unto it[^GITPULL]

```bash
cd /usr/local/etc/nagios
unset GIT_DIR
/usr/local/bin/git pull hub master
```

**Now** you can hit save

[^GITPULL]: You might be wondering why we have Jenkins go into the live config and run a pull from hub instead of pushing the configs to the live repo but that's just a nuance of git and most version controls that I have used. They don't like having things 'pushed' into them if they have a working copy. Only pulls will properly grab the changes and merge them into the working copy. That's why the hub we have uses the `--bare` flag. If You go to check out the hub repo you will see that it instead has the normal contents of .git just lying around instead of the normal files.

To finish off our super automation let's make it so that when anyone pushes to the hub it instantly triggers a build, test, and if the tests passes deploy. Let's just jump back to the command line to add a hook to our hub repo now

```bash
cd ~/nagios_configs.git/hooks
vim post-update
#!/bin/sh
echo "Sending build command to Jenkins"
curl -sSL 'http://localhost:8080/job/Nagios_Config/build?token=YOUR_TOKEN' >> /dev/null
exec git update-server-info
:wq
chmod 755 post-update
```

Note that with the curl line, if you enable authentication on jenkins you will need to create a user that has "build" level permissions and put it into that line. Also replace my example token with yours.

All right! Now we have it so that using ssh you can clone the hub repo and work on it. When you push back to hub it triggers Jenkins to build the tests. Then jenkins will take a copy, run `nagios -v` to test it, and if it passes it will tell the live config to pull the new updates… and once that is done the live config `-HUP`s nagios for us.

AMAZING!!! But not done yet.

### Step Four: Final Boss^WConfigs

Ok. This might seem just about perfect but there is a catch. The default Nagios config uses absolute pathing to all of it's files. This means we need to modify some of Nagios' configs to properly allow Jenkin's testing to read all the proper files.

This process _should_ be as easy as taking all the links at the top of the `nagios.cfg` file and just making them relative to the main config. For example, here is the head of my config minus comments;

```bash
$ egrep '^[^#]' nagios.cfg | head
log_file=/usr/local/var/lib/nagios/nagios.log
cfg_file=objects/commands.cfg
cfg_file=objects/contacts.cfg
cfg_file=objects/timeperiods.cfg
cfg_file=objects/templates.cfg
cfg_dir=systems
object_cache_file=/usr/local/var/lib/nagios/objects.cache
precached_object_file=/usr/local/var/lib/nagios/objects.precache
resource_file=/usr/local/etc/nagios/resource.cfg
status_file=/usr/local/var/lib/nagios/status.dat
```

Notice the gotcha in there!!! This one stuck me up for about two hours. **I was unable to get Nagios to accept any relative path for the `resource.cfg` file.** This introduces it's own gotcha but most people don't need to edit this too frequently.[^READ]

[^READ]: Yes I consider this be a major flaw, read the `CAVEATS` section.

To explain a few other lines;

```toml
cfg_file=objects/commands.cfg
cfg_file=objects/contacts.cfg
cfg_file=objects/timeperiods.cfg
cfg_file=objects/templates.cfg
cfg_dir=systems
```

This is referring to /usr/local/etc/nagios/objects. I store all the default config files in there, commands, contacts, time periods, ect.. However I choose to put all my actual system, switch, & device configs in `systems`. I store personal templates and copies of all the defaults for reference in `templates` and then when I want to add a new group of systems I just copy a template to `systems` and fill it out. No need to edit the `nagios.cfg` every time.

Here is the layout of my nagios config directory;

```bash
$ tree nagios_configs
nagios_configs
├── cgi.cfg
├── htpasswd.users
├── nagios.cfg
├── objects
│   ├── commands.cfg
│   ├── contacts.cfg
│   ├── templates.cfg
│   └── timeperiods.cfg
├── resource.cfg
├── systems
│   ├── chunkhost.cfg
│   ├── lazylopranch.cfg
│   └── shells.cfg
└── templates
    ├── printer.cfg
    ├── switch.cfg
    └── windows.cfg
```

## The End?

So there you go!
It's not perfect because of the listed caveats below. Someone malicious or even a sysop who is ignorant of the fragilities of the system can break it fairly easily trying to be tricky or cool. You could get around most of the git merge conflicts problems with hooks though.

The cool part though is this system is FAST. On a good build I push a change, by the time I can get to the web page to check the build it's already deployed to production.

There will probably be a follow up when I figure out how to make the setup a bit more solid, this really was a few hours of hack.

If you think I've missed anything feel free to drop me a comment.

### Bonus Points

#### Got Someone Who Doesn't Get Git and Can't Remember to Push? Hate the Extra Command?

Go into your personal repo and make git a little more SVN, for better or worse.

```bash
cd my_nagios_configs
echo 'git push' > .git/hooks/post-commit
chmod 755 .git/hooks/post-commit
```

#### How Do You Feel about Circular Dependencies?

If they are your thing then use the [Nagios Jenkins Plugin](https://github.com/jonlives/nagios-jenkins-plugin) to make Nagios check Jenkins and throw up alerts when your Nagios configs fail their tests!

### Caveats

#### Never Use Git Push --force

If you ever _ever_ **EVER** _**EVER**_ do anything that requires a `git push --force` on hub like an `--amend` then may god have mercy on your soul. You know how they tell you that `push --force` is bad and breaks things when you first learned git? This is that exact use case where it ruins everything. Just don't do it, the point of nifty automation is to make your life easier. Suck it up and let your tree be nice and linear, have mistakes, and be "bloated"; Git has some great storage ratios across lots of minor commits.

#### The Test Links to the Prod Version of resource.cfg

You are always testing against the live version of `resource.cfg`, which will usually be the HEAD^ version but if you break the build it could be even farther off. If you break the build on the resource.cfg file, the bad version will push, nagios will fail to restart properly, and then your NEXT build will fail in Jenkins and refuse to push so you will have to go into the server, test by hand, and then pull from hub manually. _**DAMN IT**_. I consider this to be a fairly major flaw that prevents me from wanting to deploy this in a professional environment.
