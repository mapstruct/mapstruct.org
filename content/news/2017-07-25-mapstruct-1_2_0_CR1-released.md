---
title: "MapStruct 1.2.0.CR1 released"
author: Gunnar Morling
date: "2017-07-25"
tags: [release, news]
---

I'm very happy to announce the first candidate release of MapStruct 1.2!

The CR1 release mostly provides bug fixes and other smaller improvements since the [Beta 3](http://mapstruct.org/news/2017-06-02-mapstruct-1_2_0_Beta3-is-out/),
e.g. related to the handling of the `@ObjectFactory` annotation (issues [#1131](https://github.com/mapstruct/mapstruct/issues/1131) and [#1242](https://github.com/mapstruct/mapstruct/issues/1242[issue 1242])).
Further fixes concern the handling of imports in the generated code ([#1227](https://github.com/mapstruct/mapstruct/issues/1227), [#543](https://github.com/mapstruct/mapstruct/issues/543)) and the error reporting in case of incorrect mapper definitions ([#1150](https://github.com/mapstruct/mapstruct/issues/1150), [#1185](https://github.com/mapstruct/mapstruct/issues/1185)).

<!--more-->

One useful improvement relates to the usage of MapStruct under Java 9: we have defined module names now which will take effect when using MapStruct as _automatic module_ ([#1224](https://github.com/mapstruct/mapstruct/issues/1224)).

The module names are `org.mapstruct` for the annotation JARs (only one of them is to be used at a given time, so using the same name is fine) and `org.mapstruct.processor` for the processor JAR.
This is done using the new JAR manifest header `Automatic-Module-Name` which is supported by recent Java 9 preview builds.

Overall, [21 issues](https://github.com/mapstruct/mapstruct/milestone/22?closed=1) have been fixed with the CR1 release.
Please see the [release notes](https://github.com/mapstruct/mapstruct/releases/tag/1.2.0.CR1) for more details on the issues fixed.

Kudos to everyone contributing to this release: [Aleksandr Shalugin](https://github.com/shalugin), [Cornelius Dirmeier](https://github.com/cornzy),
[Darren Rambaud](https://github.com/xyzst) and [Tillerino](https://github.com/Tillerino) as well as long-term MapStruct afficionados [Andreas Gudian](https://github.com/agudian), [Filip Hrisafov](https://github.com/filiphr) and [Sjaak Derksen](https://github.com/sjaakd).

### Download

You can find MapStruct 1.2 CR 1 in Maven Central under the following GAV coordinates:

* Annotation JAR: [org.mapstruct:mapstruct-jdk8:1.2.0.CR1](http://search.maven.org/#artifactdetails|org.mapstruct|mapstruct-jdk8|1.2.0.CR1|jar) (for usage with Java >= 8) or [org.mapstruct:mapstruct:1.2.0.CR1](http://search.maven.org/#artifactdetails|org.mapstruct|mapstruct|1.2.0.CR1|jar) (for earlier Java versions)
* Annotation processor JAR: [org.mapstruct:mapstruct-processor:1.2.0.CR1](http://search.maven.org/#artifactdetails|org.mapstruct|mapstruct-processor|1.2.0.CR1|jar)

Alternatively, you can get ZIP and TAR.GZ distribution bundles - containing all the JARs, documentation etc. - [from GitHub](https://github.com/mapstruct/mapstruct/releases/tag/1.2.0.CR1).

### Next steps

With this candidate release we believe that we're mostly ready for releasing MapStruct 1.2 Final.

No further feature development is planned for 1.2 at this point.
Depending on the number of bug reports popping up in the next few days and weeks, we'll either do another CR or go to 1.2 Final right away.
The final release should be in your hands in late summer.

Please give the candidate release a spin and let us know as soon as possible if you run into any trouble.
To get in touch, post a comment below or use one the following channels:

* Get help at the [mapstruct-users](https://groups.google.com/forum/?fromgroups#!forum/mapstruct-users) group or in our [Gitter room](https://gitter.im/mapstruct/mapstruct-users)
* Report bugs and feature requests via the [issue tracker](https://github.com/mapstruct/mapstruct/issues)
* Follow [@GetMapStruct](https://twitter.com/GetMapStruct) on Twitter
* Follow MapStruct on [Google+](https://plus.google.com/u/0/118070742567787866481/posts)
