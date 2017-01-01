rm -rf public/*
hugo
rm -rf public/pages
rm public/index.xml
rm public/documentation/index.xml
rm public/community/index.xml
rm public/development/index.xml
git add public
git commit . -m "Publishing to gh-pages (publish.sh)"
