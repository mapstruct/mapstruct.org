---
title: "MapStruct Spring Extensions 0.0.2 released"
author: Raimund Klein
date: "2021-02-15"
tags: [release, news]
---

It is my pleasure to announce the second official release of MapStruct Spring Extensions.
What started out as a [StackOverflow question](https://stackoverflow.com/q/58081224/3361467) over a year ago has turned into its own [(sub-)project](https://github.com/mapstruct/mapstruct-spring-extensions) within the MapStruct organization.

This second release allows specifying a defined name for the generated ConversionServiceAdapter bean. Kudos go to [David Hamilton](https://github.com/dmham86) for this contribution. Additionally, you will now find a [reference guide](/documentation/spring-extensions/reference/html/) on the main MapStruct homepage.

Including the annotations and extensions defined in this project will generate a class acting as bridge between MapStruct's conventions and Spring's [ConversionService API](https://docs.spring.io/spring-framework/docs/current/reference/html/core.html#core-convert-ConversionService-API) that in turn can be added to any Mapper's `uses` attribute. See the [examples](https://github.com/mapstruct/mapstruct-spring-extensions/tree/master/examples) for details. 

<!--more-->

### Thanks

Thanks to [Sjaak Derksen](https://github.com/sjaakd) for suggesting this solution and [Filip Hrisafov](https://github.com/filiphr) for opening the community project.
If you feel like there's something missing in MapStruct which could make the Spring experience any smoother, please get involved!

Also, if your favourite library or framework could use some tweaking with regard to MapStruct, contact us.    

Happy coding with MapStruct Spring Extensions!

### Download

You can fetch the release from Maven Central using the following GAV coordinates:

* Annotation JAR: [org.mapstruct.extensions.spring:mapstruct-spring-annotations:0.0.2](http://search.maven.org/#artifactdetails|org.mapstruct.extensions.spring|mapstruct-spring-annotations|0.0.2|jar)
* Annotation processor JAR: [org.mapstruct.extensions.spring:mapstruct-spring-extensions:0.0.2](http://search.maven.org/#artifactdetails|org.mapstruct.extensions.spring|mapstruct-spring-extensions|0.0.2|jar)

Alternatively, you can get ZIP and TAR.GZ distribution bundles - containing all the JARs, documentation etc. - [from GitHub](https://github.com/mapstruct/mapstruct-spring-extensions/releases/tag/v0.0.2).

If you run into any trouble or would like to report a bug, feature request or similar, use the following channels to get in touch:

* Get help in our [Gitter room](https://gitter.im/mapstruct/mapstruct-users) or at the [mapstruct-users](https://groups.google.com/forum/?fromgroups#!forum/mapstruct-users) group
* Report bugs and feature requests via the [issue tracker](https://github.com/mapstruct/mapstruct-spring-extensions/issues)
* Follow [@GetMapStruct](https://twitter.com/GetMapStruct) on Twitter
