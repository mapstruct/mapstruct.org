+++
date = "2016-02-14T16:11:58+05:30"
title = "Updating mapstruct.org"
weight = 500
teaser = "How to update this website"
[menu]
[menu.main]
parent = "Development"
+++

As MapStruct itself, this web site is open-source, too. You can find it's source code [here](https://github.com/mapstruct/mapstruct.org).

The website is built using the [Hugo](http://gohugo.io/) static site generator. So it's recommended to spend a few minutes reading the [Getting Started](http://gohugo.io/overview/introduction/) section of the Hugo docs if you are not familiar with it yet.

The site is deployed to [GitHub Pages](https://help.github.com/categories/github-pages-basics/) (as a "project page", using the "gh-pages" branch).

## Set-up

Install Hugo by following the instructions given on [its homepage](http://gohugo.io/). E.g. using brew if you are on OS X:

{{< prettify >}}
brew update && brew install hugo
{{< /prettify >}}

Make sure that you are using Git 2.5 or later due the worktree feature used for publication (see below).
Check out the web site's source code and assign the name "upstream" to the remote repository by running:

{{< prettify >}}
git clone git@github.com:mapstruct/mapstruct.org.git
git remote rename origin upstream
{{< /prettify >}}

## Local preview

Hugo comes with a built-in server for previewing the web site locally. Start it by running:

{{< prettify >}}
hugo server --buildDrafts
{{< /prettify >}}

The website can then be accessed at [http://localhost:1313/](http://localhost:1313/).
The server injects some magic JavaScript which enables auto-reload of rendered pages in the browser as the source files are edited.

## Content authoring

Web site contents are written using Markdown, source files are located under _content_. You can mark a new page, e.g. a news post, as a draft which will cause it to be ignored when generating the production website:

{{< prettify >}}
---
title: "My blog post"
draft: true
---
Lorem ipsum dolor sit amet, consectetur adipiscing elit...
{{< /prettify >}}

For news posts a short summary is shown on the home page and the news landing page. Add the "more" comment to your posts after the part of the post that should be shown in the summary, e.g. an introductory first paragraph:

{{< prettify >}}
---
title: "My blog post"
---
Two or three sentences as a teaser.

<!--more-->

And then the remainder of the post.
{{< /prettify >}}

## Adding an entry to the team page

The [team page](/development/team) is a data-driven page. If you want to be listed on the page, add a new file to _data/team_ following the structure of the existing files in that directory.

## Publishing to mapstruct.org

The website is automatically published for every commit to master via [this GitHub Workflow](https://github.com/mapstruct/mapstruct.org/actions?query=workflow%3A%22GitHub+Pages%22).
The workflow generates the HTML with the `hugo` command in the _public_ directory.
The contents of that directory are then pushed to the "gh-pages" branch of the website repository.

To make publication as smooth as possible, the script _scripts/generate-site.sh_ is taking care of the regeneration. It calls `hugo` and afterwards removes some generated files which are not needed.

A typical editing process will look like this (assuming you start on the master directory):

{{< prettify >}}
# update local branches
git fetch upstream
git merge upstream/master

# do your changes...

# commit
git commit -a -m "Some website change"

# deploy
git push upstream master
{{< /prettify >}}
