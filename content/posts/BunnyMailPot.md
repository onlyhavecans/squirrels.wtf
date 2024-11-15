---
date: 2012-11-06
title: "BunMailPot Alpha..."
slug: bunny-mail-honeypot-alpha
tags: [macos, malware, security]
---

Ok… so that is not the best name I've every come up with. Sorry, but whatever. This is a quick but fun one.

I have been collecting malware with my BunnyPot for a while and have been finding some diminishing returns coming to me. I started thinking that I can set up more of these low interaction server honeypots but how can I get even MORE goods? The ability to grab random files pushed to any server seems like a limited way here…

Then it hit me, actually dinged me… my email dinged that is.

Malware comes through the mail too, duh.

## The setup

This is hella… well you will see. It needs some cleaning up and maybe not to be relying on Apple's Mail.App… but seriously it's a super quick and dirty hack. It's not even ON the server, it's on my laptop at the moment.

### The mail rule

> Ok, I have mail… lots of it, all my work and personal and trash mail all in one app with nice aggressive mail filters… so lets get the malware out!

Just make a mail rule that is **all** of the following;

- Message is junk Mail
- Any Attachment name Does not contain ```.htm```

Now perform the following action;

- Run Applescript ```~/Library/Scripts/Applications/Mail/MalwareSaveRule.scpt```

WHAT'S IN THE SCRIPT?! WHAT'S IN THE SCRIPT!!!!!!!

```AppleScript
on perform_mail_action(ruleData)

  -- The folder to save the attachments in (must already exist)
  set attachmentsFolder to ((path to home folder as text) & "Downloads") as text

  -- Save in a sub-folder based on the name of the rule in Mail
  set subFolder to name of |Rule| of ruleData as text
  tell application "Finder"
    if not (exists folder subFolder of folder attachmentsFolder) then
      make new folder at attachmentsFolder with properties {name:subFolder}
    end if
  end tell

  -- Get incoming messages that match the rule
  tell application "Mail"
    set selectedMessages to |SelectedMessages| of ruleData
    repeat with theMessage in selectedMessages

      -- Get the date the message was sent
      set {year:y, month:m, day:d, hours:h, minutes:min} to theMessage's date sent
      set timeStamp to ("" & y & "-" & my pad(m as integer) & "-" & my pad(d) & "-" & my pad(h) & "-" & my pad(min))

      -- Save the attachment
      repeat with theAttachment in theMessage's mail attachments
        set originalName to name of theAttachment
        set savePath to attachmentsFolder & ":" & subFolder & ":" & timeStamp & " " & originalName
        try
          save theAttachment in savePath
        end try
      end repeat
    end repeat
  end tell

end perform_mail_action

-- Adds leading zeros to date components
on pad(n)
  return text -2 thru -1 of ("00" & n)
end pad
```

Simple ya? Nothing fancy, quick and kinda diiiirty. When this runs it creates a folder in your downloads that matches the name of the mail rule you created. I went with the hell creative _Malware From Junk_

## Processing the malware

Just like every other _this is how I process files_ thing I have written up this part is all in [Hazel](http://www.noodlesoft.com/). Seriously I can't praise this app enough. Go pay this guy money. Stop reading this, go buy, use, love, live.

We add our folder _which you remember is named after your mail rule_ to be watched by hazel… now lets start with the goods

Oh and disable Throwing away duplicate files, it might accidentally toss a variant… md5 will hash it down to what is and isn't the same.

### Uncompress

> This is too easy

If

- Kind is Archive

Do

- Uncompress

### Rename exe's to md5 and send to repo

> Still really easy. The only trick is I set the rename and the upload to two separate scripts and actions so the whole thing can be halted easily in case something fails.

If

- Extension is ```exe```

Do

- Run Shell script embedded script

```bash
newname=$(md5 -q "$1")
mv "$1" "$newname"
```

- Run Shell script embedded script

```bash
curl -sS -F upfile=@"$1" http://your.home.server:9000/cgi-bin/dionaea.py
```

- Display Growl Notification "New MailMal (file)"

## Notification

Ok, I'm not going to teach you how to set up growl to notify your phone for when you move this to your mac mini server at home, but needless to say [Prowl - iOS Push Notifications](http://prowlapp.com/) is your friend. If you sent up the receiver I talked about in the last bunnypot article then you should already have that dionaea.py already to go!

## Next steps

Next I need to find out how to get an email or even an entire domain onto as many spam lists as possible…

Feel free to send donations or suggestions to [free_mal_pleez@bunnyman.info](mailto:free_mal_pleez@bunnyman.info
