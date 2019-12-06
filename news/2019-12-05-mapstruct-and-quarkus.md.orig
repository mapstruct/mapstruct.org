---
title: "MapStruct and Quarkus - a match made in heaven?"
author: Christian Bandowski
date: "2019-12-05"
tags: [news, examples]
---

This year is nearly over, but it was started with something new that came up in the Java world: [Quarkus](https://quarkus.io/). You may already have heard about it, if not, don’t worry, I will quickly summarize what it is.

Additinally to this post you can also find a working example in our [examples repository](https://github.com/mapstruct/mapstruct-examples/tree/master/mapstruct-quarkus).

<!--more-->

### Quarkus
> Supersonic Subatomic Java
> 
> A Kubernetes Native Java stack tailored for GraalVM & OpenJDK HotSpot, crafted from the best of breed Java libraries and standards

That’s the description on [quarkus.io](https://quarkus.io/), but what does this mean?

With Quarkus you can build microservices or other Java applications using a stack of already existing components like [Eclipse Vert.x](https://vertx.io/), [Hibernate](http://hibernate.org/) or [Eclipse MicroProfile](https://microprofile.io/). It has a container-first philosophy which means that Quarkus puts all these frameworks together in a way that the resulting application works very well in container environments like [Kubernetes](https://kubernetes.io/) or [OpenShift](https://openshift.io/).

Read [this article](http://in.relation.to/2019/03/08/why-quarkus/) if you want to know more about Quarkus itself.

#### And what is so special when using it with MapStruct?
The special thing about Quarkus is that it not only allows to run applications on the JVM, but also as native binaries via [GraalVM](https://www.graalvm.org/). This provides ahead-of-time compilation that creates a native image of your application (native system-dependent machine code and not bytecode). Thus you don’t need to have an own JVM installation to run the code, similar to a compiled C++ or Go application. \
This allows having the advantages of native applications also for Java-based apps like a much faster startup time, less memory usage and a much smaller image (just a few megabytes instead of easily more than 100 MB for the JVM and required libraries).

Using a native image is not possible for all kinds of applications, especially when reflection is used the GraalVM compiler needs some assistance by the developer in order to create the native image. That means you have to provide reflection metadata to the compiler which makes the development more complicated.

And thats exactly the point where MapStruct jumps in as a reflection-free mapping library!

### How to integrate MapStruct in a Quarkus application
So let us see how well MapStruct plays together with Quarkus!

I made an example application that will show you how you can integrate MapStruct in your Quarkus application. You will find the complete demo application in our [examples repository](https://github.com/mapstruct/mapstruct-examples/mapstruct-quarkus).

The example should be a simple REST application just having a `/person` endpoint returning information about a person. Obviously, the internally used classes should not be exposed, but a DTO will be created and filled with information from a MapStruct mapper.

#### Create a new Quarkus application
After reading the [Getting Started](https://quarkus.io/guides/getting-started-guide) on the Quarkus pages it was really easy to figure out how to create a new application. Just run the following command:

{{< prettify >}}
mvn io.quarkus:quarkus-maven-plugin:1.0.1.Final:create \
  -DprojectGroupId=org.mapstruct.examples.quarkus \
  -DprojectArtifactId=mapstruct-examples-quarkus \
  -DclassName="org.mapstruct.example.quarkus.PersonResource" \
  -Dpath="/person" \
  -Dextensions="resteasy-jsonb"
{{< /prettify >}}

This will setup a new Quarkus application having a REST endpoint `/person` defined in a `PersonResource`. We want to expose the JSON structure automatically, so we need the `resteasy-jsonb` extension that will allow us to marshall our object to JSON (like you probably know it from Spring REST or similar frameworks).

#### Adding MapStruct
You just need to add MapStruct in your projects POM:

{{< prettify xml >}}
<dependency>
  <groupId>org.mapstruct</groupId>
  <artifactId>mapstruct</artifactId>
  <version>1.3.1.Final</version>
</dependency>
<dependency>
  <groupId>org.mapstruct</groupId>
  <artifactId>mapstruct-processor</artifactId>
  <version>1.3.1.Final</version>
  <scope>provided</scope>
</dependency>
{{< /prettify >}}

_Side note:_ In case you use for example Lombok pay attention that you define the dependency **before** the one for the MapStruct processor.

#### Person service
This example application will have a `Person` POJO holding information about the person and a `PersonService` that will return the person.

So we have to create the following two classes:

{{< prettify java >}}
public class Person {
  private String firstname;
  private String lastname;
  
  // all-args constructor, getters, setters
}
{{< /prettify >}}

{{< prettify java >}}
@ApplicationScoped
public class PersonService {
  public Person loadPerson() {
    return new Person("Bob", "Miller");
  }
}
{{< /prettify >}}

What is the first thing you notice?

Okay… the service is very boring. It always returns the same object. But that’s not what I meant, it’s just an example. Most likely, your application will fetch the information from an external system.

What I meant is the `@ApplicationScoped` annotation that was used. If you are a Spring developer you might not know it, but this is a regular Jakarta EE annotation that belongs to [CDI](https://www.jcp.org/en/jsr/detail?id=299) and marks this class as (more or less) an application-wide singleton that is “injectable”. Similar to `@Component` or `@Service` from Spring.

Most of the commonly used frameworks are using reflection for the DI and as mentioned before reflection doesn’t play well with native images. But the Quarkus team did a great job and provided a CDI implementation that can be used together with native images - so that’s then most likely the way to go when you need dependency injection and build a Quarkus application!

#### DTO and mapper
We don’t like to expose internal objects, thus we create a new `PersonDto` that matches our API.

{{< prettify java >}}
public class PersonDto {
  private String firstname;
  private String surname;
  
  // getters, setters
}
{{< /prettify >}}

So now, we have a `Person` and `PersonDto` that both have a similar structure. We are able to retrieve a `Person`, but want to return a `PersonDto`, so that’s the time where we finally add our MapStruct mapper!

{{< prettify java >}}
@Mapper(componentModel = "cdi")
public interface PersonMapper {
    @Mapping(target = "surname", source = "lastname")
    PersonDto toResource(Person person);
}
{{< /prettify >}}

The MapStruct annotation processor will generate the implementation for us, we just need to tell it that we would like to have a method that accepts a `Person` and returns a new `PersonDto`. A little trap: Our DTO has the property `surname`, so we add a mapping annotation to map `lastname` from `Person` to `surname` from `PersonDto`.

**Very important:** The component model should be set to CDI, as this will allow us to easily inject the generated mapper implementation.

_Side note: As you need to use CDI for all mappers it’s recommended to define a `@MapperConfig` and refer to it in all your mappers, this is the way I did it in the example on GitHub. But for simplicity I skipped it here._

#### Endpoint
As a last step we need to create our endpoint that will get the correct `Person` and finally returns the `PersonDto`.

The `PersonResource` was already generated by Quarkus providing a `/person` endpoint that just returns a static text. We will remove this operation and exchange it with a new one that returns our person:

{{< prettify java >}}
@Path("/person")
public class PersonResource {
 
  @Inject
  PersonService personService;
 
  @Inject
  PersonMapper personMapper;
 
  @GET
  @Produces(MediaType.APPLICATION_JSON)
  public PersonDto loadPerson() {
    return personMapper.toResource( personService.loadPerson() );
  }
}
{{< /prettify >}}

To be able to access our `PersonService` and `PersonMapper` we will inject both using CDI.

The `loadPerson()` method will then just call our service to load the person, throw it into our mapper and return the DTO.

That’s it!

#### Start the application
If you would like to run the application you just need to hit `mvn compile quarkus:dev`. This will compile everything (which includes mapper generation) and starts a local server running the application.

After starting the application you should see a log output similar to the following one:

{{< prettify >}}
Quarkus 1.0.1.Final started in 1.448s. Listening on: http://0.0.0.0:8080
Profile dev activated. Live Coding activated.
Installed features: [cdi, resteasy, resteasy-jsonb]
{{< /prettify >}}

You can now open [http://localhost:8080/person](http://localhost:8080/person) in your browser and should see a JSON representating our person.

#### Build the native image
Okay, starting the application took nearly one and a half second. Very slow, isn’t it? That means every time the app will start you need to waste 1.5 seconds of your lifetime… okay, just kidding. That’s already really fast! But okay, it is also a really small application. Nevertheless, it should be mentioned that Quarkus also has a few optimizations to start the server when using the regular JVM really fast.
But yeah, we can do it even faster. So let us build a native image!

Following the [guide](https://quarkus.io/guides/building-native-image-guide) on the Quarkus page, you can build the native image just using one command:

{{< prettify >}}
mvn package -Pnative
{{< /prettify >}}

_(In case you get an error that tests fail remove those or update them, I skipped this here as well)_

As a prerequisite you need to have the GraalVM installed correctly. In case you don’t want or can install it on your machine take a look at the multi-stage Docker build in the previously mentioned guide.

The command will produce an executable application in the `target` folder (it ends with `-runner`) that you can just start.

You will notice that running the native compilation will take a while as it will not just compile your application as usual, it will afterwards create the native image. This process takes some time, but you will save this time afterwards in production when you need to (re)start your application plenty of times.

The output after starting the app should look like this:

{{< prettify >}}
mapstruct-examples-quarkus 1.0-SNAPSHOT (running on Quarkus 1.0.1.Final) started in 0.006s. Listening on: http://0.0.0.0:8080
Profile prod activated. 
Installed features: [cdi, resteasy, resteasy-jsonb]
{{< /prettify >}}

I will repeat: _started in **0.006s**_.

**This** is incredibly fast!

### Summing up
This example shows how easy it is to integrate MapStruct in a Quarkus application. This is a really huge plus-point for using MapStruct as the mapping framework in a Quarkus application compared to most of the other mapping frameworks that are using reflection.

Therefore generating the mapper implementation does not only lead to be a [really fast](https://www.baeldung.com/java-performance-mapping-frameworks) mapping framework, but also to be a “native image” ready one!

So yes: **MapStruct and Quarkus is definitely a match made in heaven!**

The important point is to use CDI. The default component model (that’s where you retrieve the mapper with `Mappers.getMapper(PersonMapper.class)`) will not work out-of-the-box as this is the only part in MapStruct where reflection is used. If you still prefer this way you have to provide an own [reflection configuration](https://github.com/oracle/graal/blob/master/substratevm/REFLECTION.md). Maybe in the future MapStruct will also support this out-of-the box. But with version 1.3.1.Final it is not yet supported.


#### One small disadvantage still left
In case you are an experienced MapStruct user you might havenoticed that [the way how I added MapStruct](#adding-mapstruct) is a bit different to the way it is written in our [reference guide](http://mapstruct.org/documentation/stable/reference/html/#_apache_maven).

The Quarkus development mode provides a hot-reload of your application, unfortunately it seems that the annotation processor will not be triggered again when you define the MapStruct processor within the annotation-processor path of the `maven-compiler-plugin` and you have to restart the application to see changes on the mappings.

Adding our processor as a regular dependency will ensure that the processor will be used in the dev-mode in case you make changes to a `@Mapper` annotated class. Unfortunately, one point is still not working out-of-the-box: When you change classes not annotated with `@Mapper` that would change the mapper implementation (like the DTO) the mapper will not be regenerated. I guess that Quarkus is not able to know that the changed DTO has a side effect on the corresponding mapper and as this one will not be regenerated the annotation processor will not update the mapper implementation (see [Quarkus issue #1502](https://github.com/quarkusio/quarkus/issues/1502)).

