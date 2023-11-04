---
title: "Support for accessing property names, passing annotations to generated code, sponsoring MapStruct and much more: MapStruct 1.6.0.Beta1 is out"
author: Filip Hrisafov
date: "2023-11-04"
tags: [release, news]
---

It's my pleasure to announce the first Beta release of MapStruct 1.6.

The new release comes with a lot of new functionality, e.g.:

* Access to target / source property names in conditional and mapping methods
* Passing annotations to generated code
* Add javadoc to generated code
* New built-in conversions

With this release we are also happy to announce that MapStruct has started accepting donations through [Open Collective](https://opencollective.com/mapstruct) or [GitHub](https://github.com/sponsors/mapstruct).
We'd like to thank to everyone that has already started in supporting us:

* [addesso SE](https://github.com/adessoSE)
* [Bileto](https://opencollective.com/bileto)
* [Frederik Hahne](https://opencollective.com/atomfrede)

<!--more-->

Altogether, not less than [63 issues](https://github.com/mapstruct/mapstruct/issues?q=milestone%3A1.6.0.Beta1) were fixed for this release.

This would not have been possible without our fantastic community of contributors:

* [@anton-erofeev](https://github.com/anton-erofeev)
* [@Blackbaud-JasonBodnar](https://github.com/Blackbaud-JasonBodnar)
* [@Bragolgirith](https://github.com/Bragolgirith)
* [@chenzijia12300](https://github.com/chenzijia12300)
* [@eroznik](https://github.com/eroznik)
* [@EvaristeGalois11](https://github.com/EvaristeGalois11)
* [@ivlcic](https://github.com/ivlcic)
* [@jccampanero](https://github.com/jccampanero)
* [@kooixh](https://github.com/kooixh)
* [@MengxingYuan](https://github.com/MengxingYuan)
* [@MLNW](https://github.com/MLNW)
* [@Nikolas-Charalambidis](https://github.com/Nikolas-Charalambidis)
* [@paparadva](https://github.com/paparadva)
* [@prasanth08](https://github.com/prasanth08)
* [@ro0sterjam](https://github.com/ro0sterjam)
* [@rgdoliveira](https://github.com/rgdoliveira)
* [@venkatesh2090](https://github.com/venkatesh2090)

* our latest MapStruct contributor [Oliver Erhart](https://github.com/thunderhook)
* and of course seasoned MapStruct hackers [Ben Zegveld](https://github.com/Zegveld), [Sjaak Derksen](https://github.com/sjaakd), [Filip Hrisafov](https://github.com/filiphr).

Thank you everyone for all your hard work!

Slightly more than a year after the first Beta release of 1.6, we are proud to present you with the first Beta of the 1.6 release.

Enough of the pep talk, let's take a closer look at some of the new features and enhancement!

### Access to target / source property names in conditional and mapping methods

It is now possible to get access to the target property name in conditional and mapping methods.

e.g.

{{< prettify java >}}
public class HibernateUtils {

    @Condition
    public static boolean isAccessible(Customer customer, @TargetPropertyName String propertyName) {
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
        if ( HiberateUtils.isAccessible( customer, "orders" ) ) {
            customer.setOrders( mapOrders( customer.getOrders() ) );
        }
        // ...
    }

    // ...
}
{{< /prettify >}}

### Passing annotations to generate code

Using `@AnnotateWith` custom annotations can be passed to the generated code.

{{< prettify java >}}
@AnnotateWith( value = Component.class, elements = @AnnotateWith.Element( strings = "customerMapperV1" ) )
@Mapper( componentModel = MappingConstants.ComponentModel.SPRING )
public interface CustomerMapper {
    // ...
}
{{< /prettify >}}

This will generate:

{{< prettify java >}}
// GENERATED CODE
@Component("customerMapperV1")
public class CustomerMapperImpl implements CustomerMapper {
    // ...
}
{{< /prettify >}}

This for example can be used to provide a custom name for the Spring `@Component`

### Add Javadoc to generated code

Using `@Javadoc` it is possible to pass custom javadoc to the generated code.

e.g.

{{< prettify java >}}
@Mapper
@Javadoc("This is the description\n"
    + "\n"
    + "@author author1\n"
    + "@author author2\n"
    + "\n"
    + "@deprecated Use {@link CustomerV2Mapper} instead\n"
    + "@since 0.1\n")
@Deprecated
public interface CustomerMapper {
}
{{< /prettify >}}

or


{{< prettify java >}}
@Mapper
@Javadoc(
    value = "This is the description",
    authors = { "author1", "author2" },
    deprecated = "Use {@link CustomerV2Mapper} instead",
    since = "0.1"
)
@Deprecated
public interface CustomerMapper {
}
{{< /prettify >}}

In both cases the generated code looks like:

{{< prettify java >}}
/**
* This is the description
* 
* @author author1
* @author author2
* 
* @deprecated Use {@link CustomerV2Mapper} instead
* @since 0.1
*/
@Deprecated
// GENERATED CODE
public class CustomerMapperImpl implements CustomerMapper {
}
{{< /prettify >}}

### New Built-In conversions

We have extensive number of built-in conversions between different types.
As of this release we have 4 more:

* Between `Enum` and `Integer` - This basically uses `Enum#ordinal` to map to integer and `MyEnum.values()[value]` to map from an integer value  
* Between `Locale` and `String`
* Between `java.time.LocalDate` and `java.time.LocalDateTime`
* Between `Iterable` and `Collection`

### Enhancements

* New compiler options have been added for defining `nullValueIterableMappingStrategy` and `nullValueMapMappingStrategy` globally. The options are `mapstruct.nullValueIterableMappingStrategy` and `mapstruct.nullValueMapMappingStrategy` respectively.
* Subclass mappings now support qualifiers
* SPI implementations now have the possibility to provide custom compiler options.
  A new SPI (`AdditionalSupportedOptionsProvider`) needs to be implemented to provide the custom options.
  Custom compiler options are not allowed to start with `mapstruct`
* The most specific mapping will be picked when the return type can be assigned to a simpler type. e.g.
{{< prettify java >}}
  public static java.util.Date toUtilDate(String strDate);
  public static java.sql.TimeStamp toTimeStamp(String strDate);
  public static java.sql.Date toSqlDate(String strDate);
{{< /prettify >}}
  Previously mapping from a `String` to `java.util.Date` would fail since any of the 3 methods could be used. 
  However, now the `toUtilDate` would be picked
* Collection getter is not treated as a write accessor when using `CollectionMappingStrategy#TARGET_IMMUTABLE`
* Error location has been improved for `@SubclassMapping`
* Support `@InheritConfiguration` for `@SubclassMapping`
* Do not require `subclassExhaustiveStrategy` when source is a sealed class and all subtypes are specified
* All lifecycle methods are support for builders
  * `@BeforeMapping` with `@TargetType` the type being build
  * `@AfterMapping` with `@TargetType` the type being build
  * `@AfterMapping` with `@MappingTarget` the type being build
* Some redundant null checks have been removed for nested properties
* Support `@Default` for records
* Add `InjectionStrategy.SETTER`
* Add `BeanMapping#unmappedSourcePolicy`
* Improve support for `Map` attributes for Immutables

### Breaking Changes

Map to Bean
In 1.5 we added support for mapping a map to a bean by implicitly mapping all the properties from the target bean by accessing them from the map.
However, this lead to some problems in multi mapping methods.
Therefore, in this release we tightened up a bit and in multi source mapping methods the Map will not be considered when doing implicit mappings.

e.g.

{{< prettify java >}}
@Mapper
public interface CarMapper {

    // This method is going to implicitly map all the target properties from the map
    Target map(Map<String, Object> map);
    
    // This method is not going to use the map for implicit mappings.
    //  Only the name will be mapped from the map (since it has been defined like that
    @Mapping(target = "name", source = "map.name")
    Target map(Source source, Map<String, Object> map)

}
{{< /prettify >}}

### Download

This concludes our tour through MapStruct 1.6 Beta1.
If you'd like to try out the features described above, you can fetch the new release from Maven Central using the following GAV coordinates:

* Annotation JAR: [org.mapstruct:mapstruct:1.6.0.Beta1](http://search.maven.org/#artifactdetails|org.mapstruct|mapstruct|1.6.0.Beta1|jar) 
* Annotation processor JAR: [org.mapstruct:mapstruct-processor:1.6.0.Beta1](http://search.maven.org/#artifactdetails|org.mapstruct|mapstruct-processor|1.6.0.Beta1|jar)

Alternatively, you can get ZIP and TAR.GZ distribution bundles - containing all the JARs, documentation etc. - [from GitHub](https://github.com/mapstruct/mapstruct/releases/tag/1.6.0.Beta1).

If you run into any trouble or would like to report a bug, feature request or similar, use the following channels to get in touch:

* Get help in our [Gitter room](https://gitter.im/mapstruct/mapstruct-users), the [GitHub Discussion](https://github.com/mapstruct/mapstruct/discussions) or [StackOverflow](https://stackoverflow.com/questions/tagged/mapstruct)
* Report bugs and feature requests via the [issue tracker](https://github.com/mapstruct/mapstruct/issues)
* Follow [@GetMapStruct](https://twitter.com/GetMapStruct) on Twitter
