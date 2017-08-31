---
title: "MapStruct 1.2.0.CR2 released"
author: Filip Hrisafov
date: "2017-08-28"
tags: [release, news]
---

I'm very happy to announce the second candidate release of MapStruct 1.2!

The CR2 release mostly provides bug fixes and other smaller improvements since the [CR1](http://mapstruct.org/news/2017-07-25-mapstruct-1_2_0_CR1-released/),
e.g. related to the handling of `mappingInheritanceStrategy` (issue [#1255](https://github.com/mapstruct/mapstruct/issues/1255)).
Further fixes concern the handling nested target properties ([#1269](https://github.com/mapstruct/mapstruct/issues/1269)).

<!--more-->

The most notable change in the release is the extension of the `mappingInheritenceStrategy`. 
With the inclusion of [#1065](https://github.com/mapstruct/mapstruct/issues/1065) in `1.2.0.Beta2` we added support inheritance of reverse methods from `@MapperConfig`.
This inadvertently lead to [#1255](https://github.com/mapstruct/mapstruct/issues/1255). Therefore, now there are 4 strategies:

* `EXPLICIT` - Only inherits if explicitly stated (Same as before)
* `AUTO_INHERIT_FROM_CONFIG` - Will automatically inherit **only** forward configuration (Behaviour is same as before)
* `AUTO_INHERIT_REVERSE_FROM_CONFIG` - Will automatically inherit **only** reverse configuration (New strategy)
* `AUTO_INHERIT_ALL_FROM_CONFIG` - Will automatically inherit **both** forward and reverse configuration (New Strategy)

Overall, [6 issues](https://github.com/mapstruct/mapstruct/milestone/19?closed=1) have been fixed with the CR2 release.
Please see the [release notes](https://github.com/mapstruct/mapstruct/releases/tag/1.2.0.CR2) for more details on the issues fixed.

Thanks to everyone contributing to this release: [Darren Rambaud](https://github.com/xyzst) and the long-term MapStruct afficionados [Andreas Gudian](https://github.com/agudian), [Gunnar Morling](https://github.com/gunnarmorling) and [Sjaak Derksen](https://github.com/sjaakd).

### Download

You can find MapStruct 1.2 CR 2 in Maven Central under the following GAV coordinates:

* Annotation JAR: [org.mapstruct:mapstruct-jdk8:1.2.0.CR2](http://search.maven.org/#artifactdetails|org.mapstruct|mapstruct-jdk8|1.2.0.CR2|jar) (for usage with Java >= 8) or [org.mapstruct:mapstruct:1.2.0.CR2](http://search.maven.org/#artifactdetails|org.mapstruct|mapstruct|1.2.0.CR2|jar) (for earlier Java versions)
* Annotation processor JAR: [org.mapstruct:mapstruct-processor:1.2.0.CR2](http://search.maven.org/#artifactdetails|org.mapstruct|mapstruct-processor|1.2.0.CR2|jar)

Alternatively, you can get ZIP and TAR.GZ distribution bundles - containing all the JARs, documentation etc. - [from GitHub](https://github.com/mapstruct/mapstruct/releases/tag/1.2.0.CR2).

### Next steps

With this candidate release we believe that we're ready for releasing MapStruct 1.2 Final.

We are confident that the final release will be out in in few weeks.

Please give the candidate release a spin and let us know as soon as possible if you run into any trouble.
To get in touch, post a comment below or use one the following channels:

* Get help at the [mapstruct-users](https://groups.google.com/forum/?fromgroups#!forum/mapstruct-users) group or in our [Gitter room](https://gitter.im/mapstruct/mapstruct-users)
* Report bugs and feature requests via the [issue tracker](https://github.com/mapstruct/mapstruct/issues)
* Follow [@GetMapStruct](https://twitter.com/GetMapStruct) on Twitter
* Follow MapStruct on [Google+](https://plus.google.com/u/0/118070742567787866481/posts)
