---
title: "MapStruct 1.1.0.CR2 is out"
author: Gunnar Morling
date: "2016-11-08"
tags: [release, news]
---

It's my pleasure to announce the second candidate release of MapStruct 1.1!

This release fixes several bugs discovered in the first CR but also adds some new built-in conversions around date/time types (e.g. from/to the `java.sql.*` types and between `java.time.LocalDate` and `java.util.Date`).
Normally, we wouldn't add new functionality during the CR phase, but as these conversions have been contributed by community members (kudos to you!), we thought it'd be nice to put them into a release as soon as possible.

<!--more-->

Please check out the [change log](https://github.com/mapstruct/mapstruct/issues?q=milestone%3A1.1.0.CR2) for the complete list of closed issues.
Also take a look at the [migration notes](https://github.com/mapstruct/mapstruct/wiki/Migration-notes#110cr2) as there has been a slight behavioral change related to nested source properties requiring conversion and the null checks in the generated code.
We strongly recommend testing against MapStruct 1.1.0.CR2 to everyone.
If you find any further bugs when using the CR in your project, please report them to our [issue tracker](https://github.com/mapstruct/mapstruct/issues) as soon as possible.

Many thanks to all the bug reporters and everyone contributing to the CR2 release, be it with code or documentation: [Filip Hrisafov](https://github.com/filiphr), [Stefan May](https://github.com/osthus-sm), [Peter Larson](https://github.com/pjlarson), [Pavel Makhov](https://github.com/streetturtle), [Maxim Kolesnikov](https://github.com/xCASx) and [Dominik Gruntz](https://github.com/dgruntz).
You guys rock!

### What's next?

Unless any further issues arise, we've planned to do the 1.1 Final release by the end of next week.

After that we'd like to come to MapStruct 1.2 rather quickly.
The [backlog](https://github.com/mapstruct/mapstruct/issues?q=is%3Aissue+is%3Aopen+label%3Afeature) is filled and there are already some pull requests for new features waiting to be merged.
So you can look forward to support of [field based mappings](https://github.com/mapstruct/mapstruct/issues/557), support for [immutable beans](https://github.com/mapstruct/mapstruct/issues/73) on the target side by using non-default constructors and some more.

The 1.2 release can be expected to be much more focused in scope than 1.1.
We've felt that it took a bit too long to get from 1.0 to 1.1, one reason being that we kept on adding new features during the Beta phase which got a bit in the way of finalizing the release.
From 1.2 onwards, we'll keep the number of new features per release lower which should allow us to release more often and get the features already done into your hands more quickly. "Release early, release often" as they say!

### Download

To fetch MapStruct 1.1.0.CR2 via Maven, Gradle or similar dependency management tools, use the following GAV coordinates:

* [org.mapstruct:mapstruct:1.1.0.CR2](http://search.maven.org/#artifactdetails|org.mapstruct|mapstruct|1.1.0.CR2|jar) for the annotation JAR (to be used with Java <= 7) or [org.mapstruct:mapstruct-jdk8:1.1.0.CR2](http://search.maven.org/#artifactdetails|org.mapstruct|mapstruct-jdk8|1.1.0.CR2|jar) (for usage with Java >= 8)
* [org.mapstruct:mapstruct-processor:1.1.0.CR2](http://search.maven.org/#artifactdetails|org.mapstruct|mapstruct-processor|1.1.0.CR2|jar) for the annotation processor.

Alternatively, you can download distribution bundles (ZIP, TAR.GZ) from [SourceForge](http://sourceforge.net/projects/mapstruct/files/1.1.0.CR2/) or [BinTray](https://bintray.com/mapstruct/bundles/mapstruct-dist/1.1.0.CR2).

### Links

* Get help at the [mapstruct-users](https://groups.google.com/forum/?fromgroups#!forum/mapstruct-users) group or in our [Gitter room](https://gitter.im/mapstruct/mapstruct-users)
* Report bugs and feature requests via the [issue tracker](https://github.com/mapstruct/mapstruct/issues)
* Follow [@GetMapStruct](https://twitter.com/GetMapStruct) on Twitter
* Follow MapStruct on [Google+](https://plus.google.com/u/0/118070742567787866481/posts)
