---
title: Resolve the debug problem of WARN NativeCodeLoader
date: 2016-02-10 00:58:25
categories: cloud-tech
tags: [Hadoop, Spark]
---

### Debug
Resolve the debug problem of when to start up spark, WARN NativeCodeLoader will turn on.

``` bash
export HADOOP_HOME=/home/admin/hadoop
#export PATH=$HADOOP_HOME/bin:$PATH
#export HADOOP_COMMON_LIB_NATIVE_DIR=$HADOOP_HOME/lib/native
#export HADOOP_OPTS="-Djava.library.path=$HADOOP_HOME/lib/native"
#export LD_LIBRARY_PATH=$HADOOP_HOME/lib/native
```


``` bash
WARN BLAS: Failed to load implementation from: com.github.fommil.netlib.NativeSystemBLAS
WARN BLAS: Failed to load implementation from: com.github.fommil.netlib.NativeRefBLAS
```


### Solutions

Three ways to solve the problem

> install libgfortran3
> linstall libatlas3-base libopenblas-base
> OpenBlase


* in sbt file: libraryDependencies += "com.github.fommil.netlib" % "all" % "1.1.2"
  - -Dcom.github.fommil.netlib.BLAS=com.github.fommil.netlib.F2jBLAS
  - https://github.com/mridulm/netlib-java

* or in commandline
``` bash
$ sudo apt-get install libgfortran3
// check the libgfortran3
$ dpkg -l libgfortran3
$ sudo apt-get install gfortran
```

* resolve the problem (important)
  - refers to https://github.com/fommil/netlib-java#machine-optimised-system-libraries

``` bash
sudo apt-get install libatlas3-base libopenblas-base
sudo update-alternatives --config libblas.so.3
sudo update-alternatives --config liblapack.so.3
$ /etc/ld.so.conf
add /usr/lib/libblas.so.3 &  /usr/lib/liblapack.so.3
$ sudo ldconfig
```
