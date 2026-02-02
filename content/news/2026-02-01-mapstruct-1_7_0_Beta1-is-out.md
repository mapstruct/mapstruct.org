---
title: "Native Optional support, improved Kotlin Support, and much more: MapStruct 1.7.0.Beta1 is out"
author: Filip Hrisafov
date: "2026-02-01"
tags: [release, news]
---

It's my pleasure to announce the first Beta release of MapStruct 1.7.

The new release comes with a lot of new functionality, e.g.:

* Native `Optional` support
* Improved Kotlin support
* Support for Java 21 Sequenced Collections
* Support for ignoring multiple target properties at once

<!--more-->

Altogether, not less than [41 issues](https://github.com/mapstruct/mapstruct/issues?q=milestone%3A1.7.0.Beta1) were fixed for this release.

This would not have been possible without our fantastic community of contributors:

* [@xumk](https://github.com/xumk)
* [@cuzfrog](https://github.com/cuzfrog)
* [@MelleD](https://github.com/MelleD)
* [@codeswithritesh](https://github.com/codeswithritesh)
* [@Obolrom](https://github.com/Obolrom)
* [@tangyang9464](https://github.com/tangyang9464)
* [@Zegveld](https://github.com/Zegveld)
* [@rmschots](https://github.com/rmschots)
* [@zyberzebra](https://github.com/zyberzebra)
* [@SamilCan](https://github.com/SamilCan)

Thank you everyone for all your hard work!

We are also accepting donations through https://opencollective.com/mapstruct[Open Collective] or https://github.com/sponsors/mapstruct[GitHub].
We'd like to thank all the supporters that supported us with donations in this period:

* [adesso SE](https://github.com/adessoSE)
* [Cybozu](https://github.com/cybozu)
* [Frederik Hahne](https://opencollective.com/atomfrede)
* [Lansana](https://opencollective.com/lansana)
* [Mercedes-Benz Group](https://github.com/mercedes-benz)
* [Miikka Ylätalo](https://github.com/TotallyMehis)
* [@pmkyl](https://github.com/pmkyl)
* [VEMA eG](https://github.com/vemaeg)
* [znight1020](https://github.com/znight1020)


Enough of the pep talk, let's take a closer look at some of the new features and enhancement!

### Native Optional support

It is now possible to use `java.util.Optional` as a return and source type in MapStruct.
We are also supporting mapping optional properties.

e.g.

{{< prettify java >}}
@Mapper
public interface CustomerMapper {

	Optional<CustomerDto> map(Customer customer);
}
{{< /prettify >}}

Will generate something like

{{< prettify java >}}
// GENERATED CODE
public class CustomerMapperImpl implements CustomerMapper {

    @Override
    public Optional<CustomerDto> map(Customer customer) {
        if ( customer == null ) {
            return Optional.empty();
        }

        CustomerDto customerDto = new CustomerDto();
        // ...
        if ( customer.getName().isPresent() ) {
            customerDto.setName( customer.getName().get() );
        }
        // ...

        return Optional.of( customerDto );
    }

    // ...
}
{{< /prettify >}}

Note that we are not doing any `null` checks for the optional properties. 
Instead, we do a check if the optional is present or not and map it.
There is also support for mapping `OptionalDouble` and `OptionalInt`.
The standard MapStruct out-of-the-box conversions are supported by unwrap the optional.

### Improved Kotlin support

Support for Kotlin has been generally improved across the board.

MapStruct now natively detects that a class is a Kotlin data class and treats it accordingly when generating mappings.
This means that single field data classes, data classes with multiple constructors and constructors with all default parameters work as expected.

Additionally, we have added support for Kotlin's sealed classes as part of our `@SubclassMapping` support.

To use MapStruct with Kotlin, you need to add the following dependency to your project:

#### Maven

{{< prettify xml >}}
<plugin>
    <groupId>org.apache.maven.plugins</groupId>
    <artifactId>maven-compiler-plugin</artifactId>
    <version>3.14.1</version> <!-- or newer version -->
    <configuration>
        <source>${java.version}</source> <!-- depending on your project -->
        <target>${java.version}</target> <!-- depending on your project -->
        <annotationProcessorPaths>
            <path>
                <groupId>org.mapstruct</groupId>
                <artifactId>mapstruct-processor</artifactId>
                <version>${mapstruct.version}</version>
            </path>
            <path>
                <groupId>org.jetbrains.kotlin</groupId>
                <artifactId>kotlin-metadata-jvm</artifactId>
                <version>${kotlin.version}</version>
            </path>
        <!-- other annotation processors -->
        </annotationProcessorPaths>
    </configuration>
</plugin>
{{< /prettify >}}

#### Gradle

{{< prettify groovy >}}
dependencies {
    ...

    annotationProcessor 'org.mapstruct:mapstruct-processor:${mapstruct.version}'
    annotationProcessor 'org.jetbrains.kotlin:kotlin-metadata-jvm:${kotlin.version}'
}
{{< /prettify >}}

We also have something in the pipeline for KSP, so stay tuned!

### Support for Java 21 Sequenced Collections

When using Java 21 Sequenced Collections, MapStuct will generate the appropriate underlying implementation.

* `SequencedSet` - This will generate a `SequencedSet` implementation using the underlying `LinkedHashSet` implementation.
* `SequencedMap` - This will generate a `SequencedMap` implementation using the underlying `LinkedHashMap` implementation.

### Support for ignoring multiple target properties at once

A new annotation `@Ignored` has been added to support ignoring multiple target properties at once.
Instead of writing:

{{< prettify java >}}
@Mapper
public interface AnimalMapper {

    @Mapping( target = "publicAge", ignore = true )
    @Mapping( target = "age", ignore = true )
    @Mapping( target = "publicColor", ignore = true )
    @Mapping( target = "color", ignore = true )
    AnimalDto animalToDto( Animal animal );

}
{{< /prettify >}}

You can now write:

{{< prettify java >}}
@Mapper
public interface AnimalMapper {

    @Ignored( targets = { "publicAge", "age", "publicColor", "color" } )
    AnimalDto animalToDto( Animal animal );

}
{{< /prettify >}}

### Enhancements

* Add support for locale parameter for `numberFormat` and `dateFormat` in `@Mapping` annotation.
* Detect Builder without a factory method. i.e., if there is an inner class that ends with `Builder` and has a constructor with parameters,
  it will be treated as a potential builder.
  Builders through static methods on the type have a precedence.
* Add support for custom exception for subclass exhaustive strategy for `@SubclassMapping` mapping. Available on `@BeanMapping`, `@Mapper` and `@MappingConfig`.
* Add new `NullValuePropertyMappingStrategy#CLEAR` for clearing Collection and Map properties when updating a bean
* Support `@AnnotatedWith` on decorators

### Enhancements with behavior changes

* Add warning/error for redundant `ignoreUnmappedSourceProperties` entries - If a source property that is mapped is also ignored there will be a warning/error.
  The `unmappedSourcePolicy` can be used to control this behavior.
* Warning when the target has no target properties.
* Initialize `Optional` with `Optional.empty` instead of `null` - Before this change, MapStruct would use `null` to initialize an `Optional` target property.
* Mark `String` to `Number` as lossy conversion - This is similar to the behavior of `long` to `int` conversion.
  The `ReportingPolicy` on the `typeConversionPolicy` will be used to determine how to report the lossy conversion.

### Download

This concludes our tour through MapStruct 1.7 Beta1.
If you'd like to try out the features described above, you can fetch the new release from Maven Central using the following GAV coordinates:

* Annotation JAR: [org.mapstruct:mapstruct:1.7.0.Beta1](http://search.maven.org/#artifactdetails|org.mapstruct|mapstruct|1.7.0.Beta1|jar) 
* Annotation processor JAR: [org.mapstruct:mapstruct-processor:1.7.0.Beta1](http://search.maven.org/#artifactdetails|org.mapstruct|mapstruct-processor|1.7.0.Beta1|jar)

Alternatively, you can get ZIP and TAR.GZ distribution bundles - containing all the JARs, documentation etc. - [from GitHub](https://github.com/mapstruct/mapstruct/releases/tag/1.7.0.Beta1).

If you run into any trouble or would like to report a bug, feature request or similar, use the following channels to get in touch:

* Get help in our https://github.com/mapstruct/mapstruct/discussions[GitHub Discussions] or https://stackoverflow.com/questions/tagged/mapstruct[StackOverflow]
* Report bugs and feature requests via the [issue tracker](https://github.com/mapstruct/mapstruct/issues)
* Follow [@GetMapStruct](https://twitter.com/GetMapStruct) on Twitter
