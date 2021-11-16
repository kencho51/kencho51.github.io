#!/bin/sh

# With Travis CI, local deploy script is not needed.
# Travis CI will do deployment automatically after each push.

# If a command fails then the deploy stops
set -e

printf "\033[0;32mDeploying updates to GitHub...\033[0m\n"

printf "Update local repo first and then back to top level"
cd public
git pull
cd ..

printf "!!!Build the project.\n"
#hugo # if using a theme, replace with `hugo -t <YOURTHEME>`
hugo --gc -v -t ghostwriter

printf "!!!Go To Public folder\n"
cd public

printf "!!!Add changes to git.\n"
git add .

printf "!!!Commit changes.\n"
msg="Rebuilding site $(date)"
if [ -n "$*" ]; then
	msg="$*"
fi
git commit -m "$msg"

printf "!!!Push source and build repos.\n"
git push origin master