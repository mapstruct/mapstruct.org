---
title: "Announcing Gem Tools"
author: Filip Hrisafov, Sjaak Derksen
date: "2020-02-03"
tags: [release, news]
---

Lately, we have been busy working on the release of MapStruct 1.4, adding new features and trying to 
simplify our codebase so we can maintain it easier and add features faster.

From the start of the project we have been using a utility tool [Hickory](https://web.archive.org/web/20070724060104/https://hickory.dev.java.net/)
for generating Prisms (partial reflection access to annotations) during compilation time. 
Basically, we've been using an annotation processor to generate access to the MapStruct annotations,
this allows us to access the MapStruct annotation in a type-safe way, without requiring the annotation JAR to be on the processor path.
This is a really old project and the only release on Maven Central is from March 2010.

Thus we needed something newer and created our own utility.
Say hi to [Gem Tools](https://github.com/mapstruct/tools-gem). 
 
<!--more-->

### Why create a new tool?

The Hickory Annotation processor is a really simple processor, which has served us for a really long time.
We've had no problems with it. 
However, we noticed that it is no longer easy for us to add new features quickly.
Andrei had to close his PR [#1923](https://github.com/mapstruct/mapstruct/pull/1923) due to different maintainability problems.
The processor being old also meant that it had some warnings when compiling our code on newer Java versions.

### Benefits

The benefits of the Gem Tools are that you can generate a gem for any annotation out there.
The annotation can be in any third party library. 
We are actually doing this create a gem for `javax.xml.bind.annotation.XmlElementDecl`.

### Usage

Gem Tools has 2 dependencies that you would use:

* `gem-api` - The public API
* `gem-processor` - The annotation processor needed only during compilation type.

#### Apache Maven

If you're using Maven to build your project add the following to your _pom.xml_ to use Gem Tools:

{{< prettify xml >}}...
<properties>
    <tools.gem.version>1.0.0.Alpha1</tools.gem.version>
</properties>
...
<dependencies>
    <dependency>
        <groupId>org.mapstruct.tools.gem</groupId>
        <artifactId>gem-api</artifactId>
        <version>${tools.gem.version}</version>
    </dependency>
</dependencies>
...
<build>
    <plugins>
        <plugin>
            <groupId>org.apache.maven.plugins</groupId>
            <artifactId>maven-compiler-plugin</artifactId>
            <version>3.5.1</version> <!-- or newer version -->
            <configuration>
                <source>1.8</source> <!-- depending on your project -->
                <target>1.8</target> <!-- depending on your project -->
                <annotationProcessorPaths>
                    <path>
                        <groupId>org.mapstruct.tools.gem</groupId>
                        <artifactId>gem-processor</artifactId>
                        <version>${tools.gem.version}</version>
                    </path>
                    <!-- other annotation processors -->
                </annotationProcessorPaths>
            </configuration>
        </plugin>
    </plugins>
</build>
{{< /prettify >}}

#### Gradle

With Gradle, you add something along the following lines to your _build.gradle_:

{{< prettify groovy >}}
dependencies {
    ...
    compile 'org.mapstruct.tools.gem:gem-api:1.0.0.Alpha1'

    annotationProcessor 'org.mapstruct.tools.gem:gem-processor:1.0.0.Alpha1'
}
{{< /prettify >}}

#### Gem API

The API surface is extremely small. 
There is one repeatable `GemDefinition` annotation which is used to tell the Gem Processor for which annotations it should generate your gems.
For every gem definition there will be one `Gem` created which would provide access to its `GemValue`(s).

e.g.

Let's show how to create `MappingGem` for the well known MapStruct `@Mapping`.

{{< prettify java >}}
@GemDefinition(Mapping.class)
public interface GemGenerator {
}
{{< /prettify >}}


This would create a `MappingGem` with the following structure:

{{< prettify java >}}
public class MappingGem implements Gem {

    // Gem Value fields removed for clarity

    private final boolean isValid;
    private final AnnotationMirror mirror;

    private MappingGem( BuilderImpl builder ) {
        //...
    }

    public GemValue<String> target( ) {
        return target;
    }

    public GemValue<String> source( ) {
        return source;
    }

    public GemValue<String> dateFormat( ) {
        return dateFormat;
    }

    public GemValue<String> numberFormat( ) {
        return numberFormat;
    }

    public GemValue<String> constant( ) {
        return constant;
    }

    public GemValue<String> expression( ) {
        return expression;
    }

    public GemValue<String> defaultExpression( ) {
        return defaultExpression;
    }

    public GemValue<Boolean> ignore( ) {
        return ignore;
    }

    public GemValue<List<TypeMirror>> qualifiedBy( ) {
        return qualifiedBy;
    }

    public GemValue<List<String>> qualifiedByName( ) {
        return qualifiedByName;
    }

    public GemValue<TypeMirror> resultType( ) {
        return resultType;
    }

    public GemValue<List<String>> dependsOn( ) {
        return dependsOn;
    }

    public GemValue<String> defaultValue( ) {
        return defaultValue;
    }

    public GemValue<String> nullValueCheckStrategy( ) {
        return nullValueCheckStrategy;
    }

    public GemValue<String> nullValuePropertyMappingStrategy( ) {
        return nullValuePropertyMappingStrategy;
    }

    @Override
    public AnnotationMirror mirror( ) {
        return mirror;
    }

    @Override
    public boolean isValid( ) {
        return isValid;
    }

    public static MappingGem  instanceOn(Element element) {
        return build( element, new BuilderImpl() );
    }

    public static MappingGem instanceOn(AnnotationMirror mirror ) {
        return build( mirror, new BuilderImpl() );
    }

    public static  <T> T  build(Element element, Builder<T> builder) {
        AnnotationMirror mirror = element.getAnnotationMirrors().stream()
            .filter( a ->  "org.mapstruct.Mapping".contentEquals( ( ( TypeElement )a.getAnnotationType().asElement() ).getQualifiedName() ) )
            .findAny()
            .orElse( null );
        return build( mirror, builder );
    }

    public static <T> T build(AnnotationMirror mirror, Builder<T> builder ) {

        // return fast
        if ( mirror == null || builder == null ) {
            return null;
        }

        // fetch defaults from all defined values in the annotation type
        List<ExecutableElement> enclosed = ElementFilter.methodsIn( mirror.getAnnotationType().asElement().getEnclosedElements() );
        Map<String, AnnotationValue> defaultValues = new HashMap<>( enclosed.size() );
        enclosed.forEach( e -> defaultValues.put( e.getSimpleName().toString(), e.getDefaultValue() ) );

        // fetch all explicitely set annotation values in the annotation instance
        Map<String, AnnotationValue> values = new HashMap<>( enclosed.size() );
        mirror.getElementValues().entrySet().forEach( e -> values.put( e.getKey().getSimpleName().toString(), e.getValue() ) );

        // iterate and populate builder
        for ( String methodName : defaultValues.keySet() ) {

            if ( "target".equals( methodName ) ) {
                builder.setTarget( GemValue.create( values.get( methodName ), defaultValues.get( methodName ), String.class ) );
            }
            //...
        }
        builder.setMirror( mirror );
        return builder.build();
    }

    /**
     * A builder that can be implemented by the user to define custom logic e.g. in the
     * build method, prior to creating the annotation gem.
     */
    public interface Builder<T> {

       //...

        /**
         * The build method can be overriden in a custom custom implementation, which allows
         * the user to define his own custom validation on the annotation.
         *
         * @return the representation of the annotation
         */
        T build();
    }

    private static class BuilderImpl implements Builder<MappingGem> {


        // ...

        public MappingGem build() {
            return new MappingGem( this );
        }
    }

}
{{< /prettify >}}

`GemValue` is a wrapper that provides access to the annotation values:

{{< prettify java >}}
public class GemValue<T> {

    // Different creator functions

    private final T value;
    private final T defaultValue;
    private final AnnotationValue annotationValue;

    private GemValue(T value, T defaultValue, AnnotationValue annotationValue) {
        this.value = value;
        this.defaultValue = defaultValue;
        this.annotationValue = annotationValue;
    }

    /**
     * The implied valued, the value set by the user, default value when not defined
     *
     * @return the implied value
     */
    public T get() {
        return value != null ? value : defaultValue;
    }

    /**
     * The value set by the user
     *
     * @return the value, null when not set
     */
    public T getValue() {
        return value;
    }

    /**
     * The default value, as declared in the annotation
     *
     * @return the default value
     */
    public T getDefaultValue() {
        return defaultValue;
    }

    /**
     * The annotation value, e.g. for printing messages {@link javax.annotation.processing.Messager#printMessage}
     *
     * @return the annotation value (null when not set)
     */
    public AnnotationValue getAnnotationValue() {
        return annotationValue;
    }

    /**
     * @return true a value is set by user
     */
    public boolean hasValue() {
        return value != null;
    }

    /**
     * An annotation set to be valid when set by user or a default value is present.
     *
     * @return true when valid
     */
    public boolean isValid() {
        return value != null || defaultValue != null;
    }

}
{{< /prettify >}}

We saw how the implementation looks like. However, the most interesting bit is how this can be used.

{{< prettify java >}}

ExecutableElement method = getMappingMethod();
for ( AnnotationMirror annotationMirror : method.getAnnotationMirrors() ) {
   MappingGem mapping = MappingGem.instanceOn( annotationMirror );
   if ( mapping != null ) {
       GemValue<String> targetValue = mapping.target();
       if ( !mapping.target().hasValue() ) {
           messager.printMessage(
               method,
               mapping.mirror(),
               mapping.target().getAnnotationValue(),
               Message.PROPERTYMAPPING_EMPTY_TARGET
           );
       }
    
       if ( mapping.source().hasValue() && mapping.constant().hasValue() ) {
           messager.printMessage(
                          method,
                          mapping.mirror(),
                          Message.PROPERTYMAPPING_SOURCE_AND_CONSTANT_BOTH_DEFINED
                      );
       }
   }  
}
{{< /prettify >}}

Here we are iterating over all the annotations of the mapping method (`method.getAnnotationMirros()`).
We try to get the `MappingGem` from the annotation (`MappingGem.instanceOn( annotationMirror )`).
Then ff the annotation is a `@Mapping` annotation (i.e. `mapping != null`) we do some error checks:

* If there is no target value (i.e. the mapping was defined with `@Mapping`) then add a compilation error
* If there are both source and constant values defined, which is not allowed in MapStruct 
(i.e. defined with `@Mapping(target = "firstName", source = "name", constant = "Filip")`) then add a compilation error

### Future

We would like to use this project to try some ideas with the code generation that could benefit us within MapStruct.
Currently we use Freemarker for the code generation, but we would like to explore [JavaPoet](https://github.com/square/javapoet).

We would also invite you to try it out and tell us what you want to see in it. 
Feel Free to create issues and PRs with new functionality. 

### Thanks

I would like to say big thank you to Sjaak for the efforts in doing this and bringing it into MapStruct.

Happy coding with Gem Tools!!

### Download

You can fetch the new release from Maven Central using the following GAV coordinates:

* Annotation JAR: [org.mapstruct.tools.gem:gem-api:1.0.0.Alpha1](http://search.maven.org/#artifactdetails|org.mapstruct.tools.gem|gem-api|1.0.0.Alpha1|jar)
* Annotation processor JAR: [org.mapstruct.tools.gem:gem-processor:1.0.0.Alpha1](http://search.maven.org/#artifactdetails|org.mapstruct.tools.gem|gem-processor|1.0.0.Alpha1|jar)

If you run into any trouble or would like to report a bug, feature request or similar, use the following channels to get in touch:

* Get help in our [Gitter room](https://gitter.im/mapstruct/mapstruct-users)
* Report bugs and feature requests via the [issue tracker](https://github.com/mapstruct/tools-gem/issues)
* Follow [@GetMapStruct](https://twitter.com/GetMapStruct) on Twitter
