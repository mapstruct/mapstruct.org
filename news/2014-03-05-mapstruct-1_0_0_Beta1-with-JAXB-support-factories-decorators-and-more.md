---
title: MapStruct 1.0.0.Beta1 is out with JAXB support, custom factories, decorators and more
author: Gunnar Morling
layout: news
tags: [release, news]
---

The MapStruct team is very happy to announce the release of MapStruct 1.0.0.Beta1.

One core part of the new release is comprehensive support for mapping JAXB types with `JAXBElement` and `XmlGregorianCalendar` attributes. It's possible now to plug in custom factories for creating objects, which also supports the JAXB use case as we'll see in a minute. Further new features are the support for creating mappers from abstract classes (instead of interfaces) and decorators for customizing the behavior of mapping methods.

The JARs should be synched to Maven Central soon. The coordinates are:

* [org.mapstruct:mapstruct:1.0.0.Beta1](http://search.maven.org/#artifactdetails&#124;org.mapstruct&#124;mapstruct&#124;1.0.0.Beta1&#124;jar) for the annotation JAR and 
* [org.mapstruct:mapstruct-processor:1.0.0.Beta1](http://search.maven.org/#artifactdetails&#124;org.mapstruct&#124;mapstruct-processor&#124;1.0.0.Beta1&#124;jar) for the annotation processor.

Alternatively you can download a [distribution bundle](http://sourceforge.net/projects/mapstruct/files/1.0.0.Beta1/) which contains everything required.

Before diving into some of the new features, let me say a huge thank you to [Sjaak Derksen](https://github.com/sjaakd/) and [Andreas Gudian](https://github.com/agudian) who heavily contributed to this release. That's much appreciated! Also a big thanks to everyone else who opened feature requests or joined the discussion.

### JAXB support

When working with SOAP or REST based web services it's a common requirement to map between the internal model of the application an JAXB types used in the web service layer. MapStruct facilitates this use case by providing out-of-the-box support for the following type conversions:

* `java.util.Date` <> `XMLGregorianCalendar`
* `String` <> `XMLGregorianCalendar`, optionally applying a format pattern
* `JAXBElement<T>` <> `<T>`, e.g. `JAXBElement<Integer>` <> `<Integer>`

If you generate JAXB types from an XML schema using [xjc](https://jaxb.java.net/2.2.4/docs/xjc.html), you'll typically obtain one or more `ObjectFactory` classes with methods for instantiating `JAXBElement`s. You can plug in these factories via the `uses()` attribute of the `@Mapper` annotation:

<pre class="prettyprint linenums">
@Mapper(uses = ObjectFactory.class)
public interface OrderMapper {

    Order orderEntityToExternalOrder(OrderEntity orderEntity);
}
</pre>

Here, the generated implementation of the `orderEntityToExternalOrder()` will invoke the corresponding methods of the factory class when populating the attributes of the target object. When selecting a method, MapStruct will also take the `@XmlElementDecl` annotation and its `name` and `scope` attributes into account. That way it is ensured that the resulting `JAXBElement` attributes have the right QNAME.

### Custom object factories and generic mapping methods

It's now possible to plug in custom factories for the instantiation of objects. MapStruct considers any method with a return type but no parameters as factory method. If such a method is present for a given mapping target type, the value will be obtained by invoking that method instead of instantiating the target type via `new`.

Both, mapping and factory methods can optionally receive the expected target type through a specifically marked parameter. This allows for powerful generic mapping methods, e.g. for loading referenced entities when mapping from a DTO (data transfer object) model to an entity model. The following shows an example:

<pre class="prettyprint linenums">
public class OrderDto {

    private long customerId;
    // getters, setters...
}

public class OrderEntity {

    private CustomerEntity customer;
    // getters, setters...
}

// A manually implemented repository for loading entities
public class CustomerRepository {

    public &lt;T&gt; T loadById(long id, @TargetType Class&lt;T&gt; entityType) {
        // load entity by id...
    }
}

@Mapper(uses = CustomerRepository.class)
public interface OrderMapper {

    @Mapping(source = "customerId", target = "customer")
    OrderEntity orderDtoToOrderEntity(OrderDto orderDto);
}
</pre>

When generating an implementation of the `orderDtoToOrderEntity()` method, MapStruct will apply the hand-written `loadById()` method of the repository class to map the customer id in `OrderDto` to the corresponding customer entity referenced by the resulting order entity. By annotating a parameter with `@TargetType`, you advice MapStruct to pass the expected target type via that parameter. This type can then be used for instance to load the right entity via JPA/Hibernate.

### Customizing mapping logic using decorators

You can now utilize the [decorator pattern](https://en.wikipedia.org/wiki/Decorator_pattern) to customize generated mapping routines. A common use case is to set additional attributes in the target object of a mapping. E.g. let's assume you want to customize the behavior of the `personToPersonDto()` method of the following mapper:

<pre class="prettyprint linenums">
@Mapper
@DecoratedWith(PersonMapperDecorator.class)
public interface PersonMapper {

    PersonMapper INSTANCE = Mappers.getMapper( PersonMapper.class );

    PersonDto personToPersonDto(Person person);

    AddressDto addressToAddressDto(Address address);
}
</pre>

The decorator must be a sub-type of the mapper type must and needs to be registered using the `@DecoratedWith` annotation. It's often useful to declare it as an abstract class which allows to implement only those methods which you want to customize:

<pre class="prettyprint linenums">
public abstract class PersonMapperDecorator implements PersonMapper {

    private final PersonMapper delegate;

    public PersonMapperDecorator(PersonMapper delegate) {
        this.delegate = delegate;
    }

    @Override
    public PersonDto personToPersonDto(Person person) {
        PersonDto dto = delegate.personToPersonDto( person );
        dto.setFullName( person.getFirstName() + " " + person.getLastName() );
        return dto;
    }
}
</pre>

As shown in the example, you can optionally declare a constructor which receives a delegate with the generated mapper implementation. This delegate can be used in the decorator methods to invoke the default mapping routine and then amend the result object. All methods not implemented by the decorator class will just be routed through to the delegate.

Note that the delegate feature is experimental as of this release and may change in future versions. Also it's subject to some limitations for the time being, e.g. only a single decorator can be applied (a decorator chain will be possible in the future) and it is only supported for the default component model but not when using the CDI and Spring component models.

### What else is in it?

The Beta1 release comes with some more features which you may find helpful.

You can now generate mappers from abstract classes (instead of interfaces) which is useful if you want to provide some manually implemented mapping methods. MapStruct also can generate now mapping methods between different [enum types](/documentation/#section-07). The complete change log is available [here](https://github.com/mapstruct/mapstruct/issues?milestone=3&state=closed). Be sure to check out the [reference documentation](/documentation) to learn more about all the new functionality.

As always any feedback is highly welcome. Just add a comment below or join the [mapstruct-users](https://groups.google.com/forum/?fromgroups#!forum/mapstruct-users) group. Bugs and feature requests can be reported in the [issue tracker](https://github.com/mapstruct/mapstruct/issues) and your pull request on GitHub is always welcome. The [development guide](/contributing) has also been updated and provides all the info you need to get started with hacking on MapStruct.
