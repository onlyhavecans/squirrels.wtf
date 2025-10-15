twis := `date +%Y-W%U`

default:
  @just --list --unsorted

update:
  nix flake update

test: clean
  xdg-open http://localhost:1313
  hugo server --gc --navigateToChanged

test-links:
  muffet --buffer-size=8192 http://localhost:1313

lint:
  markdownlint-cli2 --fix 'content/**/*.md'

clean:
  -rm -r public/*
  -rm -r resources/*

build: clean
  hugo

new post-name:
  git switch -C post/{{post-name}}
  hugo new content content/posts/{{post-name}}/index.md
  nvim content/posts/{{post-name}}/index.md

weekly:
  git switch -C post/weekly-{{twis}}
  hugo new content content/posts/{{twis}}.md --kind weekly-posts
  nvim content/posts/{{twis}}.md

update-theme:
  git submodule update --init --recursive
  git submodule update --remote --merge
