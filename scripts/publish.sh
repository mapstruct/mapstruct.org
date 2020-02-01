#!/bin/sh

DIR=$(dirname "$0")

echo "### Preparing"
cd $DIR/..

STABLE_VERSION=`grep -e stableVersion config.toml | sed 's/stableVersion = "\([0-9]*\.[0-9]*\).*"/\1/'`

if [ -z "$STABLE_VERSION" ]
then
    echo "Could not extract the stable version from the config.toml"
    exit 1;
else
    echo "Stable version: $STABLE_VERSION"
fi

STABLE_VERSION_FOLDER="static/documentation/${STABLE_VERSION}"
if [ ! -d "${STABLE_VERSION_FOLDER}" ]
then
    echo "The folder with the stable version: ${STABLE_VERSION_FOLDER} could not be found. Please provide a valid version"
    exit 1;
else
    echo "Stable version folder: $STABLE_VERSION_FOLDER"
fi

if [ "$(git status -s)" ]
then
    echo "The working directory is dirty. Please commit any pending changes."
    exit 1;
fi

echo "### Deleting old publication"
rm -rf public
mkdir public
git worktree prune
rm -rf .git/worktrees/public/

echo "### Checking out gh-pages branch into public"
git worktree add -B gh-pages public upstream/gh-pages

echo "### Removing existing files"
rm -rf public/*

sh ./generate-site.sh

echo "### Updating gh-pages branch"
cd public && git add --all && git commit -m "Publishing to gh-pages. Using stable version folder ${STABLE_VERSION_FOLDER}. (publish.sh)"
