---
title: Libsvm Package
date: 2016-02-10 01:13:22
categories: open-source
tags: [Libsvm, Java]
---

About the applications using libsvm tools on different platform.

[libsvm tutorial](http://jacoxu.com/?p=118)

which can be used on the following platform, such as Java, matlab(64 bit), python, svm-toy.


[liblinear-java-1.95.jar](https://github.com/bwaldvogel/liblinear-java)

``` bash
training:  java -cp liblinear-java-1.95.jar de.bwaldvogel.liblinear.Train -s 0 data_file
prediction: java -cp liblinear-java-1.95.jar de.bwaldvogel.liblinear.Prediction -b 1 test_file data_file.model output_file
```

[Spark liblinear](http://www.csie.ntu.edu.tw/~cjlin/libsvmtools/distributed-liblinear/spark/running_spark_liblinear.html)
  - Limited for the JDK version (before 8u)
