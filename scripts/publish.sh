rm -rf public/*
hugo
rm -rf public/page
rm public/index.xml
rm public/documentation/index.xml
rm public/community/index.xml
rm public/development/index.xml
cd public && git add --all && git commit -m "Publishing to gh-pages (publish.sh)"
