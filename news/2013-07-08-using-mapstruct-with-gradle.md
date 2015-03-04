---
title: Using MapStruct with Gradle
author: Gunnar Morling
layout: news
tags: [how-to, build, gradle]
---

You work with [Gradle](http://www.gradle.org/) to build your application and would like to make use of MapStruct to generate mappings between different representations of your model? Then read on to learn how to make MapStruct work with the Groovy based build tool.

### Background

MapStruct is implemented in form of an annotation processor as specified by [JSR 269](http://jcp.org/en/jsr/detail?id=269). Annotation processors are plugged into the Java compiler and can inspect the sources during compilation as well as create new sources as it is done by MapStruct. JSR 269 processors can be integrated into basically any form of Java build as long as you work with Java 6 or later.

One way of using an annotation processor is to put its JAR onto the compilation classpath where it will be picked up automatically by the Java compiler. This approach works, but it has the advantage that it exposes the processor and its classes to the compiled application which thus &#150; accidentially or not &#150; could import types from the processor.

This sort of issue can be avoided by setting up the processor separately. When working with `javac` directly, the [processorpath](http://docs.oracle.com/javase/7/docs/technotes/tools/solaris/javac.html#options) option can be used for this purpose, while for Maven projects the [maven-annotation-plugin](http://code.google.com/p/maven-annotation-plugin/) is the recommended way to integrate annotation processors.

### Set up MapStruct in your Gradle build

To integrate MapStruct into a Gradle build, first make sure you use the Java 6 language level by adding the following to the _build.gradle_ file of your project:

<pre class="prettyprint linenums">
ext {
    javaLanguageLevel = '1.6'
    generatedMapperSourcesDir = "${buildDir}/generated-src/mapstruct/main"
}

sourceCompatibility = rootProject.javaLanguageLevel
</pre>

It's a good idea to declare a property which holds the language level. That way it can be referenced later on where required. We also define a property which specifies the target directory for the generated mapper classes.

The next step is to add the MapStruct annotation module (<em>org.mapstruct:mapstruct:&lt;VERSION&gt;</em>) as compilation dependency and to declare a separate [dependency configuration](http://www.gradle.org/docs/current/userguide/dependency_management.html#sub:configurations) which contains the MapStruct processor module (<em>org.mapstruct:mapstruct-processor:&lt;VERSION&gt;</em>):
    
<pre class="prettyprint linenums">
configurations {
    mapstruct
}

dependencies {
    compile( 'org.mapstruct:mapstruct:&lt;VERSION&gt;' )
    mapstruct( 'org.mapstruct:mapstruct-processor:&lt;VERSION&gt;' )
}
</pre>

The separate dependency configuration makes sure that the classes from the processor aren't visible to the compiled application. To make the generated sources available for the actual compilation step add the previously configured path to the main [source set](http://www.gradle.org/docs/current/userguide/java_plugin.html#N11D51) like this:

<pre class="prettyprint linenums">
sourceSets.main {
    ext.originalJavaSrcDirs = java.srcDirs
    java.srcDir "${generatedMapperSourcesDir}"
}
</pre>

We also store the original source directories in a property in order to reference them later on. Now it's time to set up a task for the invocation of the annotation processor. To do so, declare a task of the type [JavaCompile](http://www.gradle.org/docs/current/dsl/org.gradle.api.tasks.compile.JavaCompile.html) like this:

<pre class="prettyprint linenums">
task generateMainMapperClasses(type: JavaCompile) {
    ext.aptDumpDir = file( "${buildDir}/tmp/apt/mapstruct" )
    destinationDir = aptDumpDir

    classpath = compileJava.classpath + configurations.mapstruct
    source = sourceSets.main.originalJavaSrcDirs
    ext.sourceDestDir = file ( "$generatedMapperSourcesDir" )

    options.define(
        compilerArgs: [
            "-nowarn",
            "-proc:only",
            "-encoding", "UTF-8",
            "-processor", "org.mapstruct.ap.MappingProcessor",
            "-s", sourceDestDir.absolutePath,
            "-source", rootProject.javaLanguageLevel,
            "-target", rootProject.javaLanguageLevel,
        ]
    );

    inputs.dir source
    outputs.dir generatedMapperSourcesDir;
    doFirst {
         sourceDestDir.mkdirs()
    }
    doLast {
        aptDumpDir.delete()
    }
}
</pre>

The task's classpath comprises both, the actual compilation classpath as well as the `mapstruct` configuration set up before. As source path the previously stored source directories are used.

The options passed to the compile task should be rather self-explanatory. Note that by passing `-proc:only`, the task will only invoke the given processor but perform no compilation (that will be done by the default compilation step later on).

By declaring the `inputs` and `outputs` of the task we make sure Gradle's [incremental build](http://www.gradle.org/docs/current/userguide/more_about_tasks.html#sec:up_to_date_checks) functionality is leveraged. That way Gradle will skip the task when running the build a second time and the generated output files still are up to date.

Finally you need to make sure that the generation of mapper types happens before the compilation of all sources. This can be achieved by declaring the following dependency:

<pre class="prettyprint linenums">
compileJava.dependsOn generateMainMapperClasses
</pre>

### Give it a shot

You can find the complete [build.gradle](https://github.com/mapstruct/mapstruct-examples/blob/master/mapstruct-on-gradle/build.gradle) file on GitHub. It is part of an example project which generates a simple mapper class and executes some tests against it. To clone the example project just execute

<pre class="prettyprint lang-sh linenums">
git clone https://github.com/mapstruct/mapstruct-examples.git
</pre>

You can then build the example by running

<pre class="prettyprint lang-sh linenums">
cd mapstruct-on-gradle &amp;&amp; ./gradlew build
</pre>

The project comes with the [Gradle Wrapper](http://www.gradle.org/docs/current/userguide/userguide_single.html#gradle_wrapper), a small utility which retrieves the right Gradle version upon the first build. So it is not required to install Gradle separately.

In case you have questions, ideas or any other kind of feedback just add a comment to this post or leave a message in the [mapstruct-users](https://groups.google.com/forum/?fromgroups#!forum/mapstruct-users) group.
