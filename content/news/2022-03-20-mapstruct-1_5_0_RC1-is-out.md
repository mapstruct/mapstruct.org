---
title: "MapStruct 1.5.0.RC1 is out"
author: Filip Hrisafov
date: "2022-03-20"
tags: [release, news]
---

I am very happy to announce the first release candidate of MapStruct 1.5!

This release provides mostly bug fixes and other smaller improvements since [1.5.0.Beta2](https://mapstruct.org/news/2021-12-12-mapstruct-1_5_0_Beta2-is-out/).


* Support for Jakarta dependency injection
* Allow `@InheritInverseConfiguration` with `@SubclassMapping`(s)
* Various small bug fixes and documentation clarifications

<!--more-->

Altogether, not less than [25 issues](https://github.com/mapstruct/mapstruct/issues?q=milestone%3A1.5.0.RC1) were fixed for this release.

This would not have been possible without our fantastic community of contributors:
* [@cdelashmutt-pivotal](https://github.com/cdelashmutt-pivotal)
* [@JKLedzion](https://github.com/JKLedzion)
* [@unshareFran](https://github.com/unshare)

* our latest MapStruct contributor [Ben Zegveld](https://github.com/Zegveld) 
* and of course seasoned MapStruct hackers [Sjaak Derksen](https://github.com/sjaakd) and [Filip Hrisafov](https://github.com/filiphr).

Thank you everyone for all your hard work!

We'd like to thank our community for the feedback on our Beta releases and for their contributions.

### Support for Jakarta dependency injection

MapStruct can now detect whether you are using Jakarta or Javax dependency injection based on what you have during compilation.
When using the `jsr330` component model and when you don't have the Javax, but you do have the Jakarta dependency injection then MapStruct will use the Jakarta dependency injection classes.

In addition to that there is also a new `jakarta` `componentModel` that can be used to tell MapStruct to only use the Jakarta dependency injection classes. 
This can be used when you have the 2 dependencies, and you want to use Jakarta.

###  Allow `@InheritInverseConfiguration` with `@SubclassMapping`(s)

`@InheritInverseConfiguration` can now be used for `@SubclassMapping`(s) as well.

### Enhancements

* There is now a compiler error if there are unimplemented lifecycle `@BeforeMapping` / `@AfterMapping` methods in your mapper
* Builders can be disabled using the compiler argument `mapstruct.disableBuilders`
* Use `CLASS` retention policy for `@DecoratedWith` in order for it to work properly with Gradle 7.3 incremental compilation
* Relax the use of qualifiers with 2-step mapping methods


### Breaking Changes

We have been made aware that the introduction of the mapping from `Map<String, ???>` to Bean has lead to some breaking changes in some scenarios.
Some known changes are:

* Qualifiers for map sources as explained in [issue #2549](https://github.com/mapstruct/mapstruct/issues/2549#issuecomment-900595798)
* Implicit map to map mappings as explained in [issue #2764](https://github.com/mapstruct/mapstruct/issues/2764#issuecomment-1049042001)

### Download

This concludes our tour through MapStruct 1.5 RC1.
If you'd like to try out the features described above, you can fetch the new release from Maven Central using the following GAV coordinates:

* Annotation JAR: [org.mapstruct:mapstruct:1.5.0.RC1](http://search.maven.org/#artifactdetails|org.mapstruct|mapstruct|1.5.0.RC1|jar) 
* Annotation processor JAR: [org.mapstruct:mapstruct-processor:1.5.0.RC1](http://search.maven.org/#artifactdetails|org.mapstruct|mapstruct-processor|1.5.0.RC1|jar)

Alternatively, you can get ZIP and TAR.GZ distribution bundles - containing all the JARs, documentation etc. - [from GitHub](https://github.com/mapstruct/mapstruct/releases/tag/1.5.0.RC1).

If you run into any trouble or would like to report a bug, feature request or similar, use the following channels to get in touch:

* Get help in our [Gitter room](https://gitter.im/mapstruct/mapstruct-users), the [GitHub Discussion](https://github.com/mapstruct/mapstruct/discussions) or [StackOverflow](https://stackoverflow.com/questions/tagged/mapstruct)
* Report bugs and feature requests via the [issue tracker](https://github.com/mapstruct/mapstruct/issues)
* Follow [@GetMapStruct](https://twitter.com/GetMapStruct) on Twitter
