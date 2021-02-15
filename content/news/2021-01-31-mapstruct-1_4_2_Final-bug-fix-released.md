---
title: "MapStruct 1.4.2.Final bug fix released"
author: Filip Hrisafov
date: "2021-01-31"
tags: [release, news]
---

It is my pleasure to announce the 1.4.2.Final bug fix release of MapStruct.

This release includes 2 enhancements, 10 bug fixes, and some documentation fixes.

The most notable enhancement is the relaxing of the strictness for `Mapping#qualifiedByName` and `Mapping#qualifier` for collection mappings.

<!--more-->

### Relaxing qualifiers for collections

In 1.4.0 we made the qualifiers stricter, which lead to certain things like delegating the `Mapping#qualifiedByName` and `Mapping#qualifiedBy` no longer working.
We relaxed this in 1.4.2 and now the following example works again.

{{< prettify java >}}
@Mapper
public interface TopologyMapper {

    @Mapping( target = "topologyFeatures", qualifiedByName = "Rivers" )
    Topology mapTopologyAsRiver(TopologyDto dto);

    @Named("Rivers")
    default TopologyFeature mapRiver( TopologyFeatureDto dto ) {
        if ( dto instanceof RiverDto ) {
            River river = new River();
            river.setLength( ( (RiverDto) dto ).getLength() );
            river.setName(  dto.getName() );
            return river;
        }

        throws UnsupportedOperationException( "dto is not an instance of RiverDto" );
    }

}
{{< /prettify >}}

### Thanks

Thanks to our entire community for reporting these errors and being patient with our release schedule. 

Happy coding with MapStruct 1.4.2!!

### Download

You can fetch the new release from Maven Central using the following GAV coordinates:

* Annotation JAR: [org.mapstruct:mapstruct:1.4.2.Final](http://search.maven.org/#artifactdetails|org.mapstruct|mapstruct|1.4.2.Final|jar)
* Annotation processor JAR: [org.mapstruct:mapstruct-processor:1.4.2.Final](http://search.maven.org/#artifactdetails|org.mapstruct|mapstruct-processor|1.4.2.Final|jar)

Alternatively, you can get ZIP and TAR.GZ distribution bundles - containing all the JARs, documentation etc. - [from GitHub](https://github.com/mapstruct/mapstruct/releases/tag/1.4.2.Final).

If you run into any trouble or would like to report a bug, feature request or similar, use the following channels to get in touch:

* Get help in our [Gitter room](https://gitter.im/mapstruct/mapstruct-users) or at the [mapstruct-users](https://groups.google.com/forum/?fromgroups#!forum/mapstruct-users) group
* Report bugs and feature requests via the [issue tracker](https://github.com/mapstruct/mapstruct/issues)
* Follow [@GetMapStruct](https://twitter.com/GetMapStruct) on Twitter
