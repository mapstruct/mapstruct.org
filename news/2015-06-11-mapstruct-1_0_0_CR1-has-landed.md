---
title: "MapStruct 1.0.0.CR1 has landed"
author: Gunnar Morling
layout: news
tags: [release, news]
---

I am very happy to announce the first candidate release of MapStruct 1.0!

As we are approach MapStruct 1.0, this release is primarily focused on ironing out remaining glitches and fixing bugs. But there are also some new features:

* A new SPI for discovering property accessors not adhering to the JavaBeans convention
* The decorator feature can now also be used with Spring
* Support for before- and after-mapping lifecycle hooks

The complete list of 24 closed issues can be found in the [change log](https://github.com/mapstruct/mapstruct/issues?q=milestone%3A1.0.0.CR1).

A big thank you to everyone contributing to this release: [Sjaak Derksen](https://github.com/sjaakd/), [Andreas Gudian](https://github.com/agudian), [Christian Schuster](https://github.com/chschu), [Paul Strugnell](https://github.com/ps-powa) and [Remko Plantenga](https://github.com/sonata82)!

### Download

To fetch MapStruct 1.0.0.CR1 via Maven, Gradle or similar dependency management tools, use the following GAV coordinates:

* [org.mapstruct:mapstruct:1.0.0.CR1](http://search.maven.org/#artifactdetails|org.mapstruct|mapstruct|1.0.0.CR1|jar) for the annotation JAR (to be used with Java <= 7) or [org.mapstruct:mapstruct-jdk8:1.0.0.CR1](http://search.maven.org/#artifactdetails|org.mapstruct|mapstruct-jdk8|1.0.0.CR1|jar) (for usage with Java >= 8)
* [org.mapstruct:mapstruct-processor:1.0.0.CR1](http://search.maven.org/#artifactdetails|org.mapstruct|mapstruct-processor|1.0.0.CR1|jar) for the annotation processor.

Alternatively, you can download distribution bundles (ZIP, TAR.GZ) from [SourceForge](http://sourceforge.net/projects/mapstruct/files/1.0.0.CR1/).

### SPI for property accessor discovery

By default, MapStruct expects property getters and setters adhering to the [JavaBeans specification](http://www.oracle.com/technetwork/java/javase/documentation/spec-136004.html).

In some cases though models to be mapped derive from this convention. E.g. builder objects could expose property write accessors such as `withName()` (instead of `setName()`). O domain models could expose property read accessors just in the form of `name()` (instead of `getName()`).

To make MapStruct work with such models, there is now an SPI (service provider interface) which makes the discovery of property accessors customizable. This SPI comes in the form of the following contract:

<pre class="prettyprint linenums">
public interface AccessorNamingStrategy {

    /* MethodType may be GETTER, SETTER, ADDER or OTHER */
    MethodType getMethodType(ExecutableElement method);

    String getPropertyName(ExecutableElement getterOrSetterMethod);

    String getElementName(ExecutableElement adderMethod);

    String getCollectionGetterName(String property);
}
</pre>

The MapStruct engine will pass all candidate methods of mapping source and target types to this SPI in order to detect their property accessors. Once you have created an implementation of the contract based on your project's specific property naming conventions ([an example](https://github.com/mapstruct/mapstruct/blob/master/integrationtest/src/test/resources/namingStrategyTest/strategy/src/main/java/org/mapstruct/itest/naming/CustomAccessorNamingStrategy.java) can be found in our test suite), it needs to be registered through the Java [service loader](http://docs.oracle.com/javase/8/docs/api/index.html?java/util/ServiceLoader.html) mechanism. To do so, create the file _META-INF/services/org.mapstruct.ap.spi.AccessorNamingStrategy_ with the fully-qualified name of your implementation as contents:

<pre class="prettyprint linenums">
com.example.CustomAccessorNamingStrategy
</pre>

Note that in order to have MapStruct find your custom strategy, it must be added as dependency either to the project class path or to the factory path of the compilation.

### Improved decorator support

[Mapper decorators](/documentation/#section-decorators) have been supported for the default component model since Beta1. As of CR1, they can be used now with the Spring component model, too (CDI has its own notion of decorators which can be used just as is with MapStruct mappers). To enable a decorator, add it via `@DecoratedWith`:

<pre class="prettyprint linenums">
@Mapper(componentModel = "spring")
@DecoratedWith( OrderMappingDecorator.class )
public interface OrderMapper {

    OrderDto orderToDto(Order order);
}
</pre>

The decorator is simply another Spring bean which implements the decorated type. It can have the generated mapper implementation injected using the "delegate" qualifier:

<pre class="prettyprint linenums">
@Component
@Primary
public class OrderMappingDecorator implements OrderMapper {

    @Autowired
    @Qualifier( "delegate" )
    private OrderMapper delegate;

    public OrderMappingDecorator() {
    }

    @Override
    public OrderDto orderToDto(Order order) {
        OrderDto dto = delegate.orderToDto( order );

        // apply some additional custom mapping routine...

        return dto;
    }
}
</pre>

By adding the `@Primary` annotation to the decorator it is ensured that the decorated mapper can be obtained through dependency injection without the need for further qualification at injection points.

### Before and after mapping callbacks

Somewhat related to decorators is the new feature of before and after mapping [callback methods](/documentation#section-before-after). They are useful to implement generic before and after mapping logic for a wider range of source and target types. Whereas decorators are bound to a specific mapper contract, before and after mapping callbacks are bound to arbitrary source and target types.

The following gives an example:

<pre class="prettyprint linenums">
@Mapper
public abstract class VehicleMapper {

    @BeforeMapping
    protected void flushEntity(AbstractVehicle vehicle) {
        // e.g. call EntityManager flush() to make sure the entity
        // is populated with the right @Version before mapping it into the DTO
    }

    @AfterMapping
    protected void fillTank(AbstractVehicle vehicle, @MappingTarget AbstractVehicleDto result) {
        result.fuelUp( new Fuel( vehicle.getTankCapacity(), vehicle.getFuelType() ) );
    }

    public abstract CarDto toCarDto(Car car);
}
</pre>

All generated implementations of mapping methods with `AbstractVehicle` or a sub-type as source-type (such as `toCarDto()`) will invoke the method annotated with `@BeforeMapping` at the beginning. Similarly, all methods mapping `AbstractVehicle` or a sub-type into `AbstractVehicleDto` or a sub-type will invoke the method annotated with `@AfterMapping` at the end.

Before and after mapping callback methods are a quite powerful mechanism to implement cross-cutting concerns common to a larger group of mapping methods. Refer to the JavaDocs of `@BeforeMapping` and `@AfterMapping` to learn more, e.g. about ordering of several lifecycle methods etc. Note that before and after mapping callback methods are considered and experimental features as of MapStruct 1.0. Based on feedback from using this feature in practice we may fine-tune semantics in a subsequent release.

### What's next?

With CR 1 out, MapStruct 1.0 Final is getting in sight! Based on the number of bugs reported against CR1, we may either do another CR in two or three weeks or go straight to the Final. In parallel work on the MapStruct [Eclipse plug-in](https://github.com/mapstruct/mapstruct-eclipse) continues. We plan to do a first Alpha release of that very soon. Stay tuned!

Finally, some useful links:

* Get help at the [mapstruct-users](https://groups.google.com/forum/?fromgroups#!forum/mapstruct-users) group
* Report bugs and feature requests via the [issue tracker](https://github.com/mapstruct/mapstruct/issues)
* Follow [@GetMapStruct](https://twitter.com/GetMapStruct) on Twitter
* Follow MapStruct on [Google+](https://plus.google.com/u/0/118070742567787866481/posts)
