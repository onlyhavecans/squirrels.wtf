---
date: '2026-01-19T19:00:00-08:00'
title: 'Just Enough Nix to use NixOS'
description: Or, if you can configure NeoVIM, you can configure NixOS.
draft: false
tags:
  - nixos
---

> [!CAUTION]
> this flow is so bad rn and needs refactor

This is part of my series on making NixOS more accessible to beginners. One of the big walls people mention when I talk to them about NixOS is that you have to learn a purpose-built functional language just to use NixOS. But I don't think you need to learn that much of it to get started.

Back when I got started with Chef-Infra (or Opscode Chef back then), there was a presintation and then a post called "Just enough Ruby to use Chef," and I wanted to pay that forward by writing what I think is "Just enough Nix to use NixOS."

There is already an official language reference I am linking to here, which is actually really short and amazing to keep around. However, when I go through the full tutorial, it quickly gets out of hand and teaches you a lot about how to do many things that fall right into the "things you can learn when you need it" category.

So let's take a walk through the basics.

DISCLAIMER: This is a "just enough" guide. I am not going to explain the nuances of the language, and I will use many analogies that do not perfectly match. If you have feedback on how I can improve the post because of any gaps or maybe better analogies that would make sense to system operators with minimal programming experience, please hit me up. I am not interested in your "Wells."

DISCLAIMER: Ok, sorry, another one. All of my NixOS posts are written for someone who is comfortable operating Linux-based systems at the CLI, using version control, editing various configuration file formats, and who has at least dabbled in programming/scripting. I would consider all of these prerequisites for learning NixOS in 2026, unless you wanna hit the deep end of the pool hard.

## Part 0: The Lingo

Every time we talk about Nix or NixOS, we need to go over some important lingo, since it has some confusing gotchas. This is all grossly simplified, but simple is where we are going here.

* Nix: A purpose-built custom language for packing and defining things
* Nix Package: A definition on how to build a software package with Nix
* NixPkgs: A massive collection of Nix Packages
* NixOS: A Linux distribution that uses NixPkgs as its package repo and Nix as its configuration language
* Derivation: A version of a thing built with Nix
* Nix Store: The place where all your hardrive space goes. I mean the Derivations go.

## Part 1: Spicy JSON

Nix is kinda like spicy JSON. It's spicier because, even though it looks and behaves a lot like JSON, you'll find a lot of lil fun extra functions that add all sorts of herbs and spices, and when all marinated together, can become hard to read for a newcomer.

Because it can get complex, I recommend starting out by looking for the json in it! Because every Nix file is a single JSONC object! (not really but work with me here)

```nix
# It can look just like JSONC in its most basic form
{
  programs = {
    fish.enable = true;
    tmux.enable = true;
    direnv = {
      enable = true;
      silent = true;
    };
  };
  # Don't change this
  system.stateVersion = "25.11";
}
```

Now, that's easy peasy, but you will only rarely see anything that plain in Nixland. We need to add some spice, and my first bit of seasoning is: I think we should clarify that every Nix file is not a JSON object but a JSON function.

Exciting right?

## Part 2: Functional JSON

That's right, all of our JSON objects are lambda functions and can contain other functions. If you never mastered lambda, then don't fret too much. We will try to keep it simple. A lambda is an anonymous function, meaning we never bother to name them. But you can pretend the filename is the function name if you want. Nix won't, but that's not going to stop you, is it?

In the above example, we are ignoring everything passed into our JSON function, so we left out the argument list. I personally avoid doing this because it's too implicit for me. Instead, I would write the above code like this, which explicitly says "This is probably gonna receive something, but toss it." Kinda like how Go uses _.

```nix
_: {
  programs = { ... };
}
```

Some people also write this, which is basically a smidge more verbose by saying "I expect a set, but like... ignore it."

```nix
# the dots mean ignore everything not defined passed in
{...}: {
  programs = { ... };
}
```

So now I am being clearer about how spicy my JSON is and showing that I am ignoring everything that my JSON function is being called with.

But we rarely ignore everything we pass in. In fact, we are usually needy, needy programmers and operators, and we want the world and free API access to it while we are at it. While I can't give you a GraphQL endpoint for your mailbox, we can at least declare what attributes we need passed into our function.

```nix
{pkgs, ...}: {
  programs = {
    fish = {
      enable = true;
      package = pkgs.fish;
    };
  };
}
```

We leave that `pkgs.fish` bare when we use it, as we would with any good variable. Easy enough? So if we want to install a big pile of packages directly without all that fancy configure/enable nonsense, all you need is a JSON array of pkgs like this!

```nix
{pkgs, ...}: {
  environment.systemPackages = [
    pkgs.curl
    pkgs.dig
    pkgs.file
    pkgs.nmap
    pkgs.psmisc
    pkgs.rsync
    pkgs.tmux
    pkgs.trash-cli
    pkgs.tree
    pkgs.unzip
    pkgs.watch
    pkgs.wget
    pkgs.whois
}
```

Wait what? That's... not a JSON array? Where are the commas? Also, there is too much repetition! I have to type packages over and over? I really hate that! Your analogy was filled with LIES.

## Part 3: How to Type Less

All right, I'm sorry, you got me. We have already broken a bit of our spicy JSON analogy. If you look back at the reference guide, you can see that we don't have arrays, we have lists, and lists in Nix don't have a comma.

But if you promise to forgive me for my faltering analogy, we can get into some language constructs designed to save typing that you will see a LOT of. Ok? Awesome. Thanks.

The first one is for drying up lists. Nix is very purpose-built, so it has language constructs for handling features you find specifically in Nix code. And since you often need to define a list of things like pkgs, we have a shortcut.

```nix
{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    curl
    dig
    file
    nmap
    psmisc
    rsync
    tmux
    trash-cli
    tree
    unzip
    watch
    wget
    whois
  ];
}
```

Our with does us the favor of slapping pkgs in front of everything in our list! How nice of it. There are plenty of other ways you can use it, but when getting started, it's best to use it sparingly because my explanation of with is a convenient half-truth; it actually introduces pkgs into the scope of that list and into complex code that can DO THINGS or even NOT do things. But that shatters too much of the spicy JSON analogy, so let's not get too deep into that and remember that you can get weird with it.

Also, here is a bonus: if you ever see something like this, it's a functionally similar version of with. It applies the thing to the arguments passed in.

```nix
thing @ { arg, otherArg, ... }: { ... }; 
# equals
{ thing.arg, thing.otherArg, ...}: { ... };
```

For some reason, you can write it like this, and it does the exact same thing, just because... we wanted to make it just a smidge confusing.

```nix
{ arg, otherArg, ... } @ thing: { ... };
```

I personally only use this in flakes, which we are not gonna talk about here, but it's good to know since you have a high likelyhood of seeing it.

## Part 4: Talking about Types

Ok Ok ok, ok. OK! We've already reached the point where the analogy is crumbling out from under us faster than we can shift it, so let's just talk directly about Nix when applied to NixOS configuration.

You will start with a configuration.nix file something like this

```nix
{config, pkgs, lib, ...}:
{
  import = [
    ./hardware-configuration.nix
  ];

  programs = {
    fish.enable = true;
  }

  networking = {
    useDHCP = lib.mkDefault true;
  };

  environment.systemPackages = with pkgs; [ 
    vim
    firefox 
  ];

  # Don't change this
  system.stateVersion = "25.11";
}
```

and I think the best thing is to is break down some important fundamental types and concepts.

> [!CAUTION]
> Blow this up and make it parts with explinations

```nix
{config, pkgs, lib, ...}:
# ^ Like we learned earlier this is a set, and it defines what arguments our 
# function expects, with ... being ignore everything we don't demand
{
  import = [
  # ^ import is a built-in function that loads and returns a nix expression
  # That's a fancy way of saying it loads our nix file
    ./hardware-configuration.nix
    # ^ Nix has a type for filepaths. they don't have quotes and start with
    # ./ for relative, ~/ for home and / for absolute
  ];

  programs = {
  # ^ everything else is a nixos option
  # look these up at the https://search.nixos.org/options
  # or https://mynixos.com
    fish.enable = true;
    # ^ You can collapse options with a .
    # or write them out with all the = { of your dreams
  }

  networking = {
  # ^ more options
    useDHCP = lib.mkDefault true;
    # ^ using an atter to set a default state (more below)
  };

  environment.systemPackages = with pkgs; [ 
    vim
    firefox 
  ];

  # Don't change this
  system.stateVersion = "25.11";
  # ^ this is a normal string, but you can have multiline strings with '' ... ''
}
```

## Bonus: If you use NeoVIM and a plugin manager, read this

When I got started, Nix felt extremely similar to NeoVIM's Lua-based configuration format.

I use Lazy.vim to configure NeoVIM plugins, and a common pattern is to create a plugins folder with various Lua files that all look something like this.

```lua
--langs.lua

local ensure_installed = { "bash", "vim" }

return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function ()
      require("nvim-treesitter").install(ensure_installed)
    end
  },
  -- Ansible
  {"mfussenegger/nvim-ansible", ft = "yaml.ansible" },
}
```

This language has patterns similar to Nix in some cases. especially the ones we have been talking about. Do you see what I was talking about? Mentally, Nix was kinda like Lua for me when I was getting started! No? Well, fine, whatever.

## Part 5: Saving more typing with local variables

Ok, y'all. I appreciate you having read this far, but it's time for me to get mean. Downright rude. Not at or about you. No. I have something rude to say about Nix. Every seasoned Nix person has their hill that they want to die on about some level of the experience, but this is mine.

Have you ever thought LISP was too easy to read? No really? Have you ever sat back and thought, "All these symbols are great, but let's make the lexer also do JavaScript-style keywords smashed into the middle of lambda declarations?" That's where we start talking about variables.

In short, if you want to have local variables at the top of your function to help collect magic numbers and other pieces of information you want to be able to reuse, you use a let ... in. It works like this.

```nix
{pkgs, ...}:
let
  fish_enabled = true;
in
{ 
  programs.fish.enabled = fish_enabled;
}
```

See how the let and in are all smushed in between the arguments set and the body? I tend to use a lot of whitespace here to make it clear, but on a single line, as it looks like {pkgs, ...}: let foo = true in{ bar = foo }

Ok, ok, that's not the worst example, but the more you work with Nix code, you will see let ... in blocks nested deep in places. That example is actually a bit painfully simplistic and doesn't really explain why you would want to use let...in blocks at all, so let me give you another example.

```nix
{ pkgs, vars, ... }:
let
  wg-file = f: {
    configFile = "${vars.home}/Documents/${f}.conf";
    autostart = false;
  };
in
{
  networking.wg-quick.interfaces = {
    home   = wg-file "home";
    office = wg-file "office";
    dc8    = wg-file "dc8";
  };
}
```

See how we can combine this to define functions to reduce code duplication? That wg-file function could be making a very complex data structure, which is something you will see when/if you start making your own Nix Packages (one step at a time, I know, right? lol.

## Part 6: Nani the F#&% is this?

Nah, you know what? Let's get REALLY complex with it! Hit you with the firehose! This is a concept you will see in NixOS known as an overlay.

```nix
# Here we are omitting one of the {} in a chain for what is called a curried lambda 
# think {final}: {prev: let ... in{ ... } }
_final: prev:
let
  owner = "netbirdio";
  repo = "netbird";
  version = "0.64.2";
  rev = "v${version}";

  # Shared source (both packages built from the same monorepo)
  src = prev.fetchFromGitHub {
    inherit owner repo rev;
    hash = "sha256-MwR+4StGDYp/P25JfH82i78lpSAj1yyIjaOVq8g3T0U=";
  };

  # Shared Go vendor hash
  vendorHash = "sha256-n0s2K+qbMiNfbkPbqvvXpvFvL5PkCkuJJ2CH3bEUCOk=";
in
{
  # Pin netbird and netbird-ui to a specific version
  netbird = prev.netbird.overrideAttrs {
    inherit version src vendorHash;
  };

  netbird-ui = prev.netbird-ui.overrideAttrs {
    inherit version src vendorHash;
  };
}
```

If you take a deep breath, you will note the only thing here I haven't mentioned before is inherit. This is another one of those things where we "push things around in scope," like with and @. However, you can write it out manually if it looks too confusing.

```nix
{
  netbird-ui = prev.netbird-ui.overrideAttrs {
    version = version;
    src = src;
    vendorHash = vendorHash;
  };
}
```

You can even be more clever with inherit, but I will leave that to your exploration.

Beyond that, what is going on there?

It's overriding the attributes from two previous (read: already existing in nixpkgs) packages to make our own derivation with our own hardcoded version, src, and go vendorHash! For the most basic Go package pin that's all you need to do. You can use this to force a newer version than nixpkgs is installing, or to an extent, stay pinned back. This is more of a temp hack than a long-term solution since somebody changing how the package is built, like one of the required libraries, would probably break our minimal overlay.

## Part 7: Let's talk about Gatcha

Not Gatcha games, these are gatcha's that will trip you up. Because it's a mistake I eventually made.

### Start simple

PLEASE start simple. A perfectly working NixOS setup is two files.

1. hardware-configuration.nix
2. configuration.nix

And the only one you edit is configuration.nix. But do yourself the biggest favor and put your nixos directory in version control so you have a rollback point when the file is bussid.

### Readable is better than clever

An old programming adage: clever code makes you feel cool, but nobody likes to maintain that Perl one-liner you wrote back in college that can bulk encode video files, parse all the ffmpeg logs, and reformat all the output into succinct colored output.

Nix is a domain-specific, declarative, pure, lazy, functional programming language. If you totally understand all those words and fear no LISP, then you have nothing to worry about. But for the rest of us, be aware when you are implementing things that you can't read later. You probably don't have to get that clever just to configure a few systems.

### The Danger of Importing

If you ever create an infinite recursion with imports, you will be in for a WORLD OF HURT and hard-to-decipher errors. Be very careful if you decide to experiment with many files and modules.

## Bonus: Questions I Asked, So Maybe You Will Too

### Why do we always end the argument set with ...?

Play around and find out. If you remove ... everything crashes pretty fast, and with lix, you get a pretty good error.

But, to phrase it in my words, when you define a function with {x, y}: you are defining the function expectation (read signature in programmer), and like most languages, if you pass in unexpected arguments to a function, the compiler barfs. So we put ... so any new unused inputs added don't barf everything.
