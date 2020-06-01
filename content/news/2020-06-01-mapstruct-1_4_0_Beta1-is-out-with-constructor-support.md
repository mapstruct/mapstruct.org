---
title: "Support for constructors, Gradle incremental compilation and much more: MapStruct 1.4.0.Beta1 is out"
author: Filip Hrisafov, Sjaak Derksen
date: "2020-06-01"
tags: [release, news]
---

It' my pleasure to announce the first Beta release of MapStruct 1.4.

The new release comes with a whole lot of new functionality, e.g.:

* Making use of constructor arguments when instantiating mapping targets
* Support Gradle incremental annotation processing feature
* Map nested bean properties to current target
* Support value mapping between `String` and `Enum`
* Support `@Mapping` in meta annotations
* User control over mapping features (direct, method, conversion, 2step)
* Support mapping from / to Java 14 records (preview feature)
* New `EnumTransformationStrategy` and `EnumNamingStrategy` SPIs  

<!--more-->

Altogether, not less than [76 issues](https://github.com/mapstruct/mapstruct/issues?q=milestone%3A1.4.0.Beta1) were fixed for this release.

This would not have been possible without our fantastic community of contributors:
* [@Zomzog](https://github.com/Zomzog),
* [@xcorail](https://github.com/xcorail),
* [@juliojgd](https://github.com/juliojgd),
* [@power721](https://github.com/power721),
* [@mattdrees](https://github.com/mattdrees),
* [@jakraska](https://github.com/jakraska),
* [@dekelpilli](https://github.com/dekelpilli),
* [@ttzn](https://github.com/ttzn),
* [@fml2](https://github.com/fml2),
* [@marceloverdijk](https://github.com/marceloverdijk),
* [@vegemite4me](https://github.com/vegemite4me),
* [@timjb](https://github.com/timjb),
* [@sullis](https://github.com/sullis),
* [@pradzins](https://github.com/pradzins),
* [@seime](https://github.com/seime),
and of course seasoned MapStruct hackers [Sjaak Derksen](https://github.com/sjaakd), [Filip Hrisafov](https://github.com/filiphr), [Christian Bandowski](https://github.com/chris922) and [Andrei Arlou](https://github.com/Captain1653). Thanks to [Gunnar Morling](https://github.com/gunnarmorling) and [Andreas Gudian](https://github.com/agudian) for the council and advice on this release.

Thank you everyone for all your hard work!

We know that it took us some time to do this, and we want to thank everyone for the patience.

This release is also the first release which uses our new Gem Tools project instead of [Hickory](https://web.archive.org/web/20070724060104/https://hickory.dev.java.net/).
You can read more about it in the [Announcing Gem Tools](/news/2020-02-03-announcing-gem-tools.md) blog.
With this release we also want to introduce a new community driven effort for different MapStruct extensions. 
More about it below. 

Enough of the pep talk, let's take a closer look at some of the new features!

### Making use of constructor arguments when instantiating mapping targets

Making use of [constructor arguments](https://github.com/mapstruct/mapstruct/issues/73) when instantiating mapping targets has been one of the oldest and the most requested feature of MapStruct.

We are happy to announce that as of 1.4.0.Beta1 MapStruct has out of the box support for mapping your immutable objects via constructors.
This works with:

* [Java 14 Records](https://openjdk.java.net/jeps/359)
* [Kotlin Data Classes](https://kotlinlang.org/docs/reference/data-classes.html)

For more details how the Constructor support works have a look at the [Using constructors](http://mapstruct.org/documentation/dev/reference/html/#mapping-with-constructors) section of the reference guide.

### Gradle incremental annotation processing

Starting From Gradle 4.7, Gradle has supported [incremental annotation processing](https://docs.gradle.org/current/userguide/java_plugin.html#sec:incremental_annotation_processing).
We are happy to say that starting from 1.4.0.Beta1 MapStruct is an isolating processor. 
MapStruct will no longer be the reason for triggering an entire recompilation in your Gradle projects.


### Map nested bean properties to current target

Using this you can map nested properties to the current target object.

{{< prettify java >}}
@Mapper
public interface CustomerMapper {

    @Mapping(source = "record", target = ".")
    Customer customerDtoToCustomer(CustomerDto customerDto);
}
{{< /prettify >}}


The generated code will map every property from `CustomerDto.record` to `Customer` directly, without need to manually name any of them.

For more details have a look at the [Mapping nested bean properties to current target](http://mapstruct.org/documentation/dev/reference/html/#mapping-nested-bean-properties-to-current-target) section of the reference guide.

### Value mapping between `String` and `Enum`

We've had support for mapping between different enums for a while now.
In this release we iterated over that and expanded to support mapping between `String` and `Enum`.

{{< prettify java >}}
public enum CheeseType {
    BRIE,
    ROQUEFORT
}

@Mapper
public interface CheeseMapper {

    String cheeseToString(CheeseType cheese);
    
    CheeseType stringToCheese(String cheese);
}
{{< /prettify >}}

This would generate an implementation that would use the enum value constants for mapping.
This can be customised by using `@ValueMapping`.

For more details have a look at the [Mapping Value](http://mapstruct.org/documentation/dev/reference/html/#mapping-enum-types) section of the reference guide.

### Support `@Mapping` in meta annotations

Starting from 1.4.0.Beta1 there is an experimental support for `@Mapping` compositions.
This allows reusing `@Mapping` via other annotations. 

e.g.

{{< prettify java >}}
@Retention(RetentionPolicy.CLASS)
@Mapping(target = "id", ignore = true)
@Mapping(target = "creationDate", expression = "java(new java.util.Date())")
@Mapping(target = "name", source = "groupName")
public @interface ToEntity { }

@Mapper
public interface StorageMapper {
    
    @ToEntity
    @Mapping( target = "weightLimit", source = "maxWeight")
    ShelveEntity map(ShelveDto source);
    
    @ToEntity
    @Mapping( target = "label", source = "designation")
    BoxEntity map(BoxDto source);
}
{{< /prettify >}}

This is an alternative to using inheritance configuration.
The difference here is that the entities don't need to have any common hierarchy. 
The `@Mapping` annotations from `@ToEntity` are transformed as if they have been written on the method.

For more details have a look at the [Mapping Composition](http://mapstruct.org/documentation/dev/reference/html/#mapping-composition) section of the reference guide.

### User control over mapping features

MapStruct has an extensive support for implicit type conversions, reusing other mappers, 2 step conversion, etc.
However, users were not able to control this.
For example it was not possible to easily tell MapStruct to create a Mapper for deep cloning.

In 1.4.0.Beta1 we added a new experimental annotation (`@MappingControl`) that can be used to control how the mapping should be performed.
It can enable or disable certain types of mappings.
This can be set over the different mechanisms that we support (`@BeanMapping`, `@Mapper`, `@MapperConfig`, etc.)

The following mapping possibilities exist:

* `BUILT_IN_CONVERSION` - Allows using the built in MapStruct type conversions
* `COMPLEX_MAPPING` - Allows using 2 step mappings (type conversion passed into a mapping method, mapping method passed into a type conversion and mapping method passed into another mapping method)
* `DIRECT` - Allows using direct mapping when the source and target type match. Types from the `java` package are always directly mapped
* `MAPPING_METHOD` - Allows using custom referred or built in mapping methods

Apart from being able to create your own `@MappingControl` there are some out of the box controls:

* `@DeepClone` - Clones a source type to a target type (assuming source and target are of the same type).
* `@NoComplexMapping` - Disables complex mappings, mappings that require 2 mapping means (method, built-in conversion) to constitute a mapping from source to target. This can speed up your compilation if you have mappers with a lot of methods

e.g.

{{< prettify java >}}
public class ShelveDTO {

    private CoolBeerDTO coolBeer;

    public CoolBeerDTO getCoolBeer() {
        return coolBeer;
    }

    public void setCoolBeer(CoolBeerDTO coolBeer) {
        this.coolBeer = coolBeer;
    }
}

public class CoolBeerDTO {

    private String beerCount;

    public String getBeerCount() {
        return beerCount;
    }

    public void setBeerCount(String beerCount) {
        this.beerCount = beerCount;
    }
}

@Mapper(mappingControl = DeepClone.class)
public interface CloningMapper {

    FridgeDTO clone(FridgeDTO in);
}
{{< /prettify >}}

In the example above without using `@Mapper(mappingControl = DeepClone.class)` MapStruct will create a shallow copy of `coolBeer` in `FridgeDto`.

### New SPIs for Value (Enum) mappings

There have been a lot of requests for supporting different ways of auto mapping enums.
For example using a prefix / suffix when mapping between different generated enums.

In this release we've reiterated over this and have added new ways of customizing this.
We've added a new annotation (`@EnumMapping`) for customizing how an enum mapping should look like.

And we added 2 new SPIs:

* [`EnumTransformationStrategy`](https://mapstruct.org/documentation/stable/api/org/mapstruct/ap/spi/EnumTransformationStrategy.html)
* [`EnumNamingStrategy`](https://mapstruct.org/documentation/stable/api/org/mapstruct/ap/spi/EnumNamingStrategy.html)

For more details have a look at the [Mapping Value](http://mapstruct.org/documentation/dev/reference/html/#mapping-enum-types) section of the reference guide.

#### EnumTransformationStrategy SPI

This is an SPI which allows registering custom functions that can be applied when mapping between enums on a case by case basis.
The following are the out of the box functions:

* `suffix` - Applies a suffix on the source enum
* `stripSuffix` - Strips a suffix from the source enum
* `prefix` - Applies a prefix on the source enum
* `stripPrefix` - Strips a prefix from the source enum

e.g.

{{< prettify java >}}
public enum CheeseType {
    BRIE,
    ROQUEFORT
}

public enum CheeseTypePrefixed {
    CUSTOM_BRIE,
    CUSTOM_ROQUEFORT
}

public enum CheeseTypeSuffixed {
    BRIE_CHEESE,
    ROQUEFORT_CHEESE
}

@Mapper
public interface CheeseMapper {

    @EnumMapping(nameTransformationStrategy = "prefix", configuration = "CUSTOM_")
    CheeseTypePrefixed map(CheeseType cheese);
    
    @InheritInverseConfiguration
    CheeseType map(CheeseTypePrefixed cheese);
    
    @EnumMapping(nameTransformationStrategy = "suffix", configuration = "_CHEESE")
    CheeseTypeSuffixed map(CheeseType cheese);
 
    @InheritInverseConfiguration
    CheeseType map(CheeseTypeSuffixed cheese);
}
{{< /prettify >}}

#### EnumNamingStrategy SPI

This SPI is more advanced and is similar to the `AccessorNamingStrategy`. 
It opens the door for even more customization and providing a way to auto map enums which follow a certain standard.

One example is the Protobuf [Enum Style Guide](https://developers.google.com/protocol-buffers/docs/style#enums).

### Enhancements

* Add "verbose" processor option to print out details if required - Can be activated by using the compiler argument `mapstruct.verbose=true`
* Add imports to `@MapperConfig`
* Annotation processor option for default injection strategy 
* Allow mapping between enum and non enum in the same way as mapping between primitive and objects
* Support for conversion between `java.time.LocalDateTime` and `javax.xml.datatype.XMLGregorianCalendar`

### MapStruct Community Extensions

Apart from all the new features and enhancements with this release.
We would like to introduce a new concept with which we are trying to improve the MapStruct experience.

MapStruct has a lot of functionality and there are a lot of different ways that it can be used.
Recently [Raimund Klein](https://github.com/Chessray) came up with an interesting idea for providing some extra helpful additions to MapStruct when using the [Spring Framework](https://spring.io/).
This idea lead to an initial implementation, which lead to creating the first community extension, the [MapStruct Spring Extensions](https://github.com/mapstruct/mapstruct-spring-extensions).
I would like to thank Raimund for the initiative and taking the lead for this project.
There is still no release from this extension, because it is waiting on some enhancements coming from this release.

The idea of these extensions is to have their own releases which are entirely independent of MapStruct core and are driven by the community.
The way we envision this is to have different extensions for different technology stacks (e.g. Quarkus, Micronaut, Protobuf, etc.).
In case someone has an idea and wants to propose a new extension feel free to reach to us. 

### Download

This concludes our tour through MapStruct 1.4 Beta1.
If you'd like to try out the features described above, you can fetch the new release from Maven Central using the following GAV coordinates:

* Annotation JAR: [org.mapstruct:mapstruct:1.4.0.Beta1](http://search.maven.org/#artifactdetails|org.mapstruct|mapstruct|1.4.0.Beta1|jar) 
* Annotation processor JAR: [org.mapstruct:mapstruct-processor:1.4.0.Beta1](http://search.maven.org/#artifactdetails|org.mapstruct|mapstruct-processor|1.4.0.Beta1|jar)

Alternatively, you can get ZIP and TAR.GZ distribution bundles - containing all the JARs, documentation etc. - [from GitHub](https://github.com/mapstruct/mapstruct/releases/tag/1.4.0.Beta1).

If you run into any trouble or would like to report a bug, feature request or similar, use the following channels to get in touch:

* Get help in our [Gitter room](https://gitter.im/mapstruct/mapstruct-users) or at the [mapstruct-users](https://groups.google.com/forum/?fromgroups#!forum/mapstruct-users) group
* Report bugs and feature requests via the [issue tracker](https://github.com/mapstruct/mapstruct/issues)
* Follow [@GetMapStruct](https://twitter.com/GetMapStruct) on Twitter
