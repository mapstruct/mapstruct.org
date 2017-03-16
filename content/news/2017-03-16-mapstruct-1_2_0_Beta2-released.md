---
title: "MapStruct 1.2.0.Beta2 released"
author: Andreas Gudian
date: "2017-03-16"
tags: [release, news]
---

Just shy of a month after the first Beta release of MapStruct 1.2, the team is happy to announce the second Beta, fixing a couple of bugs that sneaked in with the [many new features](/news/2017-02-20-mapstruct-1_2_0_Beta2-is-out-with-lombok-support-and-direct-field-access/) offered by the new 1.2 release line.

We fixed [16 issues](https://github.com/mapstruct/mapstruct/milestone/20?closed=1), most of them reported by users. The most infamous bugs reported and fixed are:

* [Some type conversions stopped working](https://github.com/mapstruct/mapstruct/issues/1121) under some circumstances due to an odd JDK behaviour that we didn't run into previously.
* [Unmapped target properties in name based mappings](https://github.com/mapstruct/mapstruct/issues/1104) resulted in an error instead of being reported as configured with `unmappedTargetPolicy`.
* A [StackOverflowError](https://github.com/mapstruct/mapstruct/issues/1103) was thrown while automatically generating methods in a type structure with circles.
* [`@Context` parameters didn't play along with nested property mappings](https://github.com/mapstruct/mapstruct/issues/1124).

Plus, the newly introduced automapping feature now also [creates Enum mapping methods](https://github.com/mapstruct/mapstruct/issues/1102).

<!--more-->

We were incredibly amazed by the amount and the quality of feedback we got on the last release in such a short time. So a big *Thank You* to [Harald Brabenetz](https://github.com/brabenetz), [Alexander Zhuravlev](https://github.com/zelark), [John Watson](https://github.com/johnwatsondev), [44past4](https://github.com/44past4), [Azork](https://github.com/Azork), [iersel](https://github.com/iersel), and [idkw](https://github.com/idkw) for your issue reports that contributed to the release!
And after initially contributing the awesome automapping feature, [Dmytro Polovinkin](https://github.com/navpil) continued to help out improving it - many thanks to you as well, we really appreciate it!


### Download

Ready to try out the new release? Great! We need the feedback!

You find the new release from Maven Central using the following GAV coordinates:

* Annotation JAR: [org.mapstruct:mapstruct-jdk8:1.2.0.Beta2](http://search.maven.org/#artifactdetails|org.mapstruct|mapstruct-jdk8|1.2.0.Beta2|jar) (for usage with Java >= 8) or [org.mapstruct:mapstruct:1.2.0.Beta2](http://search.maven.org/#artifactdetails|org.mapstruct|mapstruct|1.2.0.Beta2|jar) (for earlier Java versions)
* Annotation processor JAR: [org.mapstruct:mapstruct-processor:1.2.0.Beta2](http://search.maven.org/#artifactdetails|org.mapstruct|mapstruct-processor|1.2.0.Beta2|jar)

For those not using a dependency management tool such as Maven or Gradle, we also provide distribution bundles (ZIP, TAR.GZ) on [SourceForge](http://sourceforge.net/projects/mapstruct/files/1.2.0.Beta2/).

If you run into any trouble or would like to report a bug, feature request or similar, use the following channels to get in touch:

* Get help at the [mapstruct-users](https://groups.google.com/forum/?fromgroups#!forum/mapstruct-users) group or in our [Gitter room](https://gitter.im/mapstruct/mapstruct-users)
* Report bugs and feature requests via the [issue tracker](https://github.com/mapstruct/mapstruct/issues)
* Follow [@GetMapStruct](https://twitter.com/GetMapStruct) on Twitter
* Follow MapStruct on [Google+](https://plus.google.com/u/0/118070742567787866481/posts)
