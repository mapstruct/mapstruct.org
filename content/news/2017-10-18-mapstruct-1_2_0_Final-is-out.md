---
title: "MapStruct 1.2.0.Final is out"
author: Filip Hrisafov
date: "2017-10-18"
tags: [release, news]
---

I'm very happy to announce the final version MapStruct 1.2!

After less than a year from the [1.1.0.Final](/news/2016-11-22-mapstruct-1_1_0_Final-seen-in-the-wild) release, 3 Beta and 2 CR releases, MapStruct 1.2.0.Final is finally out :).

Besides bug fixes, the 1.2 release brings some new interesting features:

* MapStruct can be used with Lombok out of the box
* Java 8 Stream support
* Mappings based on public fields
* Automatic creation of nested mapping methods
* Mapping methods can take "pass-through" context parameters, addressing different use cases like
 * Passing a locale, timezone or similar to custom mapping methods
 * Keeping track of processed nodes in circular object graphs
* Target bean factory methods can access a mapping's source parameter(s)
* Nested target mappings have been reworked from the ground up
* Java 9 Compatibility

<!--more-->

For more details checkout the individual release announcements for the
[Beta1](/news/2017-02-20-mapstruct-1_2_0_Beta1-is-out-with-lombok-support-and-direct-field-access), [Beta2](/news/2017-03-16-mapstruct-1_2_0_Beta2-released), [Beta3](/news/2017-06-02-mapstruct-1_2_0_Beta3-is-out),
[CR1](/news/2017-07-25-mapstruct-1_2_0_CR1-released) and [CR2](/news/2017-08-28-mapstruct-1_2_0_cr2-released) releases.
Also make sure to look at the [migration notes](https://github.com/mapstruct/mapstruct/wiki/Migration-notes) (for Beta1 and Beta3) and the GitHub [release notes](https://github.com/mapstruct/mapstruct/releases) for the rest of the releases.

We would not have been here without the great support of our users and contributors.
So let me say a big thank you to everyone involved, be it through reporting bugs, starting discussions on the mailing list and, of course, helping out with contributions on the code base itself.

The following people have contributed to the MapStruct 1.2 release:
[Dmytro Polovinkin](https://github.com/navpil), [Maxim Kolesnikov](https://github.com/xCASx), [Pascal Grün](https://github.com/pascalgn), [Remo Meier](https://github.com/remmeier), [Harald Brabenetz](https://github.com/brabenetz), [Alexander Zhuravlev](https://github.com/zelark), [John Watson](https://github.com/johnwatsondev), [44past4](https://github.com/44past4), [Azork](https://github.com/Azork), [iersel](https://github.com/iersel), [idkw](https://github.com/idkw),
[Aleksandr Shalugin](https://github.com/shalugin), [Cornelius Dirmeier](https://github.com/cornzy), [Darren Rambaud](https://github.com/xyzst), [Tillerino](https://github.com/Tillerino), [Kevin Grüneberg](https://github.com/kevcodez) and [Thomas Eckl](https://github.com/ecktoteckto)
as well as seasoned MapStruct hackers [Andreas Gudian](https://github.com/agudian), [Filip Hrisafov](https://github.com/filiphr), [Sjaak Derksen](https://github.com/sjaakd) and [Gunnar Morling](https://github.com/gunnarmorling).

Big *Thank You* to all of you, your efforts and hard work are highly appreciated.


In total 111 issues have been fixed between 1.1.0.Final and 1.2.0.Final releases.

### What's next

There are already some PRs in the pipeline, some ready to be merged, some need some time for one of the most requested features for MapStruct.

Two features planned for 1.3 are [builders support](https://github.com/mapstruct/mapstruct/issues/782) (also support for [AutoValue builders](https://github.com/mapstruct/mapstruct/issues/802)) and support for [constructor injection](https://github.com/mapstruct/mapstruct/issues/571) for the generated mappers.
After that, it won't be too long until MapStruct 2.0.
We've planned to go to a new major version rather soon, allowing us to get rid of some deprecated features and drop support for Java 6/7.
This will help us to keep the codebase maintainable and focus on exciting new mapping features.
Also take a look at the [backlog](https://github.com/mapstruct/mapstruct/labels/feature).
If there is anything in there you'd like to see addressed rather sooner than later, let us know by commenting or voting.

### Download

You can find MapStruct 1.2.0.Final in Maven Central under the following GAV coordinates:

* Annotation JAR: [org.mapstruct:mapstruct-jdk8:1.2.0.Final](http://search.maven.org/#artifactdetails|org.mapstruct|mapstruct-jdk8|1.2.0.Final|jar) (for usage with Java >= 8) or [org.mapstruct:mapstruct:1.2.0.Final](http://search.maven.org/#artifactdetails|org.mapstruct|mapstruct|1.2.0.Final|jar) (for earlier Java versions)
* Annotation processor JAR: [org.mapstruct:mapstruct-processor:1.2.0.Final](http://search.maven.org/#artifactdetails|org.mapstruct|mapstruct-processor|1.2.0.Final|jar)

Alternatively, you can get ZIP and TAR.GZ distribution bundles - containing all the JARs, documentation etc. - [from GitHub](https://github.com/mapstruct/mapstruct/releases/tag/1.2.0.Final).

### Links

To get in touch, post a comment below or use one the following channels:

* Get help at the [mapstruct-users](https://groups.google.com/forum/?fromgroups#!forum/mapstruct-users) group or in our [Gitter room](https://gitter.im/mapstruct/mapstruct-users)
* Report bugs and feature requests via the [issue tracker](https://github.com/mapstruct/mapstruct/issues)
* Follow [@GetMapStruct](https://twitter.com/GetMapStruct) on Twitter
* Follow MapStruct on [Google+](https://plus.google.com/u/0/118070742567787866481/posts)
