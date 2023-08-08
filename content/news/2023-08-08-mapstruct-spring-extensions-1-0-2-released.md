---
title: "MapStruct Spring Extensions 1.0.1 released"
author: Raimund Klein
date: "2023-04-23"
tags: [release, news]
---

It is my pleasure to announce the next official release of MapStruct Spring Extensions.
What started out as a [StackOverflow question](https://stackoverflow.com/q/58081224/3361467) turned into its own [(sub-)project](https://github.com/mapstruct/mapstruct-spring-extensions) within the MapStruct organization.

Changes in this release:
- Spring Extensions will now honour the `mapstruct.suppressGeneratorTimestamp` processor option. Thanks to [freund17](https://github.com/freund17) and [coding-guo](https://github.com/coding-guo) for pointing out this omission.

We're functionally complete. There are currently no plans for further features, although we will keep an eye on compatibility with future MapStruct and Spring releases as well as community requests.

Including the annotations and extensions defined in this project will generate a class acting as bridge between MapStruct's conventions and Spring's [ConversionService API](https://docs.spring.io/spring-framework/docs/current/reference/html/core.html#core-convert-ConversionService-API) that in turn can be added to any Mapper's `uses` attribute. See the [examples](https://github.com/mapstruct/mapstruct-spring-extensions/tree/master/examples) for details.

<!--more-->

### Thanks

Thanks to [Sjaak Derksen](https://github.com/sjaakd) for suggesting this solution and [Filip Hrisafov](https://github.com/filiphr) for opening the community project.
Also thanks to [Cosimo Damiano Prete](https://github.com/cdprete), [Daniel Shiplett](https://github.com/danielshiplett), [Alexey](https://github.com/PRIESt512), [Olivier Boudet](https://github.com/olivierboudet), [John Kelly](https://github.com/postalservice14), [Myat Min](https://github.com/myatmin), [Hypercube Software](https://github.com/hypercube-software) and [coding-guo](https://github.com/coding-guo) for their suggestions and fixes in previous releases.
If you feel like there's something missing in MapStruct which could make the Spring experience any smoother, please get involved!

Also, if your favourite library or framework could use some tweaking with regard to MapStruct, contact us.

Happy coding with MapStruct Spring Extensions!

### Download

You can fetch the release from Maven Central using the following GAV coordinates:

* Annotation JAR: [org.mapstruct.extensions.spring:mapstruct-spring-annotations:1.0.1](http://search.maven.org/#artifactdetails|org.mapstruct.extensions.spring|mapstruct-spring-annotations|1.0.1|jar)
* Annotation processor JAR: [org.mapstruct.extensions.spring:mapstruct-spring-extensions:1.0.1](http://search.maven.org/#artifactdetails|org.mapstruct.extensions.spring|mapstruct-spring-extensions|1.0.1|jar)

Alternatively, you can get ZIP and TAR.GZ distribution bundles - containing all the JARs, documentation etc. - [from GitHub](https://github.com/mapstruct/mapstruct-spring-extensions/releases/tag/v1.0.1).

If you run into any trouble or would like to report a bug, feature request or similar, use the following channels to get in touch:

* Get help in our [Gitter room](https://gitter.im/mapstruct/mapstruct-users) or at the [mapstruct-users](https://groups.google.com/forum/?fromgroups#!forum/mapstruct-users) group
* Report bugs and feature requests via the [issue tracker](https://github.com/mapstruct/mapstruct-spring-extensions/issues)
* Follow [@GetMapStruct](https://twitter.com/GetMapStruct) on Twitter
