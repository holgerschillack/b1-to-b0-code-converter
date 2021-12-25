#!/usr/bin/env sh

set -e

npm run build

cd dist

git init
git add -A
git commit -m 'Deployment'
git push -f git@github.com:holgerschillack/b1-to-b0-code-converter.git main:gh-pages

cd -