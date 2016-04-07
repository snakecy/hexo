---
title: Machine Learning with Scala
date: 2016-03-10 00:26:44
categories: cloud-tech
tags: [Scala, Spark]
---


>****************************************************
Good Example: REST API & Velox [PPT](http://www.slideshare.net/dscrankshaw/veloxampcamp5-final), [Papre](http://arxiv.org/pdf/1409.3809v2.pdf), [Github](https://github.com/amplab/velox-modelserver)
>****************************************************

### Construct project, with SBT & dependencies
> The reference example project can be found on [my github](https://snakecy.github.io)

- think-bayes [[github]](https://github.com/ruippeixotog/think-bayes-scala), [[Repository]](https://maven-repository.com/artifact/net.ruippeixotog/think-bayes_2.11/0.1)
  - probability density function of the standard normal distribution & cumulative density function of the standard normal distribution
``` bash
  - libraryDependencies += "net.ruippeixotog" % "think-bayes_2.11" % "0.1"
```

<!-- more -->
- Other libraryDependencies
  spark-core_2.10, spark-mllib_2.10, jblas
- Using IntelliJ IDEA to package scala with spark
  - The reason of the Scala for Eclipse is not comfortable in using
  - Support code checking, cvs/ant/maven/git
  - JDK, Scala
- Censored regression model, contains 5 scala class
  - Main class -> TestTrainer.scala
  - optimization.scala
  - gradient.scala
  - linalg.scala
  - utils.scala
  - build.sbt

#### Complie

- Ref to: spark-shell --packages com.databricks:spark-csv_2.11:1.2.0
- spark-shell --packages net.ruippeixotog:think-bayes_2.11:0.1
- Using the think-bayes to check the Pdf() and Cdf() functions
  - SBT package for think-bayes with scala 2.10.4
  - ./bin/spark-shell --driver-class-path /home/azureuser/think-bayes-scala/target/scala-2.10/think-bayes_2.10-1.0-SNAPSHOT.jar
  - then, import thinkbayes._

#### sbt assembly methods

- Scala library
http://www.scala-lang.org/api/current/index.html#scala.math.package

- Creat a project/assembly.sbt
  - Add
    -addSbtPlugin("com.eed3si9n" % "sbt-assembly" % "0.14.1")
  - When using sbt 0.13.5
    - addSbtPlugin("com.eed3si9n" % "sbt-assembly" % "0.11.2")

- Add in build.sbt

``` bash
mergeStrategy in assembly := {
  case m if m.toLowerCase.endsWith("manifest.mf")          => MergeStrategy.discard
  case m if m.toLowerCase.matches("meta-inf.*\\.sf$")      => MergeStrategy.discard
  case "log4j.properties"                                  => MergeStrategy.discard
  case m if m.toLowerCase.startsWith("meta-inf/services/") => MergeStrategy.filterDistinctLines
  case "reference.conf"                                    => MergeStrategy.concat
  case _                                                   => MergeStrategy.first
}
```

- Dependencies

``` bash
libraryDependencies ++= Seq(
  "com.github.wookietreiber" %% "scala-chart"   % "0.5.0",
  "nz.ac.waikato.cms.weka"    % "weka-stable"   % "3.6.13",  
 "org.apache.commons"        % "commons-math3" % "3.5",  
 "org.specs2"               %% "specs2-core"   %  "3.6.5" % "test")
```


- https://github.com/sbt/sbt-assembly
- https://github.com/ruippeixotog/think-bayes-scala/blob/master/build.sbt
- https://maven-repository.com/artifact/net.ruippeixotog/think-bayes_2.11/0.1

- Ref to build spark using scala 2.11
  - https://jaceklaskowski.gitbooks.io/mastering-apache-spark/content/spark-building-from-sources.html  

* Push source to Github with SourceTree
  - new clone
  - repositry
  - commit
  - push

* Keen on study on the function of pdf and cdf in censored regression model
  - Self-defined the function using normal distribution function
    - f(x) -> 1/(sqrt(2pi)*sigma) * exp(-(x-u)^2/2*sigma^2)
    - then f(x) accumulate to cdf
