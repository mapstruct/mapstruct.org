---
title: "MapStruct 1.2.0.Beta3 is out"
author: Gunnar Morling
date: "2017-06-02"
tags: [release, news]
---

The summer is nearly there, and so is MapStruct 1.2.
Today it's my pleasure to announce another release on our way to the Final: MapStruct 1.2 Beta 3!

This release continues to improve and stabilize the new feature of automatically creating [sub-mapping methods](/news/2017-02-20-mapstruct-1_2_0_Beta1-is-out-with-lombok-support-and-direct-field-access/#automatic-creation-of-sub-mapping-methods).
By default, [no sub-mapping methods are generated](https://github.com/mapstruct/mapstruct/issues/1154) for any types of the JDK (as those are typically no bean types which one would like to step into in the course of mapping).
If more fine-grained control is needed, there is [an SPI](http://mapstruct.org/documentation/dev/reference/html/#_mapping_exclusion_provider) now which lets you define for which types sub-mapping methods should be created.
Eventually, you also can [turn off](https://github.com/mapstruct/mapstruct/issues/993) automatic sub-mappings completely if you prefer to have full control by explicitly defining all required bean mapping methods.

Besides that, several bugs were fixed:

* The generated mappers were missing import statements in some cases ([#1215](https://github.com/mapstruct/mapstruct/issues/1215), [#1164](https://github.com/mapstruct/mapstruct/issues/1164))
* Field mappings didn't work for nested target properties ([#1155](https://github.com/mapstruct/mapstruct/issues/1155))
* Accessing a non-existent nested target property wasn't handled gracefully ([#1153](https://github.com/mapstruct/mapstruct/issues/1153))

<!--more-->

Another nice improvement related to the latter is that MapStruct [will suggest](https://github.com/mapstruct/mapstruct/issues/122) the most-similar actual property name now when accidentally referring to a non-existing property.

Altogether this release fixes [15 issues](https://github.com/mapstruct/mapstruct/milestone/21?closed=1).
Please refer to the [release notes](https://github.com/mapstruct/mapstruct/releases/tag/1.2.0.Beta3) for more details.

As always, a big thank you goes to everyone involved with the release, be it by filing bug reports or sending pull requests.
Let me specifically mention [Filip Hrisafov](https://twitter.com/madfilip) though who contributed the majority of changes to this release and also performed the actual release. Thanks a lot for all your hard work, Filip, that's much appreciated!

### Download

You can find MapStruct 1.2 Beta 3 in Maven Central under the following GAV coordinates:

* Annotation JAR: [org.mapstruct:mapstruct-jdk8:1.2.0.Beta3](http://search.maven.org/#artifactdetails|org.mapstruct|mapstruct-jdk8|1.2.0.Beta3|jar) (for usage with Java >= 8) or [org.mapstruct:mapstruct:1.2.0.Beta3](http://search.maven.org/#artifactdetails|org.mapstruct|mapstruct|1.2.0.Beta3|jar) (for earlier Java versions)
* Annotation processor JAR: [org.mapstruct:mapstruct-processor:1.2.0.Beta3](http://search.maven.org/#artifactdetails|org.mapstruct|mapstruct-processor|1.2.0.Beta3|jar)

For those relying on the distribution bundles - containing all the JARs, documentation etc. - there's a small change.
As of this release, you can download the ZIP and TAR.GZ bundles directly [from GitHub](https://github.com/mapstruct/mapstruct/releases/tag/1.2.0.Beta3).
We won't upload any new releases to SourceForge anymore as we found the GitHub release functionality to be more user-friendly.

### Next steps

Beta3 is planned to be the last Beta release for MapStruct 1.2.

So please give it a try and let us know as soon as possible if you run into any trouble.
If no further critical bugs show up, we'll do one CR (candidate release) in a few weeks, followed by the Final which should be in your hands in the summer.

To get in touch, post a comment below or use one the following channels:

* Get help at the [mapstruct-users](https://groups.google.com/forum/?fromgroups#!forum/mapstruct-users) group or in our [Gitter room](https://gitter.im/mapstruct/mapstruct-users)
* Report bugs and feature requests via the [issue tracker](https://github.com/mapstruct/mapstruct/issues)
* Follow [@GetMapStruct](https://twitter.com/GetMapStruct) on Twitter
* Follow MapStruct on [Google+](https://plus.google.com/u/0/118070742567787866481/posts)
