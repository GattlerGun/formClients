#!/usr/bin/env sh

set -e

npm run build

cd dist

git init
git add -A
git commit -m 'deploy'


git push -f https://github.com/gattlergun/simonsays.git origin/gh-pages

cd -