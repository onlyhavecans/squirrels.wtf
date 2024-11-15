default:
  @just --list --unsorted

test:
  hugo server --buildDrafts --navigateToChanged

new post-name:
  hugo new content content/posts/{{post-name}}.md
