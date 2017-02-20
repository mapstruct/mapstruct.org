---
title: "Support for Lombok, direct field access and much more: MapStruct 1.2.0.Beta1 is out"
author: Gunnar Morling
date: "2017-02-20"
tags: [release, news]
---

It' my pleasure to announce the first Beta release of MapStruct 1.2.

The new release comes with a whole lot of new functionality, e.g.:

* MapStruct can now be used together with Project Lombok
* Support for Java 8 streams
* Mappings based on public fields (i.e. you can write DTOs without getters and setters)
* Automatic creation of sub-mapping methods
* Mapping methods can take "pass-through" context parameters, addressing different use cases like
 * Passing a locale, timezone or similar to custom mapping methods
 * Keeping track of processed nodes in circular object graphs
* Target bean factory methods can access a mapping's source parameter(s)

<!--more-->

Altogether, not less than [44 issues](https://github.com/mapstruct/mapstruct/issues?q=milestone%3A1.2.0.Beta1) were fixed for this release.

This would not have been possible without our fantastic community of contributors:
[Dmytro Polovinkin](https://github.com/navpil), [Maxim Kolesnikov](https://github.com/xCASx), [Pascal Grün](https://github.com/pascalgn), [Remo Meier](https://github.com/remmeier), as well as seasoned MapStruct hackers [Andreas Gudian](https://github.com/agudian), [Filip Hrisafov](https://github.com/filiphr) and [Sjaak Derksen](https://github.com/sjaakd).
Thanks a lot everyone for all your hard work!

Enough of the pep talk, let's take a closer look at some of the new features!

### Using MapStruct together with Project Lombok

Being able to use MapStruct together with [Project Lombok](https://projectlombok.org/) within a single compilation unit has been a long-awaited and [intensely debated](https://github.com/mapstruct/mapstruct/issues/510) feature request.

The challenge here was that Lombok actually _alters_ the AST of the compiled classes (something which has never been foreseen by the [annotation processing](https://www.jcp.org/en/jsr/detail?id=269) infrastructure).
Other annotation processors such as MapStruct then wouldn't know about the elements added by Lombok (e.g. getters and setters for the `@Data` annotation).

To cut a long story short, thanks to a very productive collaboration with the Lombok team this could be resolved.
MapStruct will now wait until Lombok has done all its amendments before generating mapper classes for Lombok-enhanced beans.

You can find a small example project for using MapStruct together with Lombok [here](https://github.com/mapstruct/mapstruct-examples/tree/master/mapstruct-lombok).
Note that Lombok 1.16.14 or newer is required.

### Java 8 stream support

Java 8's `Stream` type can [be used](https://github.com/mapstruct/mapstruct/issues/962) now as source and target of mapping methods:

{{< prettify java >}}
@Mapper
public interface OrderMapper {

    Set<OrderDto> ordersToOrderDtos(Stream<Order> orders);

    OrderDto orderToOrderDto(Order order);
}
{{< /prettify >}}

If the "element type" differs between source and target stream/collection (`Order` vs. `OrderDto`),
`Stream#map()` will be used to call the right element mapping method (`orderToOrderDto()`) in the generated code.

### Mappings using direct field access

Traditionally MapStruct relied on the JavaBeans convention and called getter and setter methods for propagating property values from source to target.
Sometimes writing all the getters and setters may be a bit cumbersome, though, e.g. when it comes to "dumb" DTOs which should just hold a couple of property values.

Using public fields is perfectly fine in such case, which is why direct field access is [supported by MapStruct now](https://github.com/mapstruct/mapstruct/issues/557).
I.e. if your source or target beans do not define getters or setters for the properties but declare public fields,
the generated code will directly access the fields.
Note that no reflection will be used, i.e. we won't make private fields accessible.

You can find a small example demonstrating field-based mapping [here](https://github.com/mapstruct/mapstruct-examples/tree/master/mapstruct-field-mapping/).

### Automatic creation of sub-mapping methods

MapStruct 1.2 will automatically create methods for nested mappings if possible.
E.g. consider the following entities and corresponding DTOs:

{{< prettify java >}}
public class Order {
    public Customer customer;
}

public class Customer {
    public String custName;
}
{{< /prettify >}}

{{< prettify java >}}
public class OrderDto {
    public CustomerDto customer;
}

public class CustomerDto {
    public String name;
}
{{< /prettify >}}

In MapStruct 1.1 you were required to provide two dedicated mapping methods, one for orders and one for customers:

{{< prettify java >}}
@Mapper
public class OrderMapper {

    OrderDto orderToDto(Order order);

    @Mapping(target = "name", source = "custName")
    CustomerDto customerToDto(Customer customer);
}
{{< /prettify >}}

If you have object graphs on source and target side that are structurally equal (i.e. for each object on the source side there is a corresponding object on the target side) but only differ in property names or (non-bean) property types,
having to define mapping methods for all the source-target object pairs can be quite a bit of work.

MapStruct 1.2 can therefore automatically create nested mapping methods:

{{< prettify java >}}
@Mapper
public class OrderMapper {

    @Mapping(target = "customer.name", source = "customer.custName")
    OrderDto orderToDto(Order order);
}
{{< /prettify >}}

When detecting that there is no explicit method for mapping `Customer` to `CustomerDto`,
MapStruct will generate such method, applying the `@Mapping` configuration given on the `orderToDto()` method.

This feature can save you quite some work if you are mapping large graphs.
The implementation may still have some rough edges, so please give it a try and let us know if you see unexpected mapping code being generated.

A more complex example for the auto-mapping feature can be found [here](https://github.com/mapstruct/mapstruct-examples/tree/master/mapstruct-nested-bean-mappings).

### "Pass-through" context parameters

Sometimes there is the need to pass some specific contextual information through generated mapping methods down to hand-written methods.
That is supported using the new `@Context` annotation now.
An example for this is passing the locale or timezone of the current user:

{{< prettify java >}}
@Mapper
public abstract class OrderMapper {

    public abstract CarDto carToCarDto(Car car, @Context Locale userLocale);

    protected OwnerManualDto translateOwnerManual(OwnerManual ownerManual, @Context Locale locale) {
        // manually implemented logic to translate the OwnerManual with the given Locale
    }
}
{{< /prettify >}}

What you use as context type is fully transparent to MapStruct,
any parameters annotated with `@Context` will essentially be ignored apart from being passed along the call stack of mapping methods.

Context parameters can also be used with mapping lifecycle methods (`@BeforeMapping`/`@AfterMapping`),
which is super-useful for mapping object graphs that contain cycles.
Check out [this project](https://github.com/mapstruct/mapstruct-examples/tree/master/mapstruct-mapping-with-cycles) in the MapStruct examples repository
which shows how to keep track of nodes that already have been mapped and re-use their mapped counterparts when visiting them another time in a cyclic tree.

### More powerful target bean factories

Factory methods for instantiating the target type of bean mapping methods got much more powerful as they can receive the source parameter(s) of the mapping method now.
This can be used for instance to load an entity through JPA from the database when mapping DTOs back to entities:

{{< prettify java >}}
@Mapper(uses=ReferenceMapper.class, componentModel="cdi")
public interface CarMapper {
      Car carDtoToCar(CarDto car);
}

@ApplicationScoped
public class ReferenceMapper {

    @PersistenceContext
    private EntityManager em;

    @ObjectFactory
    public <T extends AbstractEntity> T resolve(AbstractDto sourceDto, @TargetType Class<T> type) {
        T entity = em.find( type, sourceDto.getId() );
        return entity != null ? entity : type.newInstance();
    }
}
{{< /prettify >}}

Factory methods which should receive the mapping source parameters must be annotated with `@ObjectFactory` so MapStruct can distinguish them from regular mapping methods.

### Download

This concludes our tour through MapStruct 1.2 Beta1.
If you'd like to try out the features described above, you can fetch the new release from Maven Central using the following GAV coordinates:

* Annotation JAR: [org.mapstruct:mapstruct-jdk8:1.2.0.Beta1](http://search.maven.org/#artifactdetails|org.mapstruct|mapstruct-jdk8|1.2.0.Beta1|jar) (for usage with Java >= 8) or [org.mapstruct:mapstruct:1.2.0.Beta1](http://search.maven.org/#artifactdetails|org.mapstruct|mapstruct|1.2.0.Beta1|jar) (for earlier Java versions)
* Annotation processor JAR: [org.mapstruct:mapstruct-processor:1.2.0.Beta1](http://search.maven.org/#artifactdetails|org.mapstruct|mapstruct-processor|1.2.0.Beta1|jar)

For those not using a dependency management tool such as Maven or Gradle, we also provide distribution bundles (ZIP, TAR.GZ) on [SourceForge](http://sourceforge.net/projects/mapstruct/files/1.2.0.Beta1/).

If you run into any trouble or would like to report a bug, feature request or similar, use the following channels to get in touch:

* Get help at the [mapstruct-users](https://groups.google.com/forum/?fromgroups#!forum/mapstruct-users) group or in our [Gitter room](https://gitter.im/mapstruct/mapstruct-users)
* Report bugs and feature requests via the [issue tracker](https://github.com/mapstruct/mapstruct/issues)
* Follow [@GetMapStruct](https://twitter.com/GetMapStruct) on Twitter
* Follow MapStruct on [Google+](https://plus.google.com/u/0/118070742567787866481/posts)
