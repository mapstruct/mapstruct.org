---
title: "Conditional mapping for source parameters and much more: MapStruct 1.6.0.Beta2 is out"
author: Filip Hrisafov
date: "2024-05-11"
tags: [release, news]
---

It's my pleasure to announce the second Beta release of MapStruct 1.6.

The new release comes with some new functionality, e.g.:

* Conditional mapping for source parameters
* Support to access source property name in condition methods via an annotation

This release is also our first release that has been fully automated using the great [JReleaser](https://jreleaser.org/).
This would hopefully mean that we can realase more often, as the burden of manual release has been reduced.

We'd like to thank our new supporters:

* [Cybozu](https://github.com/cybozu)
* [Juyoung Kim](https://github.com/kjuyoung)
* [Lansana](https://opencollective.com/lansana)
* [Mariselvam](https://github.com/marisnb)
* [PRISMA European Capacity Platform GmbH](https://github.com/jan-prisma)
* [St. Galler Kantonalbank AG](https://opencollective.com/st-galler-kantonalbank-ag)

And of course thanks to our previous supporters:

* [adesso SE](https://github.com/adessoSE)
* [Bileto](https://opencollective.com/bileto)
* [Frederik Hahne](https://opencollective.com/atomfrede)

If you'd like to join this list and donate to the project MapStruct is accepting donations through [Open Collective](https://opencollective.com/mapstruct) or [GitHub](https://github.com/sponsors/mapstruct).

<!--more-->

Altogether, not less than [19 issues](https://github.com/mapstruct/mapstruct/issues?q=milestone%3A1.6.0.Beta2) were fixed for this release.

This would not have been possible without our fantastic community of contributors:

* [@dehasi](https://github.com/dehasi)
* [@hduelme](https://github.com/hduelme)
* [@mosesonline](https://github.com/mosesonline)
* [@the-mgi](https://github.com/the-mgi)
* [@wandi34](https://github.com/wandi34)

* and of course seasoned MapStruct hackers [Ben Zegveld](https://github.com/Zegveld), [Oliver Erhart](https://github.com/thunderhook), [Sjaak Derksen](https://github.com/sjaakd), [Filip Hrisafov](https://github.com/filiphr).

Thank you everyone for all your hard work!

Enough of the pep talk, let's take a closer look at some of the new features and enhancement!

### Conditional mapping for source parameters

It is now possible to use custom condition checks for source parameters.
In order to support this we have enhanced the existing `@Condition` annotation with a new attribute `appliesTo` and a new `ConditionStrategy`.

By default, the `@Condition` is only applicable to properties.
However, you co do `@Condition(appliesTo = ConditionStrategy.SOURCE_PARAMETERS)`, or use the meta annotated `@SourceParameterCondition`.

e.g.

{{< prettify java >}}
public class PresenceCheckUtils {

    @SourceParameterCondition
    public static boolean isDefined(Car car) {
        return car != null && car.getId() !+ null;
    }

}

@Mapper(uses = PresenceCheckUtils.class)
public interface CarMapper {

	CarDto map(Car car);
}
{{< /prettify >}}

Will generate something like

{{< prettify java >}}
// GENERATED CODE
public class CarMapperImpl implements CarMapper {

    @Override
    public CarDto map(Car car) {
        if ( !PresenceCheckUtils.isDefined( car ) ) {
            return null;
        }
        // ...
    }

    // ...
}
{{< /prettify >}}


### Support to access source property name in condition methods via an annotation

In 1.6.0.Beta1 we added `@TargetPropertyName` which was giving access to the name of the target property.
In this release we are adding `@SourceProeprtyName` which gives access to the name of the source property.

e.g.

{{< prettify java >}}
public class HibernateUtils {

    @Condition
    public static boolean isAccessible(Customer customer, @SourcePropertyName String propertyName) {
        return Hibernate.isPropertyInitialized(customer, propertyName);
    }

}

@Mapper(uses = HibernateUtils.class)
public interface CustomerMapper {

	CustomerDto map(Customer customer);
}
{{< /prettify >}}

Will generate something like

{{< prettify java >}}
// GENERATED CODE
public class CustomerMapperImpl implements CustomerMapper {

    @Override
    public CustomerDto map(Customer customer) {
        // ...
        if ( HiberateUtils.isAccessible( customer, "computedOrders" ) ) {
            customer.setOrders( mapOrders( customer.getComputedOrders() ) );
        }
        // ...
    }

    // ...
}
{{< /prettify >}}

### Enhancements

* Improve error message when using `target = "."` -  This has never been fully been supported by MapStruct, and it might have worked by accident. We are now displaying an improved error message.
* Improve error messages for auto generated mappings - MapStruct will now show the user defined method and the mapper leading to the error.
* Remove unnecessary casts to long in generated code.

### Download

This concludes our tour through MapStruct 1.6 Beta2.
If you'd like to try out the features described above, you can fetch the new release from Maven Central using the following GAV coordinates:

* Annotation JAR: [org.mapstruct:mapstruct:1.6.0.Beta2](http://search.maven.org/#artifactdetails|org.mapstruct|mapstruct|1.6.0.Beta2|jar) 
* Annotation processor JAR: [org.mapstruct:mapstruct-processor:1.6.0.Beta2](http://search.maven.org/#artifactdetails|org.mapstruct|mapstruct-processor|1.6.0.Beta2|jar)

Alternatively, you can get ZIP and TAR.GZ distribution bundles - containing all the JARs, documentation etc. - [from GitHub](https://github.com/mapstruct/mapstruct/releases/tag/1.6.0.Beta2).

If you run into any trouble or would like to report a bug, feature request or similar, use the following channels to get in touch:

* Get help in [GitHub Discussions](https://github.com/mapstruct/mapstruct/discussions) or [StackOverflow](https://stackoverflow.com/questions/tagged/mapstruct)
* Report bugs and feature requests via the [issue tracker](https://github.com/mapstruct/mapstruct/issues)
* Follow [@GetMapStruct](https://twitter.com/GetMapStruct) on Twitter
