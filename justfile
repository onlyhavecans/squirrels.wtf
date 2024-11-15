today := `date +%F`

default:
  @just --list --unsorted

test:
  open http://localhost:1313
  hugo server --buildDrafts --navigateToChanged

new post-name:
  hugo new content content/posts/{{today}}-{{post-name}}.md
