---
title: "MapStruct 1.1.0.Beta1 released"
author: Andreas Gudian
layout: news
tags: [release, news]
---

It has been five months since the release the first final version of MapStruct. We've received a lot of great feedback and noticed a substantial increase of interest in the project. A couple of bugs were reported that we intend to fix with MapStruct 1.1 while also working on new features.

Today we release MapStruct 1.1.0.Beta1, containing fixes for most of the user-reported bugs. But we've also added some improvements and prepared for new features:

* The new annotation `@ValueMapping` is introduced to be used for `enum` mappings. Previously, you would have used `@Mapping` for this, but we found a separate annotation makes things more clear and puts us in a better position for some upcoming features. The usage of `@Mapping` for `enum` mappings now triggers a _deprecation warning_ and ask you to use `@ValueMapping` instead.
* The new annotation `@Named` is a predefined `@Qualifier` that can be used when creating a custom qualifier annotation seems too inconvenient.
* Handling of types with generically typed properties has been improved, so that you can now declare something like `SearchResult<VesselDto> vesselSearchResultToDto(SearchResult<Vessel> vessel)`.
* The preferred way of configuring the annotation processor in Maven projects has been updated to leverage the latest `maven-compiler-plugin` version's `annotationProcessorPaths` option, which makes the configuration a bit more smooth. [Check the updated documentation](/documentation/1.1/reference/html/index.html#setup). 

The complete list of 24 closed issues can be found in the [change log](https://github.com/mapstruct/mapstruct/issues?q=milestone%3A1.1.0.Beta1).

The MapStruct team calls out a big _Thank you!_ to everyone contributing to this release: [Vincent Alexander Beelte](https://github.com/grandmasterpixel), [Oliver Ehrenmüller](https://github.com/greuelpirat), and [Samuel Wright](https://github.com/samwright)! 

### What's next?

We plan the beta phase to be a short one, with a 1.1.0.CR1 release following in a couple of weeks.

In the mean time, you're invited to try out the MapStruct [Eclipse plug-in](https://github.com/mapstruct/mapstruct-eclipse). Although it's in an early stage, it already contains some handy content-assists (e.g. for `source` and `target` property names in the `@Mapping` annotation) and quick-fixes for some common mapping errors detected by MapStruct.

### Download

To fetch MapStruct 1.1.0.Beta1 via Maven, Gradle or similar dependency management tools, use the following GAV coordinates:

* [org.mapstruct:mapstruct:1.1.0.Beta1](http://search.maven.org/#artifactdetails|org.mapstruct|mapstruct|1.1.0.Beta1|jar) for the annotation JAR (to be used with Java <= 7) or [org.mapstruct:mapstruct-jdk8:1.1.0.Beta1](http://search.maven.org/#artifactdetails|org.mapstruct|mapstruct-jdk8|1.1.0.Beta1|jar) (for usage with Java >= 8)
* [org.mapstruct:mapstruct-processor:1.1.0.Beta1](http://search.maven.org/#artifactdetails|org.mapstruct|mapstruct-processor|1.1.0.Beta1|jar) for the annotation processor.

Alternatively, you can download distribution bundles (ZIP, TAR.GZ) from [SourceForge](http://sourceforge.net/projects/mapstruct/files/1.1.0.Beta1/).

* Get help at the [mapstruct-users](https://groups.google.com/forum/?fromgroups#!forum/mapstruct-users) group or in our [Gitter room](https://gitter.im/mapstruct/mapstruct-users)
* Report bugs and feature requests via the [issue tracker](https://github.com/mapstruct/mapstruct/issues)
* Follow [@GetMapStruct](https://twitter.com/GetMapStruct) on Twitter
* Follow MapStruct on [Google+](https://plus.google.com/u/0/118070742567787866481/posts)

Happy Mapping!
