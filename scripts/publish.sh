if [[ $(git status -s) ]]
then
    echo "The working directory is dirty. Please commit any pending changes."
    exit
fi

git rev-parse --verify gh-pages
if [[ $? -ne 0 ]]
then
    echo "Branch 'gh-pages' does not exist in the local repository. Please create it by running the following command:"
    echo "git fetch upstream && git branch --track gh-pages upstream/gh-pages"
    exit;
fi


echo "Deleting old publication"
rm -rf public
mkdir public

git clone .git --branch gh-pages public

echo "Generating site"
hugo
rm -rf public/page
rm public/index.xml
rm public/documentation/index.xml
rm public/community/index.xml
rm public/development/index.xml

echo "Updating gh-pages branch"
cd public && git add --all && git commit -m "Publishing to gh-pages (publish.sh)" && git push origin gh-pages
