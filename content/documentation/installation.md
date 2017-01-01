+++
date = "2016-12-31T13:23:04+01:00"
draft = false
title = "Installation"
weight = 100
teaser = "How to download and set it up with different build tools"
aliases = [
    "/download/"
]
[menu]
[menu.main]
parent = "Documentation"
+++

## Distribution Bundle

You can obtain a distribution bundle containing the MapStruct binaries, source code and API documentation from [SourceForge](http://sourceforge.net/projects/mapstruct/files/).

## Maven

If you're using Maven to build your project add the following to your _pom.xml_ to use MapStruct:

{{< prettify xml >}}...
<properties>
    <org.mapstruct.version>{{% stableversion %}}</org.mapstruct.version>
</properties>
...
<dependencies>
    <dependency>
        <groupId>org.mapstruct</groupId>
        <artifactId>mapstruct</artifactId> <!-- use mapstruct-jdk8 for Java 8 or higher -->
        <version>${org.mapstruct.version}</version>
    </dependency>
</dependencies>
...
<build>
    <plugins>
        <plugin>
            <groupId>org.apache.maven.plugins</groupId>
            <artifactId>maven-compiler-plugin</artifactId>
            <version>3.5.1</version>
            <configuration>
                <source>1.6</source> <!-- or higher, depending on your project -->
                <target>1.6</target> <!-- or higher, depending on your project -->
                <annotationProcessorPaths>
                    <path>
                        <groupId>org.mapstruct</groupId>
                        <artifactId>mapstruct-processor</artifactId>
                        <version>${org.mapstruct.version}</version>
                    </path>
                </annotationProcessorPaths>
            </configuration>
        </plugin>
    </plugins>
</build>
{{< /prettify >}}

## Gradle

With Gradle, you add something along the following lines to your _build.gradle_:

{{< prettify groovy >}}plugins {
    ...
    id 'net.ltgt.apt' version '0.8'
}
dependencies {
    ...
    compile 'org.mapstruct:mapstruct:{{% stableversion %}}'

    // OR use this with Java 8 and beyond
    compile 'org.mapstruct:mapstruct-jdk8:{{% stableversion %}}'

    apt 'org.mapstruct:mapstruct-processor:{{% stableversion %}}'
}
{{< /prettify >}}

## Ant

tbd.
