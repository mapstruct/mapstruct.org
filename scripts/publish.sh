#!/bin/sh

DIR=$(dirname "$0")

cd $DIR/..

STABLE_VERSION=`grep -e stableVersion config.toml | sed 's/stableVersion = "\([0-9]*\.[0-9]*\).*"/\1/'`

if [[ -z $STABLE_VERSION ]]
then
    echo "Could not extract the stable version from the config.toml"
    exit 1;
fi

STABLE_VERSION_FOLDER="static/documentation/${STABLE_VERSION}"
if [[ ! -d ${STABLE_VERSION_FOLDER} ]]
then
    echo "The folder with the stable version: ${STABLE_VERSION_FOLDER} could not be found. Please provide a valid version"
    exit 1;
fi

DEV_VERSION=`grep -e devVersion config.toml | sed 's/devVersion = "\([0-9]*\.[0-9]*\).*"/\1/'`

if [[ -z $DEV_VERSION ]]
then
    echo "Could not extract the dev version from the config.toml"
    exit 1;
fi

DEV_VERSION_FOLDER="static/documentation/${DEV_VERSION}"
if [[ ! -d ${DEV_VERSION_FOLDER} ]]
then
    echo "The folder with the dev version: ${DEV_VERSION_FOLDER} could not be found. Please provide a valid version"
    exit 1;
fi

GOOGLE_ANALYTICS_ID=`grep -e googleAnalytics config.toml | sed 's/googleAnalytics = "\(.*\)"/\1/'`

if [[ -z $GOOGLE_ANALYTICS_ID ]]
then
    echo "Could not extract the Google Analytics ID from the config.toml"
    exit 1;
fi

if [[ $(git status -s) ]]
then
    echo "The working directory is dirty. Please commit any pending changes."
    exit 1;
fi

echo "Deleting old publication"
rm -rf public
mkdir public
git worktree prune
rm -rf .git/worktrees/public/

echo "Checking out gh-pages branch into public"
git worktree add -B gh-pages public upstream/gh-pages

echo "Removing existing files"
rm -rf public/*

echo "Generating site"
hugo
rm -rf public/page
rm public/index.xml
rm public/documentation/index.xml
rm public/community/index.xml
rm public/development/index.xml

DESTINATION_STABLE_VERSION="public/documentation/stable"
echo "Copying the stable documentation from ${STABLE_VERSION_FOLDER} to ${DESTINATION_STABLE_VERSION}"
cp -r ${STABLE_VERSION_FOLDER} ${DESTINATION_STABLE_VERSION}

DESTINATION_DEV_VERSION="public/documentation/dev"
echo "Copying the dev documentation from ${DEV_VERSION_FOLDER} to ${DESTINATION_DEV_VERSION}"
cp -r ${DEV_VERSION_FOLDER} ${DESTINATION_DEV_VERSION}

# As discussed in https://github.com/mapstruct/mapstruct.org/pull/45, we shouldn't add the noindex tag;
# I'm leaving this here as a template for adding the analytics snippet

# echo "Add noindex meta tag to all HTML (backups will be created) files in public/documentation/[0-9]*"
# find public/documentation -type f -regex "public/documentation/[0-9].*" -name "*.html" -exec sed -i.bak "s/<\/head>/<meta name=\"robots\" content=\"noindex\" \/><\/head>/" {} +
# echo "removing all the backups that were created for the previous command"
# find public/documentation -type f -regex "public/documentation/[0-9].*" -name "*.html.bak" -delete

echo "Inserting analytics snippet"
find public/documentation -type f -regex "\(public/documentation/[0-9]\|${DESTINATION_STABLE_VERSION}/\|${DESTINATION_DEV_VERSION}/\).*" -name "*.html" -exec sed -i.bak -e '/^\s*<\/head>/ {' -e 'r scripts/analytics_snippet.txt' -e 'd' -e '}' {} +
find public/documentation -type f -regex "\(public/documentation/[0-9]\|${DESTINATION_STABLE_VERSION}/\|${DESTINATION_DEV_VERSION}/\).*" -name "*.html.bak" -delete

echo "Updating gh-pages branch"
cd public && git add --all && git commit -m "Publishing to gh-pages. Using stable version folder ${STABLE_VERSION_FOLDER}. (publish.sh)"
