date: 2012-10-30 19:29
author: tBunnyMan
title: simpliFiRE.IDAscope API browsing on a Mac
slug: idascope-winapi-browsing-on-a-mac
tags: ida,mac

I know this isn't the most revolutionary tip ever but my google searches pulled up nada when I tried to figure this out. I'm an IDA Pro MAC user. Bastard child of IDA right? Not really, except for plugins usually which is the point of this short tips post.

If you are using [simpliFiRE.IDAscope](https://bitbucket.org/daniel_plohmann/simplifire.idascope) to help you dig through malware you are collecting with your bunnypot (and gods why aren't you?) you will bang against the WinAPI browser whining about the following error while searching for native windows calls[^VERSION]

    :::text
    Well, something has gone wrong here. Try again with some proper API name.
    Exception: [Errno 2] No such file or directory: 'C:/WinAPI/fs/createfile.htm'

While not directly documented the fix is _really_ easy. Just tweak your ```config.json``` file in the IDAscope folder.

    :::JSON
    "winapi": {
      "search_hotkey": "ctrl+y",
      "load_keyword_database": false,
      "online_enabled": true
    }

After you do this don't even restart IDA, just close the IDAscope tab and rerun the script. This trick comes with another fringe benefit; IDAscope will load in a _flash_ compared to the normal 30 second running, wait, almost... there... OK. The only disadvantage is that each search is now a web lookup but I don't think that's a horrible situation.

Now if I can only get the hotkey working right…

Happy hunting!

[^VERSION]: Of course I am assuming you are using version 1.0b (Released Oct 2012) or later, Otherwise you don't even have the ability.
