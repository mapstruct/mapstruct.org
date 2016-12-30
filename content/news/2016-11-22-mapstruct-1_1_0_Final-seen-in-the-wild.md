---
title: "MapStruct 1.1.0.Final seen in the wild!"
author: Gunnar Morling
date: "2016-11-22"
tags: [release, news]
---

I'm more than thrilled to report that MapStruct 1.1 Final has been spotted in the wild!
We grew that puppy for almost one year since the announcement of [MapStruct 1.0](/news/2015/11/25/mapstruct-1_0_Final-released.html), so it was about time to let it go and put a final release into your hands.

Besides a plethora of bug fixes the 1.1 release adds many new features which should be very welcome to users of MapStruct 1.0:

* Nested target properties
* `@ValueMapping` annotation for enum mappings
* `@Named` annotation for simple string based mapping qualifiers
* Support for custom `hasXyz()` methods to check the presence of source properties instead of null checks
* Extended support of `java.text.NumberFormat` for Number types to String mapping
* OSGi support
* New built-in conversions around date/time type

<!--more-->

This list is by no means exhaustive.
Check out the individual announcements for the [Beta1](/news/2016/03/16/mapstruct-1_1_0_Beta1-released.html), [Beta2](/news/2016/07/22/mapstruct-1_1_0_Beta2-released.htmll), [CR1](/news/2016/09/07/mapstruct-1_1_0_CR1.html) and [CR2](/news/2016/11/08/mapstruct-1_1_0_CR2-is-out.html) releases for all the details.
Also be sure to take a look at the [migration notes](https://github.com/mapstruct/mapstruct/wiki/Migration-notes) to learn more about some issues to consider when migrating from MapStruct 1.0 to 1.1.

MapStruct would be nowhere without its steadily growing community of users and contributors.
So let me say a big thank you to everyone involved, be it through reporting bugs, starting discussions on the mailing list and of course helping out with contributions on the code base itself.

The following people have sent in code changes for MapStruct 1.1: [Vincent Alexander Beelte](https://github.com/grandmasterpixel), [Oliver Ehrenmüller](https://github.com/greuelpirat), [Dominik Gruntz](https://github.com/dgruntz), [Filip Hrisafov](https://github.com/filiphr), [Sean Huang](https://github.com/seanjob), [Markus Heberling](https://github.com/tisoft), [Maxim Kolesnikov](https://github.com/xCASx), [Peter Larson](https://github.com/pjlarson), [Ciaran Liedeman](https://github.com/cliedeman), [Pavel Makhov](https://github.com/streetturtle), [Stefan May](https://github.com/osthus-sm), [Samuel Wright](https://github.com/samwright) as well as MapStruct old-timers and dear fellows [Andreas Gudian](https://github.com/agudian) and [Sjaak Derksen](https://github.com/sjaakd).
Kudos to you, your efforts and hard work are highly appreciated!

Also let me use the opportunity and introduce Filip Hrisafov to you, the latest committer to the project.
He has been very busy with hacking on MapStruct lately, first by adding some more built-in conversions around date and time types, and now working on the long-awaited support for field based mappings.
Welcome aboard, Filip!

### Some stats

Speaking of numbers and stats, not only the number of contributors grew, also adoption numbers steadily increased over the course of the last year.
We see more and more discussions in our [Google group](https://groups.google.com/forum/#!forum/mapstruct-users) and increasing numbers of [MapStruct-related questions](http://stackoverflow.com/questions/tagged/mapstruct) on Stack Overflow as well as [star gazers](http://www.timqian.com/star-history/#mapstruct/mapstruct) on GitHub.

Most impressive though are the download numbers we get from the Maven Central repo.
As an example here are the numbers for the _org.mapstruct:mapstruct_ artifact:

<div style="text-align:center">
    <img src="/images/downloads_2016.png" style="padding-bottom: 3px;"/>
</div>

The downloads grew by factor 5 from about 10,000 in November 2015 to about 50,000 in the last month.
It's just great to see that MapStruct is that useful for so many users out there!

### What's next?

Finally let's take a look at what to expect from MapStruct in the next time.
As already discussed in the [CR 2 announcement](/news/2016/11/08/mapstruct-1_1_0_CR2-is-out.html), we'd like to get out MapStruct 1.2 much quicker than 1.1, so you can expect it in much less than one year from now :)

Two features planned for 1.2 are the aforementioned [field based mappings](https://github.com/mapstruct/mapstruct/issues/557) and support for [immutable beans](https://github.com/mapstruct/mapstruct/issues/73) on the target side by leveraging non-default constructors.
Also take a look at the [backlog](https://github.com/mapstruct/mapstruct/issues?q=is%3Aissue+is%3Aopen+label%3Afeature).
If there is anything in there you'd like to see addressed rather sooner than later, let us know by commenting or voting.

Our general idea is to keep the number of new features per release a bit lower and in turn do more frequent releases, living up to the "Release early, release often" principle.

### Download

Use these GAV coordinates with Maven, Gradle or similar dependency management tools:

* [org.mapstruct:mapstruct:1.1.0.Final](http://search.maven.org/#artifactdetails|org.mapstruct|mapstruct|1.1.0.Final|jar) for the annotation JAR (to be used with Java <= 7) or [org.mapstruct:mapstruct-jdk8:1.1.0.Final](http://search.maven.org/#artifactdetails|org.mapstruct|mapstruct-jdk8|1.1.0.Final|jar) (for usage with Java >= 8)
* [org.mapstruct:mapstruct-processor:1.1.0.Final](http://search.maven.org/#artifactdetails|org.mapstruct|mapstruct-processor|1.1.0.Final|jar) for the annotation processor.

Alternatively, you can obtain distribution bundles containing the binaries, source and documentation from [SourceForge](http://sourceforge.net/projects/mapstruct/files/1.1.0.Final/) or [BinTray](https://bintray.com/mapstruct/bundles/mapstruct-dist/1.1.0.Final).

### Links

* Get help at the [mapstruct-users](https://groups.google.com/forum/?fromgroups#!forum/mapstruct-users) group or in our [Gitter room](https://gitter.im/mapstruct/mapstruct-users)
* Report bugs and feature requests via the [issue tracker](https://github.com/mapstruct/mapstruct/issues)
* Follow [@GetMapStruct](https://twitter.com/GetMapStruct) on Twitter
* Follow MapStruct on [Google+](https://plus.google.com/u/0/118070742567787866481/posts)
