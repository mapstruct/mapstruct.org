---
title: "New Year, new Website!"
author: Gunnar Morling
date: "2017-01-02"
tags: [web-site]
---

The MapStruct team wishes a Happy New Year to all our users out there!

To start the new year fresh, we've given some love to our website. While its looks only slightly changed, its inner workings have been overhauled from ground up. It's driven by [Hugo](https://gohugo.io/) now, a static website generator written in Go which is very popular these days.

<!--more-->

It is much easier now for us to put new contents onto the website (everything is written in Markdown now), the tool chain is easier to set up (Hugo is a single binary to be installed) and the web site build is much faster. Long story short, it's much more fun to work with the website now. If you are curious about the details, refer to the description of the [website build](/development/updating-mapstructorg/). Just as MapStruct itself this website is open-source, so pull requests are always welcome!

For users of the site nothing much changes. We've set up redirects for all old URLs. Should we've missed any, please file a bug report against the website's [source repo](https://github.com/mapstruct/mapstruct.org/issues). The only exception is the URL of the news feed (which is RSS based now). As we cannot set up a proper 301 redirect on GitHub Pages, please point your feed reader to the new [feed URL](/news/index.xml).
