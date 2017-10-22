#!/bin/sh

DIR=$(dirname "$0")

echo "### Preparing"
cd $DIR/..

STABLE_VERSION=`grep -e stableVersion config.toml | sed 's/stableVersion = "\([0-9]*\.[0-9]*\).*"/\1/'`

if [[ -z $STABLE_VERSION ]]
then
    echo "Could not extract the stable version from the config.toml"
    exit 1;
else
    echo "Stable version: $STABLE_VERSION"
fi

STABLE_VERSION_FOLDER="static/documentation/${STABLE_VERSION}"
if [[ ! -d ${STABLE_VERSION_FOLDER} ]]
then
    echo "The folder with the stable version: ${STABLE_VERSION_FOLDER} could not be found. Please provide a valid version"
    exit 1;
else
    echo "Stable version folder: $STABLE_VERSION_FOLDER"
fi

DEV_VERSION=`grep -e devVersion config.toml | sed 's/devVersion = "\([0-9]*\.[0-9]*\).*"/\1/'`

if [[ -z $DEV_VERSION ]]
then
    echo "Could not extract the dev version from the config.toml"
    exit 1;
else
    echo "Dev version: $DEV_VERSION"
fi

DEV_VERSION_FOLDER="static/documentation/${DEV_VERSION}"
if [[ ! -d ${DEV_VERSION_FOLDER} ]]
then
    echo "The folder with the dev version: ${DEV_VERSION_FOLDER} could not be found. Please provide a valid version"
    exit 1;
else
    echo "Dev version folder: $DEV_VERSION_FOLDER"
fi

GOOGLE_ANALYTICS_ID=`grep -e googleAnalytics config.toml | sed 's/googleAnalytics = "\(.*\)"/\1/' | sed 's/\-/\\-/g'`

if [[ -z $GOOGLE_ANALYTICS_ID ]]
then
    echo "Could not extract the Google Analytics ID from the config.toml"
    exit 1;
else
    echo "Google Analytics Id: $GOOGLE_ANALYTICS_ID"
fi

if [[ $(git status -s) ]]
then
    echo "The working directory is dirty. Please commit any pending changes."
    exit 1;
fi

HUGO_REQUIRED_VERSION="Hugo Static Site Generator v0.30.2"
HUGO_VERSION=`hugo version`

if [[ $HUGO_VERSION != "${HUGO_REQUIRED_VERSION}"*  ]]
then
    echo "Website should be build with HUGO version: ${HUGO_REQUIRED_VERSION}. However, ${HUGO_VERSION} is being used"
    exit 1;
else
    echo "Hugo version: ${HUGO_VERSION}"
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

echo "### Generating site"
hugo
rm -rf public/page
rm public/index.xml
rm public/documentation/index.xml
rm public/community/index.xml
rm public/development/index.xml

DESTINATION_STABLE_VERSION="public/documentation/stable"
echo "### Copying the stable documentation from ${STABLE_VERSION_FOLDER} to ${DESTINATION_STABLE_VERSION}"
cp -r ${STABLE_VERSION_FOLDER} ${DESTINATION_STABLE_VERSION}

DESTINATION_DEV_VERSION="public/documentation/dev"
echo "### Copying the dev documentation from ${DEV_VERSION_FOLDER} to ${DESTINATION_DEV_VERSION}"
cp -r ${DEV_VERSION_FOLDER} ${DESTINATION_DEV_VERSION}

echo "### Inserting analytics snippet"
cp scripts/analytics_snippet.txt public
sed -i.bak -e "s/%GOOGLE_ANALYTICS_ID%/$GOOGLE_ANALYTICS_ID/g" public/analytics_snippet.txt

find public/documentation -type f -regex "public/documentation/[0-9].*" -name "*.html" -exec sed -i.bak -e '/^\s*<\/head>/ {' -e 'r public/analytics_snippet.txt' -e 'd' -e '}' {} +
find public/documentation -type f -regex "${DESTINATION_STABLE_VERSION}.*" -name "*.html" -exec sed -i.bak -e '/^\s*<\/head>/ {' -e 'r public/analytics_snippet.txt' -e 'd' -e '}' {} +
find public/documentation -type f -regex "${DESTINATION_DEV_VERSION}.*" -name "*.html" -exec sed -i.bak -e '/^\s*<\/head>/ {' -e 'r public/analytics_snippet.txt' -e 'd' -e '}' {} +

echo "### Removing backup files"

find public/documentation -type f -regex "public/documentation/[0-9].*" -name "*.html.bak" -delete
find public/documentation -type f -regex "${DESTINATION_STABLE_VERSION}.*" -name "*.html.bak" -delete
find public/documentation -type f -regex "${DESTINATION_DEV_VERSION}.*" -name "*.html.bak" -delete

rm public/analytics_snippet.txt*

echo "### Updating gh-pages branch"
cd public && git add --all && git commit -m "Publishing to gh-pages. Using stable version folder ${STABLE_VERSION_FOLDER}. (publish.sh)"
