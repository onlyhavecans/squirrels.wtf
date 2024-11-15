today := `date +%F`

default:
  @just --list --unsorted

test:
  open http://localhost:1313
  hugo server --buildDrafts --navigateToChanged

clean:
  rm -r public/*
  rm -r resources/*

build: clean
  hugo

new post-name:
  hugo new content content/posts/{{today}}-{{post-name}}.md
