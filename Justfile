today := `date +%F`
twis := `date +%Y-W%U`

default:
  @just --list --unsorted

test: clean
  open http://localhost:1313
  hugo server --gc --navigateToChanged

test-links:
  muffet --buffer-size=8192 http://localhost:1313

clean:
  -rm -r public/*
  -rm -r resources/*

build: clean
  hugo

new post-name:
  hugo new content content/posts/{{today}}-{{post-name}}.md
  nvim content/posts/{{today}}-{{post-name}}.md

weekly:
  hugo new content content/posts/{{twis}}.md --kind weekly-posts
  nvim content/posts/{{twis}}.md

update-theme:
  git submodule sync
