---
title: "MapStruct Spring Extensions 1.1.3 released"
author: Raimund Klein
date: "2025-03-14"
tags: [ release, news ]
---

It is my pleasure to announce the next official release of MapStruct Spring Extensions.
What started out as a [StackOverflow question](https://stackoverflow.com/q/58081224/3361467) turned into its
own [(sub-)project](https://github.com/mapstruct/mapstruct-spring-extensions) within the MapStruct organization.

Changes in this release:

- The change introduced in the previous release which stored TypeDescriptors as fields in the generated Adapter class caused rare issues with certain generic type definitions. [Jesse Bonzo](https://github.com/jbonzohln) has thankfully provided a fix for this. 
- The modified converter scan led to errors when used with multiple `SpringMapperConfig`s in the same project, because it would generate several configurations with identical bean names. Thanks to [simonovdenis](https://github.com/simonovdenis), we have now got an option to configure the name for the generated configuration as well.

Including the annotations and extensions defined in this project will generate a class acting as bridge between
MapStruct's conventions and Spring'
s [ConversionService API](https://docs.spring.io/spring-framework/docs/current/reference/html/core.html#core-convert-ConversionService-API)
that in turn can be added to any Mapper's `uses` attribute. See
the [examples](https://github.com/mapstruct/mapstruct-spring-extensions/tree/master/examples) for details.

<!--more-->

### Thanks

Thanks to [Sjaak Derksen](https://github.com/sjaakd) for suggesting this solution
and [Filip Hrisafov](https://github.com/filiphr) for opening the community project.
Also thanks
to [Jeff Schnitzer](https://github.com/stickfigure), [Jesse Bonzo](https://github.com/jbonzohln), [Cosimo Damiano Prete](https://github.com/cdprete), [Daniel Shiplett](https://github.com/danielshiplett), [Alexey](https://github.com/PRIESt512), [Olivier Boudet](https://github.com/olivierboudet), [John Kelly](https://github.com/postalservice14), [Myat Min](https://github.com/myatmin), [Hypercube Software](https://github.com/hypercube-software), [coding-guo](https://github.com/coding-guo), [freund17](https://github.com/freund17), [Joose Haverinen](https://github.com/joosehav), [pw-lehre](https://github.com/pw-lehre),
and [George Noble](https://github.com/giorgioscia) for their suggestions and fixes in previous releases.
If you feel like there's something missing in MapStruct which could make the Spring experience any smoother, please get
involved!

Also, if your favourite library or framework could use some tweaking with regard to MapStruct, contact us.

Happy coding with MapStruct Spring Extensions!

### Download

You can fetch the release from Maven Central using the following GAV coordinates:

* Annotation
  JAR: [org.mapstruct.extensions.spring:mapstruct-spring-annotations:1.1.3](http://search.maven.org/#artifactdetails|org.mapstruct.extensions.spring|mapstruct-spring-annotations|1.1.3|jar)
* Annotation processor
  JAR: [org.mapstruct.extensions.spring:mapstruct-spring-extensions:1.1.3](http://search.maven.org/#artifactdetails|org.mapstruct.extensions.spring|mapstruct-spring-extensions|1.1.3|jar)
* Test Extensions with Converter Scan
  JAR: [org.mapstruct.extensions.spring:mapstruct-spring-extensions:1.1.3](http://search.maven.org/#artifactdetails|org.mapstruct.extensions.spring|mapstruct-spring-test-extensions|1.1.3|jar)

Alternatively, you can get ZIP and TAR.GZ distribution bundles - containing all the JARs, documentation
etc. - [from GitHub](https://github.com/mapstruct/mapstruct-spring-extensions/releases/tag/v1.1.3).

If you run into any trouble or would like to report a bug, feature request or similar, use the following channels to get
in touch:

* Get help in our [Gitter room](https://gitter.im/mapstruct/mapstruct-users) or at
  the [mapstruct-users](https://groups.google.com/forum/?fromgroups#!forum/mapstruct-users) group
* Report bugs and feature requests via
  the [issue tracker](https://github.com/mapstruct/mapstruct-spring-extensions/issues)
* Follow [@GetMapStruct](https://twitter.com/GetMapStruct) on Twitter
