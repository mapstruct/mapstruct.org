---
title: "JSpecify nullness support, configurable mapper accessibility, and much more: MapStruct 1.7.0.Beta2 is out"
author: Filip Hrisafov
date: "2026-07-27"
tags: [release, news]
---

It's my pleasure to announce the second Beta release of MapStruct 1.7.

The new release comes with some new functionality and many quality of life improvements to the generated code, e.g.:

* JSpecify nullness annotation support
* Configurable accessibility for the generated mapper class
* Built-in conversion between `URI` and `String`
* Modernized generated code (switch expressions for value mappings, diamond operator, multi-catch)

<!--more-->

Altogether, not less than [45 issues](https://github.com/mapstruct/mapstruct/issues?q=milestone%3A1.7.0.Beta2) were fixed for this release.

This would not have been possible without our fantastic community of contributors:

* [@bydrim](https://github.com/bydrim)
* [@Chessray](https://github.com/Chessray)
* [@hduelme](https://github.com/hduelme)
* [@jmwbRyDWLeNsvtzrihGoY](https://github.com/jmwbRyDWLeNsvtzrihGoY)
* [@mk868](https://github.com/mk868)
* [@nealeu](https://github.com/nealeu)
* [@seonwooj0810](https://github.com/seonwooj0810)
* [@Takch02](https://github.com/Takch02)
* [@yvasyliev](https://github.com/yvasyliev)

A very special welcome to [@hduelme](https://github.com/hduelme), who joined us as a regular contributor in this release cycle and is behind a large portion of the improvements that ship with 1.7.0.Beta2. Thank you for the dedication and the steady stream of high-quality contributions!

Thank you everyone for all your hard work!

We are also accepting donations through [Open Collective](https://opencollective.com/mapstruct) or [GitHub](https://github.com/sponsors/mapstruct).
We'd like to thank all the supporters that supported us with donations in this period:

* [adesso SE](https://github.com/adessoSE)
* [Cybozu](https://github.com/cybozu)
* [@foal](https://github.com/foal)
* [Frederik Hahne](https://opencollective.com/atomfrede)
* [Lansana](https://opencollective.com/lansana)
* [Mercedes-Benz Group](https://github.com/mercedes-benz)
* [Miikka Ylätalo](https://github.com/TotallyMehis)
* [Neale U](https://opencollective.com/neale-u)
* [@pmkyl](https://github.com/pmkyl)
* [Solum Financial](https://opencollective.com/solum-financial)
* [VEMA eG](https://github.com/vemaeg)
* [znight1020](https://github.com/znight1020)


Enough of the pep talk, let's take a closer look at some of the new features and enhancements!

### JSpecify nullness annotation support

MapStruct now understands [JSpecify](https://jspecify.dev/) nullness annotations and uses them to decide whether to emit null checks in the generated code.

The annotations `@NonNull`, `@Nullable`, `@NullMarked` and `@NullUnmarked` from `org.jspecify.annotations` are detected automatically.

#### Property-level null checks

* A `@NonNull` source value is treated as guaranteed non-null, so the null check is skipped.
* A `@NonNull` target always gets a null check, to protect it from a null assignment.
* In all other cases MapStruct falls back to the existing `NullValueCheckStrategy`.

The same rules apply to collection-typed properties, so a `@NonNull List<String>` source no longer triggers a redundant null check around the wrapper.

Safety guards like `defaultValue`, unboxing checks and `NullValuePropertyMappingStrategy` are still applied.

#### Method-level source parameter and return type

If the source parameter of a mapping method is `@NonNull`, MapStruct skips the method-level null guard at the beginning of the generated method.

The same is true for container mapping methods (`Iterable` → `Iterable`, `Map` → `Map`, `Stream` → `Stream`), which now honor JSpecify on their source parameter rather than always emitting an `if ( source == null ) return null;` guard.

When a mapping method's return type is `@NonNull`, MapStruct will no longer emit `return null;` (which would violate the return contract), and instead applies `NullValueMappingStrategy.RETURN_DEFAULT` semantics. This applies consistently across bean, iterable, map and stream mapping methods.

e.g.

{{< prettify java >}}
@NullMarked
@Mapper
public interface CustomerMapper {

    CustomerDto map(Customer customer);
}
{{< /prettify >}}

Will generate something like:

{{< prettify java >}}
// GENERATED CODE
public class CustomerMapperImpl implements CustomerMapper {

    @Override
    public CustomerDto map(Customer customer) {
        CustomerDto customerDto = new CustomerDto();
        // ...
        return customerDto;
    }
}
{{< /prettify >}}

Note that there is no `if ( customer == null )` guard, because `customer` is effectively `@NonNull` within the `@NullMarked` scope, and the method does not return `null` because the return type is also effectively `@NonNull`.

#### `@NullMarked` / `@NullUnmarked` scope

* Inside a `@NullMarked` class or package, unannotated reference types are effectively `@NonNull`.
* `@NullUnmarked` reverts to unknown nullability within its scope.
* `@Nullable` on a specific type always overrides the surrounding scope.
* The scope is resolved by walking the enclosing element chain (method → class → outer class → package → module).

#### Constructor parameters

When a potentially nullable source is mapped to a `@NonNull` constructor parameter, and there is no `defaultValue`, MapStruct now raises a compile error.
A null check at that point would leave the variable at `null`, which would violate the contract of the constructor.

#### Opting out

If you want to keep the pre-1.7.0.Beta2 behavior, you can disable JSpecify inference with the processor option `mapstruct.disableJSpecify=true`.
When set, all JSpecify-driven decisions (property-level inference, method-level guard skipping, scope resolution and the constructor-parameter error) are suppressed and code generation falls back to the `NullValueCheckStrategy`-driven behavior.

For more details have a look at the [JSpecify nullness annotations](https://mapstruct.org/documentation/dev/reference/html/#jspecify-nullness-annotations) section of the reference guide.

### Configurable accessibility for the generated mapper class

By default, the generated mapper implementation has the same accessibility (`public` or package-private) as the interface or abstract class carrying the `@Mapper` annotation.
In some cases — typically when relying on a DI framework like Spring — you may want the generated implementation to be package-private, even when the mapper interface itself is `public`.

A new `accessibility` attribute on `@Mapper` and `@MapperConfig` (along with a new `ClassAccessibility` enum) gives you control over this:

{{< prettify java >}}
@Mapper(componentModel = MappingConstants.ComponentModel.SPRING,
        accessibility = ClassAccessibility.PACKAGE_PRIVATE)
public interface CarMapper {

    CarDto carToCarDto(Car car);
}
{{< /prettify >}}

Possible values are:

* `ClassAccessibility.DEFAULT` - mirror the accessibility of the annotated interface or class (the existing behavior).
* `ClassAccessibility.PUBLIC` - the generated mapper is `public`.
* `ClassAccessibility.PACKAGE_PRIVATE` - the generated mapper has no visibility modifier.

For more details have a look at the [Class accessibility](https://mapstruct.org/documentation/dev/reference/html/#class-accessibility) section of the reference guide.

### Switch expressions for value mappings

Value mapping methods (such as enum-to-enum or `String`-to-enum mappings) now generate a Java 14 switch expression instead of the classic `switch` statement, when the target compiler level is JDK 14 or later.

Instead of generating:

{{< prettify java >}}
switch ( b ) {
    case "A": a = ValueMapper.A.A;
    break;
    case "B": a = ValueMapper.A.B;
    break;
    default: throw new IllegalArgumentException( "Unexpected enum constant: " + b );
}
{{< /prettify >}}

MapStruct will now generate:

{{< prettify java >}}
ValueMapper.A a = switch ( b ) {
    case "A" -> ValueMapper.A.A;
    case "B" -> ValueMapper.A.B;
    default -> throw new IllegalArgumentException( "Unexpected enum constant: " + b );
};
{{< /prettify >}}

When the switch has only a `default` branch, MapStruct will skip the switch altogether and assign the default target directly.

### Enhancements

* Add a built-in conversion between `java.net.URI` and `String`, similar to the existing conversions for `UUID` and `URL`.
* Add built-in conversions between `ZonedDateTime`, `OffsetDateTime`, `Instant` and `LocalDateTime`, so these `java.time` types now convert directly instead of going through `XMLGregorianCalendar`.
* Use the diamond operator (`<>`) in generated code instead of repeating the generic type arguments.
* Use Java's multi-catch in generated code when several exceptions are handled the same way, instead of multiple separate `catch` blocks.
* Use `URI.create(String).toURL()` instead of the deprecated `new URL(String)` constructor in `String` to `URL` conversions, avoiding deprecation warnings on Java 20+.

### Enhancements with behavior changes

* Mappings from `Collection<? super Type>` to `Collection<? extends Type>` (and the corresponding `Stream` case) now result in `PROPERTYMAPPING_MAPPING_NOT_FOUND` instead of generating code that fails to compile due to an unchecked cast.

### Download

This concludes our tour through MapStruct 1.7 Beta2.
If you'd like to try out the features described above, you can fetch the new release from Maven Central using the following GAV coordinates:

* Annotation JAR: [org.mapstruct:mapstruct:1.7.0.Beta2](http://search.maven.org/#artifactdetails|org.mapstruct|mapstruct|1.7.0.Beta2|jar)
* Annotation processor JAR: [org.mapstruct:mapstruct-processor:1.7.0.Beta2](http://search.maven.org/#artifactdetails|org.mapstruct|mapstruct-processor|1.7.0.Beta2|jar)

Alternatively, you can get ZIP and TAR.GZ distribution bundles - containing all the JARs, documentation etc. - [from GitHub](https://github.com/mapstruct/mapstruct/releases/tag/1.7.0.Beta2).

If you run into any trouble or would like to report a bug, feature request or similar, use the following channels to get in touch:

* Get help in our [GitHub Discussions](https://github.com/mapstruct/mapstruct/discussions) or [StackOverflow](https://stackoverflow.com/questions/tagged/mapstruct)
* Report bugs and feature requests via the [issue tracker](https://github.com/mapstruct/mapstruct/issues)
* Follow [@GetMapStruct](https://twitter.com/GetMapStruct) on Twitter
