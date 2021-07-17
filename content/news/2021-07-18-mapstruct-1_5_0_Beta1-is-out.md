---
title: "Support for mapping from Map to bean, conditional mapping and much more: MapStruct 1.5.0.Beta1 is out"
author: Filip Hrisafov, Sjaak Derksen
date: "2021-07-18"
tags: [release, news]
---

It's my pleasure to announce the first Beta release of MapStruct 1.5.

The new release comes with a lot of new functionality, e.g.:

* Support for mapping from `Map<String, ???>` to a bean
* Conditional mapping
* Mapping `Iterable<?>` object to an object
* New built-in conversions
* Value mapping enhancements

<!--more-->

Altogether, not less than [41 issues](https://github.com/mapstruct/mapstruct/issues?q=milestone%3A1.5.0.Beta1) were fixed for this release.

This would not have been possible without our fantastic community of contributors:
* [@Blackbaud-JasonBodnar](https://github.com/Blackbaud-JasonBodnar),
* [@dmngb](https://github.com/dmngb),
* [@eforest](https://github.com/eforest),
* [@incaseoftrouble](https://github.com/incaseoftrouble),
* [@jpbassinello](https://github.com/jpbassinello),
* [@JudeNiroshan](https://github.com/JudeNiroshan),
* [@jvwilge](https://github.com/jvwilge),
* [@LukeLaz](https://github.com/LukeLaz),
* [@Saljack](https://github.com/Saljack),
* [@sahebpreet](https://github.com/sahebpreet),
* [@yekeoe](https://github.com/yekeoe),

* and of course seasoned MapStruct hackers [Sjaak Derksen](https://github.com/sjaakd) and [Filip Hrisafov](https://github.com/filiphr).

Thank you everyone for all your hard work!

Slightly more than a year after the first Beta release of 1.4, we are proud to present you with the first Beta of the 1.5 release.

Last time we announced a new community driven effort for MapStruct extensions.
Since then, we have officially released 3 versions of the MapStruct Spring Extensions.
I would like to thank Raimund Klein for successfully leading this MapStruct extension.

Enough of the pep talk, let's take a closer look at some of the new features and enhancement!

### Mapping from Map to Bean

[Mapping from Map to Bean](https://github.com/mapstruct/mapstruct/issues/1075) has been one of the top requested features for MapStruct.

We are happy to announce that as of 1.5.0.Beta1 MapStruct has out of the box support for mapping maps into objects.
Currently, we support mapping from `Map<String, ???>` into an object.
Maps that do not have a `String` as a key will generate a warning and will not be used in the generated code.
The type of the value is not important and same rules for mapping apply as with different types.

e.g. Defining a mapping in the following way

{{< prettify java >}}
public class Customer {
    private Long id;
    private String name;
    //getters and setter omitted for brevity
}

@Mapper
public interface CustomerMapper {
    @Mapping(target = "name", source = "customerName")
    Customer toCustomer(Map<String, String> map);
}
{{< /prettify >}}

Will generate the following code

{{< prettify java >}}
// GENERATED CODE
public class CustomerMapperImpl implements CustomerMapper {

    @Override
    public Customer toCustomer(Map<String, String> map) {
        // ...
        if ( map.containsKey( "id" ) ) {
            customer.setId( Integer.parseInt( map.get( "id" ) ) );
        }
        if ( map.containsKey( "customerName" ) ) {
            customer.setName( source.get( "customerName" ) );
        }
        // ...
    }
}
{{< /prettify >}}

For more details how Mapping Map to Bean works have a look at the [Mapping Map to Bean](http://mapstruct.org/documentation/dev/reference/html/#mapping-map-to-bean) section of the reference guide.

### Conditional Mapping

We've had support for conditional mapping with the help of so called presence check methods on your objects.
Methods like that have the format of `boolean hasXXX()` where `XXX` is the name of the property.
However, this is sometimes limiting since you do not have the possibility to change your object, or you want to have a global check and do not map empty strings.

In this release we have added support for conditional mapping outside your objects.
You can now write custom conditional methods that will be used for checking if a property is present or not in the generated code.
A custom condition method is a method that is annotated with `org.mapstruct.Condition` and returns `boolean`.

For example if you want to map a String property only when it is not null and it is not empty then you can do something like:

{{< prettify java >}}
@Mapper
public interface CarMapper {

    CarDto carToCarDto(Car car);

    @Condition
    default boolean isNotEmpty(String value) {
        return value != null && !value.isEmpty();
    }
}
{{< /prettify >}}

This will generate the following code

{{< prettify java >}}
// GENERATED CODE
public class CarMapperImpl implements CarMapper {

    @Override
    public CarDto carToCarDto(Car car) {
        if ( car == null ) {
            return null;
        }
    
        CarDto carDto = new CarDto();

        if ( isNotEmpty( car.getOwner() ) ) {
            carDto.setOwner( car.getOwner() );
        }

        // Mapping of other properties

        return carDto;
    }
}
{{< /prettify >}}

Methods annotated with `@Condition` work in similar way as other methods (object factories, lifecycle, mapping) in MapStruct.
This means that you can include the source parameter, the `@MappingTarget`, use qualifiers, define your conditions in other classes and use them via `Mapper#uses` 

For more details how conditional mapping works have a look at the [Conditional Mapping](http://mapstruct.org/documentation/dev/reference/html/#conditional-mapping) section of the reference guide.

### Mapping Iterable<?> into an Object

{{< prettify java >}}
@Mapper
public interface CustomerMapper {

    @Mapping(source = "record", target = ".")
    Customer customerDtoToCustomer(CustomerDto customerDto);
}
{{< /prettify >}}

### New Built-In conversions

We have extensive number of built-in conversions between different types.
As of this release we have 2 more:

* Between `String` and `StringBuilder`
* Between `UUID` and `String`

### Value mapping enhancements

#### Case name transformation strategy

In the last release we added a new `@EnumMapping` that allows applying custom functions when mapping between enums.
In this release we are adding a new function `case` for performing case transformation of the source enum.
The new case transformations are:

* `upper` - Performs upper case transformation to the source enum
* `lower` - Performs lower case transformation to the source enum
* `capital` - Performs capitalisation of the first character of every word in the source enum, and everything else to lower case. A word is split by '_'

e.g.

{{< prettify java >}}
public enum CheeseType {
    BRIE,
    ROQUEFORT
}

public enum CheeseTypeLowerCase {
    brie,
    roquefort
}

public enum CheeseTypeCapitalized {
    Brie,
    Roquefort
}

@Mapper
public interface CheeseMapper {

    @EnumMapping(nameTransformationStrategy = "case", configuration = "lowercase")
    CheeseTypeLowerCase map(CheeseType cheese);
    
    @InheritInverseConfiguration
    CheeseType map(CheeseTypePrefixed cheese);
    
    @EnumMapping(nameTransformationStrategy = "case", configuration = "capital")
    CheeseTypeCapitalized map(CheeseType cheese);

    @EnumMapping(nameTransformationStrategy = "case", configuration = "uppercase")
    CheeseType map(CheeseTypeCapitalized cheese);
}
{{< /prettify >}}

#### Throw an exception as a Value Mapping Option

It is now possible to throw an exception for a particular enum.

e.g.

{{< prettify java >}}
@Mapper
public interface OrderTypeMapper {

    @ValueMapping(source = MappingConstants.ANY_UNMAPPED, target = MappingConstants.THROW_EXCEPTION)
    ExternalOrderType map(OrderType cheese);

    @ValueMapping(source = "NORMAL", target = MappingConstants.THROW_EXCEPTION)
    OrderType map(ExternalOrderType cheese);
}
{{< /prettify >}}

In the first example instead of generating a warning MapStruct will throw an exception for all the unmapped enums.

In the second example there will be an exception when mapping from `ExternalOrderType#NORMAL`

### Enhancements

* Add constants for `componentModel` in `MappingConstants.ComponentModel`
* Reuse singleton `INSTANCE` (if it exists) in mapper references when using the default component model
* Add `unmappedTargetPolicy` to `BeanMapping`
* Use instance final fields for custom `DateTimeFormatter`(s) (instead of creating a new instance each time)

### Breaking Changes

* The default implementation for `Map` and `Set` have been changed to use insertion order preserving implementations `LinkedHashMap` and `LinkedHashSet` instead of `HashMap` and `HashSet`. If you still want to use `HashMap` and `HashSet` then you should use an `@ObjectFactory`
* Compile error is created if an unknown property is used in `BeanMapping#ignoreUnmappedSourceProperties` - before the property was ignored which might have lead to false sense of security.

### Varia

There have been numerous bug fixes, which have improved the error reporting and fixed some inconsistencies.

Apart from bug fixes we did some changes in the way we build and test MapStruct.
We have migrated our test suite to use the latest from JUnit 5.
We have adapted our entire build to work on Java 11, this means that we had to remove the nice graphs from our Javadoc. 
The reason for removing them is that the Doclet we were using no longer works on Java 11 and we would like to use the improved Javadoc generation of Java 11.

We have also refactored the way we handle detect generics.

### MapStruct Discussions

We would also like to let you know that we have opened the Discussions section of our GitHub repository and would like to [Welcome you to MapStruct Discussions!](https://github.com/mapstruct/mapstruct/discussions/2518).

We have had (and still have) the [mapstruct-users](https://groups.google.com/forum/?fromgroups#!forum/mapstruct-users) group. 
However, we believe that switching to GitHub Discussions will bring more engagement from our community and will be easier for us to maintain it.

We would like to use these discussions to interact with the community, get ideas from all of you, see best practices, discuss potential new features, ideas, etc.

If you have questions about using MapStruct please continue using [StackOverflow](https://stackoverflow.com/questions/tagged/mapstruct).

### Download

This concludes our tour through MapStruct 1.5 Beta1.
If you'd like to try out the features described above, you can fetch the new release from Maven Central using the following GAV coordinates:

* Annotation JAR: [org.mapstruct:mapstruct:1.5.0.Beta1](http://search.maven.org/#artifactdetails|org.mapstruct|mapstruct|1.5.0.Beta1|jar) 
* Annotation processor JAR: [org.mapstruct:mapstruct-processor:1.5.0.Beta1](http://search.maven.org/#artifactdetails|org.mapstruct|mapstruct-processor|1.5.0.Beta1|jar)

Alternatively, you can get ZIP and TAR.GZ distribution bundles - containing all the JARs, documentation etc. - [from GitHub](https://github.com/mapstruct/mapstruct/releases/tag/1.5.0.Beta1).

If you run into any trouble or would like to report a bug, feature request or similar, use the following channels to get in touch:

* Get help in our [Gitter room](https://gitter.im/mapstruct/mapstruct-users), the [GitHub Discussion](https://github.com/mapstruct/mapstruct/discussions) or [StackOverflow](https://stackoverflow.com/questions/tagged/mapstruct)
* Report bugs and feature requests via the [issue tracker](https://github.com/mapstruct/mapstruct/issues)
* Follow [@GetMapStruct](https://twitter.com/GetMapStruct) on Twitter
