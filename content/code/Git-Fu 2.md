date: 2012-09-11 15:05
title: Git-Fu Advice
slug: git-fu-02
tags: git

Now who would have thought, I start blogging about git and people have advice. This post isn't just my personal learning but also some advice I received from others!


    git reset HEAD^
> From Alexis: Something I'm doing a lot is when I mess up with git, I sometimes need to uncommit something but keep the changes I had just before the commit.

    git add -i
> From Alexis: "Use this…" Brief but powerful advice. I never thought of using the interactive mode personally but if you are doing a complex commit or want to double over your work git's interactive mode is fairly robust.

    :::bash...
    cd my_git_repo
    echo 'git push' > .git/hooks/post-commit
    chmod 755 .git/hooks/post-commit
> I mentioned this in an earlier post. This hook trick is for the lazy at heart. This script runs a push after every commit. If you always have access to your origin repo when you are coding, ie like you are a cubicle worker, this might not be too bad. This might get annoying of you are the type of coder that likes to write a lot of little commits on the road and then push in bundles.

		git diff --cached [--ext-diff]
> As mentioned in my last post I'm big for double-checking my commits before go. This long command (that deserves an alias) pops open a diff of everything in your index ready to commit. Always a quick check before proceed!
