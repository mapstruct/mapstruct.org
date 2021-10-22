+++
date = "2016-12-31T13:23:04+01:00"
draft = false
title = "Frequently Asked Questions (FAQ)"
linkTitle = "FAQ"
weight = 500
[menu]
[menu.main]
+++

{{% faq_question "How is MapStruct different from other bean mapping tools?" %}}

Unlike most other bean mapping tools, MapStruct doesn't work at runtime but is a compile-time code generator.

Generating mapping code at build time has many advantages:

* Early feedback about erroneous or incomplete mappings, in command line builds as well as within your IDE
* Excellent performance, as no reflection or byte code generation at runtime is needed;
the generated code contains plain method invocations, just as if the mapper was hand-written
* No runtime dependencies, making MapStruct a great solution for Android applications
* The generated code is easy to understand (and debug, if ever needed)
* The optional [Eclipse plug-in]({{< ref "ide-support.md#eclipse" >}}) assists you when writing mappings, e.g. by auto-completion

{{% /faq_question %}}

{{% faq_question "Can I use MapStruct within Eclipse?" %}}
Yes.

Check out the [set-up instructions]({{< ref "ide-support.md#eclipse" >}}) for Eclipse.
There is also a work-in-progress [Eclipse plug-in](https://marketplace.eclipse.org/content/mapstruct-eclipse-plugin#group-metrics-tab)
which facilitates the definition of mapper interfaces with auto-completion and some quick fixes.
{{% /faq_question %}}

{{% faq_question "Can I use MapStruct together with Project Lombok?" %}}
Yes, as of MapStruct 1.2.0.Beta1 and Lombok 1.16.14.

[Project Lombok](https://projectlombok.org/) is an annotation processor that (amongst other things) adds getters and setters to the AST (abstract syntax tree) of compiled bean classes.
AST modifications are not foreseen by Java annotation processing API,
so quite some trickery was required within Lombok as well MapStruct to make both of them work together.
Essentially, MapStruct will wait until Lombok has done all its amendments before generating mapper classes for Lombok-enhanced beans.

An example for using the two projects together can be found [here](https://github.com/mapstruct/mapstruct-examples/tree/master/mapstruct-lombok).

If you are using Lombok 1.18.16 or newer you also need to add [lombok-mapstruct-binding](https://search.maven.org/artifact/org.projectlombok/lombok-mapstruct-binding) in order to make Lombok and MapStruct work together.

If you are on an older version of MapStruct or Lombok,
the solution is to put the JavaBeans to be amended by Lombok and the mapper interfaces
to be processed by MapStruct into two separate modules of your project.
Then Lombok will run in the compilation of the first module,
causing the bean classes to be complete when MapStruct runs during the compilation of the second module.
{{% /faq_question %}}

{{% faq_question "Why does @Named not work?" %}}
Check out that you are actually using [`org.mapstruct.Named`](http://mapstruct.org/documentation/stable/api/org/mapstruct/Named.html)
and  **not** `javax.inject.Named`.
{{% /faq_question %}}

{{% faq_question "Why do I get this error: Could not retrieve @Mapper annotation during compilation?" %}}
This can happen if you are using [`mapstruct-jdk8`](http://mvnrepository.com/artifact/org.mapstruct/mapstruct-jdk8) and
some other dependency is using an older version of [`mapstruct`](http://mvnrepository.com/artifact/org.mapstruct/mapstruct).
To solve the problem find the dependency that is using `mapstruct` and exclude it.

A known dependency that uses `mapstruct` and has this problem is [`springfox-swagger2`](http://mvnrepository.com/artifact/io.springfox/springfox-swagger2).

For Maven you need to exclude it like:

{{< prettify xml >}}
<dependency>
    <groupId>io.springfox</groupId>
    <artifactId>springfox-swagger2</artifactId>
    <version>${swagger2.version}</version>
    <exclusions>
        <exclusion>
            <groupId>org.mapstruct</groupId>
            <artifactId>mapstruct</artifactId>
        </exclusion>
    </exclusions>
</dependency>
{{< /prettify >}}

For Gradle you need to exclude it like:

{{< prettify groovy >}}
compile('io.springfox:springfox-swagger2:${swagger2.version}') {
    exclude group: 'org.mapstruct', module: 'mapstruct'
}
{{< /prettify >}}

{{% /faq_question %}}

{{% faq_question "Why is it not possible for MapStruct to generate implementations for Iterable, Stream and Map Types from update (`@MappingTarget`) methods?" %}}

Consider this (when thinking what MapStruct should do for updating collections in general):

* What if there's no match: should the non-matching elements be removed?
* Should the non matching source elements be added?
* What exactly constitutes to a match: equals? hashcode? comparator==0?
* Can there be more than one match (Lists, but also depending on what is considered a match.)
* How should the resulting collection be sorted?
* Should a newly created object be added to a persistence context?
* What about JPA child-parent relations?

About the latter one, many IDEs also generates remove methods. So should MapStruct call these in the light of the above?

At this moment it works like this: whenever the user wants a collection update method, MapStruct generates a regular call to element mappings (in stead of an update call), because it is the only sensible thing to do. All the remainder is highly dependent on the use-case. 

{{% /faq_question %}}

{{% faq_question "How do I handle null properties in the source bean?" %}}

The strategies were developed over time and hence the naming / behavior deserves attention in future versions of MapStruct to getter better allignment. This would introduce backward incompatibillties, so we cannot not do this in the 1.x versions of MapStruct. 

The following table expresses when the current strategies apply:

{{% faq_table %}}
|                                  	| source property | source bean 	| direct mapping 	| update mapping (`@MappingTarget`)|
|----------------------------------	|:---------------:|:---------------:|:---------------:	|:---------------:	                |
| NullValueCheckStrategy           	|        x        |             	|        x       	|                x                	|
| NullValuePropertyMappingStrategy 	|        x        |             	|                	|                x                	|
| `@Mapping#defaultValue`          	|        x        |             	|        x       	|                x                	|
| NullValueMappingStrategy         	|                 |      x      	|        x       	|                x                	|
{{% /faq_table %}}

We've noticed a common mistake that `NullValuePropertyMappingStrategy` is used in relation to direct mapping, which is understandble because of its naming. So lets look at the following example:

{{< prettify java >}}
@Mapper
public interface MyMapper {

    Bar map( Foo source );    
}

public class Foo {

    private String string;
    // setters/getters
}

public class Bar {

    private String string;
    // setters/getters
}
{{< /prettify >}}
generates:

{{< prettify java >}}
public class MyMapperImpl implements MyMapper {

    @Override
    public Bar map(Foo source) {
        if ( source == null ) {
            return null;
        }

        Bar bar = new Bar();

        bar.setString( source.getString() );

        return bar;
    }
}
{{< /prettify >}}

So, lets look what it would mean if `NullValuePropertyMappingStrategy` could be applied to direct mappings: 

* `SET_TO_NULL`. What does this mean when the `source.string` is null? It would set the source to null when null. But that is what it already does above without any strategy.

* `IGNORE`. When `source.string` is null, it would ignore setting the target. But that can be achieved with `NullValueCheckStrategy.ALWAYS`. Look at the example below:

{{< prettify java >}}
@Mapper( nullValueCheckStrategy = NullValueCheckStrategy.ALWAYS )
public interface MyMapper {

    Bar map( Foo source );
}
{{< /prettify >}}

generates:

{{< prettify java >}}
public class MyMapperImpl implements MyMapper {

    @Override
    public Bar map(Foo source) {
        if ( source == null ) {
            return null;
        }

        Bar bar = new Bar();

        if ( source.getString() != null ) {
            bar.setString( source.getString() );
        }

        return bar;
    }
}
{{< /prettify >}}

* `SET_TO_DEFAULT`. `SET_TO_DEFAULT` is not covered by other cases in direct mapping, but can be achieved as well. Lets asume we would like to set an empty String as default value on null source. There are 2 possibilities:
 
{{< prettify java >}}
@Mapper
public interface MyMapper {

    @Mapping( target = "string", defaultValue = "" )
    Bar map( Foo source );
}
{{< /prettify >}}

generates:

{{< prettify java >}}
public class MyMapperImpl implements MyMapper {

    @Override
    public Bar map(Foo source) {
        if ( source == null ) {
            return null;
        }

        Bar bar = new Bar();

        if ( source.getString() != null ) {
            bar.setString( source.getString() );
        }
        else {
            bar.setString( "" );
        }

        return bar;
    }
}
{{< /prettify >}}

but has the drawback that this needs to be done for each property. 

The other option would be to create the target object with a default property value, either inside the target (Bar) during construction -if you have control over the target beans-, or via an object factory method:

{{< prettify java >}}
@Mapper( nullValueCheckStrategy = NullValueCheckStrategy.ALWAYS)
public interface MyMapper {

    Bar map( Foo source );

    @ObjectFactory
    default Bar create() {
        Bar bar = new Bar();
        bar.setString( "" );
        return bar;
    }
}
{{< /prettify >}}

Finally overview below shows on what level a strategy can be applied:

{{% faq_table %}}
|                                  	| @MapperConfig 	| @Mapper 	| @BeanMapping 	| @Mapping 	|
|----------------------------------	|:------------:	|:------------:	|:------------:	|:------------:	|
| NullValueCheckStrategy           	|       x       	|    x    	|       x      	|     x    	|
| NullValuePropertyMappingStrategy 	|       x       	|    x    	|       x      	|     x    	|
| @Mapping#defaultValue            	|               	|         	|              	|     x    	|
| NullValueMappingStrategy         	|       x       	|    x    	|       x      	|          	|
{{% /faq_table %}}

More detailed information can be found in the reference guide.

{{% /faq_question %}}

{{% faq_question "How to solve ambiguous methods" "ambiguous" %}}

MapStruct tries various mechanisms to map a sourceproperty to a targetproperty when it cannot make a direct mapping. In order, MapStruct tries:

1. other mapping methods (inside the mapper, or via the uses relation). This concerns both hand-written methods and MapStruct generated methods
2. direct mapping (source type is directly assignable to target type)
3. type conversions (e.g. from int to String)
4. BuiltIn methods (see documentation on a list of supported methods)
5. 2 step method, variant 1: `target = methodY( methodX ( source ) )`
6. 2 step method, variant 2: `target = methodY( conversionX ( source ) )`
7. 2 step method, variant 3: `target = conversionY( methodX ( source ) )`

Whenever MapStruct finds a unique candidate, MapStruct stops and uses this method to make the mapping between source and target. However, for option 1, 5, 6, 7 it is possible that multiple eligible candidtates are found for which MapStruct cannot decide which one to select. MapStruct reports this as "ambiguous mapping method" and lists the methods from which it cannot make a selection. Here, you have to guide MapStruct in making the correct mapping.

This can be done in the following ways:
* provide a method with the exact signature if MapStruct cannot select between base- and super types.
* provide qualifiers.

{{% /faq_question %}}

{{% faq_question "Problems with qualifiers" "qualifier" %}}
MapStruct uses the mechanism of Qualifiers to resolve conflicts. MapStruct selects methods based on the combination of source type and target type.

An error labeled: "Qualifier error" is MapStructs way of letting you know that it cannot find the method you intended to annotate with a qualifier annotation or with `@Named`. There can be several reasons for this:

* you forgot to add the proper retention policy. It must be `@Retention(RetentionPolicy.CLASS)`
* you forgot to add the qualifier (your own annotation, or `@Named`) to the designated method
* the method signature to which you added the qualfier does not match the source type and target type required for the mapping
* in 1.3.x and earlier, MapStruct was more lenient and allowed qualifiers also if MapStruct did not actually use them. That has been fixed in 1.4.x, on order to get consistent behaviour
* if you wanted to use a 2 step mapping (so selecting two mapping methods) to get from source to target, you need to add the qualifier to both designated methods.


{{% /faq_question %}}

{{% faq_question "How to avoid MapStruct selecting a method?" %}}

MapStruct selects methods by means of assignabillity of source - and target type:

* source assignable to the source parameter of a method
* target assignable to the return type or the `@MappingTarget` annotated target parameter of a method.
* Qualifying methods are in `@Mapper#used` mappers or in the `Mapper` class/interface itself. 

Problems arise when more than one method meets the qualifications.

In general, qualifiers are used to guide MapStruct to the proper choice. Usualy by indicating `@Mapping#qualifiedBy` or `@Mapping#qualifiedByName`. Lesser known is that Qualifiers also work the other way around: if a method is annotated with a qualfier that does not match the `@Mapping#qualifiedBy` MapStruct will not select that method. This is also valid when `@Mapping#qualifiedBy` is absent alltogether

Consider specifying a qualifier like this:

{{< prettify java >}}
@Qualifier // make sure that this is the MapStruct qualifier annotation
@Target(ElementType.METHOD)
@Retention(RetentionPolicy.CLASS)
public @interface DoIgnore {
}
{{< /prettify >}}

and placing it on a method:

{{< prettify java >}}
@DoIgnore
TypeX doSomething(TypeY y) {
    // -- do something
}
{{< /prettify >}}

the method `doSomething` will be ignored by MapStruct.

{{% /faq_question %}}

