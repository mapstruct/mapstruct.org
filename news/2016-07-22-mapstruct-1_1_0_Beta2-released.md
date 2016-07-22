---
title: "MapStruct 1.1.0.Beta2 released"
author: Sjaak Derksen
layout: news
tags: [release, news]
---

It has been a while since the latest release of MapStruct. Via our mailing list, issue list and other channels we have received valuable feedback. We have tried to incorporate some of that feedback into a number of new features.

MapStruct 1.1.0.Beta2 introduces a number of popular requested features, like source presence check and nested target properties.

Today we release MapStruct 1.1.0.Beta2, containing fixes for most of the user-reported bugs:

* Mapping of nested target properties.
* Support of using `hasXYZ` presence checker methods instead of `null` checks on the source side of bean mappings. The presence checker naming convention can be overidden by providing a custom SPI implementation.
* Extended support of `java.text.NumberFormat` for Number types to String mapping.
* Provide OSGI-enabled jars.
* Fix a compatibility issue with Eclipse Neon.

The complete list of closed issues can be found in the [change log](https://github.com/mapstruct/mapstruct/issues?q=milestone%3A1.1.0.Beta2).

The MapStruct teams thanks: [Sean Huang](https://github.com/seanjob), and [Ciaran Liedeman](https://github.com/cliedeman) for their contribution! 

### What's next?

We hope to release 1.1.0.CR1 in a short while (after the summer holidays).

Please also checkout our examples [GitHub examples repository](https://github.com/mapstruct/mapstruct-examples). It is still small but the intention is to make this a repository of typical mapping problems and how to solve them with MapStruct. Contributing good examples is appriciated.

### Download

To fetch MapStruct 1.1.0.Beta2 via Maven, Gradle or similar dependency management tools, use the following GAV coordinates:

* [org.mapstruct:mapstruct:1.1.0.Beta2](http://search.maven.org/#artifactdetails|org.mapstruct|mapstruct|1.1.0.Beta2|jar) for the annotation JAR (to be used with Java <= 7) or [org.mapstruct:mapstruct-jdk8:1.1.0.Beta2](http://search.maven.org/#artifactdetails|org.mapstruct|mapstruct-jdk8|1.1.0.Beta2|jar) (for usage with Java >= 8)
* [org.mapstruct:mapstruct-processor:1.1.0.Beta2](http://search.maven.org/#artifactdetails|org.mapstruct|mapstruct-processor|1.1.0.Beta2|jar) for the annotation processor.

Alternatively, you can download distribution bundles (ZIP, TAR.GZ) from [SourceForge](http://sourceforge.net/projects/mapstruct/files/1.1.0.Beta2/).

* Get help at the [mapstruct-users](https://groups.google.com/forum/?fromgroups#!forum/mapstruct-users) group or in our [Gitter room](https://gitter.im/mapstruct/mapstruct-users)
* Report bugs and feature requests via the [issue tracker](https://github.com/mapstruct/mapstruct/issues)
* Follow [@GetMapStruct](https://twitter.com/GetMapStruct) on Twitter
* Follow MapStruct on [Google+](https://plus.google.com/u/0/118070742567787866481/posts)

We hope that you'll find the new features valuable.
