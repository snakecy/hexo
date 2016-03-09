---
title: about-libsvm
date: 2016-03-10 01:13:22
categories: open-source
tags: [Libsvm, Java]
---




Tutorial
http://jacoxu.com/?p=118


Weka
http://jayatiatblogs.blogspot.hk/2013/05/running-wekas-logistic-regression-using.html


liblinear-java-1.95.jar
https://github.com/bwaldvogel/liblinear-java

``` bash
training:  java -cp liblinear-java-1.95.jar de.bwaldvogel.liblinear.Train -s 0 data_file
prediction: java -cp liblinear-java-1.95.jar de.bwaldvogel.liblinear.Prediction -b 1 test_file data_file.model output_file
```

Spark liblinear
Ref --> http://www.csie.ntu.edu.tw/~cjlin/libsvmtools/distributed-liblinear/spark/running_spark_liblinear.html
Limited for the JDK version (before 8u)
