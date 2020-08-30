---
title: "MapStruct 1.4.0.CR1 released"
author: Filip Hrisafov, Sjaak Derksen
date: "2020-08-31"
tags: [release, news]
---

I'm very happy to announce the first candidate release of MapStruct 1.4!

The CR1 release mostly provides bug fixes and other smaller improvements since the [Beta 3](https://mapstruct.org/news/2020-07-19-mapstruct-1_4_0_Beta3-is-out/),
So what did we tackle in 1.4.0.RC1

* Support for using a custom exception for an unexpected value mapping
* Fix various bugs with generics and constructor mapping
* Various small enhancements around error messages

<!--more-->

[8 issues](https://github.com/mapstruct/mapstruct/milestone/33) were fixed for this release.

Thanks to our MapStruct community for being vigilant. The MapStruct authors: [Filip Hrisafov](https://github.com/filiphr), [Christian Bandowski](https://github.com/chris922), [Andrei Arlou](https://github.com/Captain1653) and [Sjaak Derksen](https://github.com/sjaakd). 

Thank you everyone for all your hard work!

### Support for using a custom exception for an unexpected value mapping

In this release we added support for using custom exceptions for unexpected value mappings

e.g.

{{< prettify java >}}
public class CustomIllegalArgumentException extends RuntimeException {

    public CustomIllegalArgumentException(String message) {
        super(message);
    }
}

public enum OrderType {

    RETAIL, STANDARD, NORMAL
}

public enum ExternalOrderType {

    RETAIL, STANDARD, NORMAL
}

@Mapper
public interface OrderTypeMapperMapper {
    
    @EnumMapping(unexpectedValueMappingException = CustomIllegalArgumentException.class)
    ExternalOrderType map(OrderType orderType);
}
{{< /prettify >}}

Will generate the following mapper:

{{< prettify java >}}
public OrderTypeMapperImpl implements OrderTypeMapper {

    @Override
    public ExternalOrderType map(OrderType orderType) {
        if ( orderType == null ) {
            return null;
        }

        ExternalOrderType externalOrderType;

        switch ( orderType ) {
            case STANDARD: externalOrderType = ExternalOrderType.STANDARD;
            break;
            case NORMAL: externalOrderType = ExternalOrderType.NORMAL;
            break;
            case RETAIL: externalOrderType = ExternalOrderType.RETAIL;
            break;
            default: throw new CustomIllegalArgumentException( "Unexpected enum constant: " + orderType );
        }

        return externalOrderType;
    }
}
{{< /prettify >}}

### When will we release 1.4 Final?

We will wait for few weeks to get some feedback from the community and then do the final release for 1.4.
We don't expect major issues, since we have already received good feedback and ironed out the problems that we've had. 

### Download

This concludes our tour through MapStruct 1.4 CR1.
If you'd like to try out the features described above, you can fetch the new release from Maven Central using the following GAV coordinates:

* Annotation JAR: [org.mapstruct:mapstruct:1.4.0.CR1](http://search.maven.org/#artifactdetails|org.mapstruct|mapstruct|1.4.0.CR1|jar) 
* Annotation processor JAR: [org.mapstruct:mapstruct-processor:1.4.0.CR1](http://search.maven.org/#artifactdetails|org.mapstruct|mapstruct-processor|1.4.0.CR1|jar)

Alternatively, you can get ZIP and TAR.GZ distribution bundles - containing all the JARs, documentation etc. - [from GitHub](https://github.com/mapstruct/mapstruct/releases/tag/1.4.0.CR1).

If you run into any trouble or would like to report a bug, feature request or similar, use the following channels to get in touch:

* Get help in our [Gitter room](https://gitter.im/mapstruct/mapstruct-users) or at the [mapstruct-users](https://groups.google.com/forum/?fromgroups#!forum/mapstruct-users) group
* Report bugs and feature requests via the [issue tracker](https://github.com/mapstruct/mapstruct/issues)
* Follow [@GetMapStruct](https://twitter.com/GetMapStruct) on Twitter
