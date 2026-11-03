#!/bin/bash
# Publishes the static board + console to GitHub Pages under your GitHub account (public repo, HTML only, no data).
# First run creates the repo and turns Pages on; later runs push updates. Needs `gh auth status` to be logged in.
set -e
cd "$(dirname "$0")"
REPO=${REPO:-mi08-election-night}
USER=$(gh api user --jq .login)
[ -d .git ] || git init -q -b main
git add -A
git -c user.name="$USER" -c user.email="$USER@users.noreply.github.com" commit -q -m "Static board and console pages" || true
if ! gh repo view "$USER/$REPO" >/dev/null 2>&1; then
  gh repo create "$REPO" --public --source=. --remote=origin --push --description "MI-08 election night board and poller console (static pages)"
  sleep 3
  gh api -X POST "repos/$USER/$REPO/pages" -f build_type=legacy -f 'source[branch]=main' -f 'source[path]=/' >/dev/null
else
  git push -q origin HEAD:main
fi
echo "Console (tonight): https://$USER.github.io/$REPO/"
echo "Board (tonight):   https://$USER.github.io/$REPO/board.html"
echo "Demo console:      https://$USER.github.io/$REPO/?api=https://script.google.com/macros/s/AKfycbx8S5xwWT5tGnQflK_qa9Kj0rsRRYlbPWJMLwzU73PPvUzPMzsyEmDygEGcPNa0O6tr/exec"
echo "(Pages goes live a minute or two after the first run.)"
