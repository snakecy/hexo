---
title: API configure with Php-r-sparkr
date: 2016-01-12 17:25:06
categories: cloud-tech
tags: [R, SparkR, PHP]
---

> ******************************************************************
PHP configure
> ******************************************************************

* How to install the nignx on Ubuntu 10.04?
  Append the appropriate stanza to /etc/apt/sources.list. The Pgp page expalins the signing of th nignx.org released packaging.
  - shell script
  ``` bash
  deb http://nginx.org/packages/ubuntu/ lucid nginx
  deb-src http://nginx.org/packages/ubuntu/ lucid nginx
  ```
  - then do
  ``` bash
  sudo -s
  nginx=stable # use nginx=development for latest development version
  add-apt-repository ppa:nginx/$nginx
  apt-get update
  apt-get install nginx
  ```
  - Then finished. Ref. at website
  (https://www.nginx.com/resources/wiki/start/topics/tutorials/install/)

<!--more-->

* PHP Server Nginx
  - $ cd nginx/html
  - port : 80 --> public port: 8181
  - example-data.cloudapp.net:8181/index.html

* Docker
  - $ curl -sSL https//get.docker.com/ | sh
  - $ sudo docker run hello-world
  - Add a user with 'sudo'
    - sudo user -aG docker admin
  - Restart the server
    - $ docker run hello-world


> *******************************************************************
R installation
> *******************************************************************

* R Tutorial
* Update R on Ubuntu
  - $ sudo gedit /etc/apt/sources.list --> open the .list file
    - sudo vi /etc/apt/sources.list
    - #sudo apt-get install gedit
    - http://cran.r-project.org/becin/linux/ubuntu/
  - add the following line into source.list
    - deb http://cran.cnr.berkeley.edu/bin/linux/ubuntu/ trusty/
    - # trusty for Ubuntu 14.04
  - Secure apt, when u see the gpg secure problem, just do the following lines
    ``` bash
    $sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E084DAB9
    $gpg --keyserver keyserver.ubuntu.com --recv-key E084DAB9
    $gpg -a --export E084DAB9 | sudo apt-key add -
    ```
  - Then, perform this command
    - sudo apt-get update
    - sudo apt-get install r-base r-base-dev

* Import library dplyr & FeatureHashing
  - Request R version >3.1.2
  ``` bash
$ R
> install.packages("dplyr")
> library(dplyr)
> install.packages("FeatureHashing")
> library(FeatureHashing)
  ```

> *********************************************************************
R library
> ********************************************************************

* library
  - Matrix
  - glmnt
  - FeatureHashing
    - Important, the FeatureHashing's latest version is 0.9, which default parameter transpose is TRUE (but in 0.8 version is FALSE)
  - glmnet
  - dplyr
  - ROC http://web.expasy.org/pROC/  
    - install.packages("pROC")
    - library(pROC)
  - "josnlite" package, parser json file
    - A smart json encoder in R https://www.opencpu.org/posts/jsonlite-a-smarter-json-encoder/
    - install.packages("jsonlite", repos="http://cran.r-project.org")
    - install.packages("curl")
  - "lubridate", parser date
  - "json_decode", function to parser json into array
  - R compare script (* important)
  ``` bash
  df = data.frame(A=c(5,6,7,8), B=c(1,7,5,9))
  with(df,df[A>B,])
  ```
  - Censored regression in r
    - Each steps http://stats.stackexchange.com/questions/149091/censored-regression-in-r
    - Package https://cran.r-project.org/web/packages/AER/
    - How to install packages
    ``` bash
> install.packages("AER", lib = "/my/own/R-packages/")
> library("AER", lib.loc="/my/own/R-packages/")
Ref http://www.math.usask.ca/~longhai/software/installrpkg.html
    ```

> ******************************************************************
PHP call R API
> *******************************************************************

* API part
  - PHP API
    - API url http://example-rtb.cloudapp.net:8181/example/api/predict.php
    - PHP calling function methods

    ``` bash
    call_user_func()
    call_user_func('a', "111", "222")
    call_user_func_array()
    call_user_func_array('a', array("111", "222")
    ```

  - RESTful API based OpenCPU
    - example prediction API
    ``` bash
    $ time curl http://localhost:7509/ocpu/library/exampleApi/R/predict_api/json -H "Content-Type:application/json" -d '{"request":["http://*.cloudapp.net:8181/json/req.txt"]}'
    ```

  -  Install opencpu on Ubuntu cloud server
    - Recommended on Ubuntu 14.04

    ``` bash
    #requires ubuntu 14.04 (trusty)
    sudo add-apt-reporitory -y ppa:opencpu/opencpu-1.5
    sudo apt-get update
    sudo apt-get upgrade
    #install opencpu server
    sudo apt-get install -y opencpu
    # optional
    sudo apt-get isntall -y rstudio-server
    ```


* R command
  - Local
  ``` bash
  ./bin/sparkR --packages com.databricks:spark-csv_2.11:1.2.0
  ```
  - Standalone
  ``` bash
  ./bin/sparkR --master spark://example-data01:7077 --packages com.databricks:spark-csv_2.11:1.2.0
  ```
* SparkR MLlib
  - An exampel for sparkR MLlib
    - Ref https://github.com/AlbanPhelip/SparkR-example
  - Only the glm() can be used in sparkR
    ``` bash
    ./bin/sparkR --master spark://example-data01:7077 --packages com.databricks:spark-csv_2.11:1.2.0 /home/admin/Rscript_model_test/train_sparkr.R hdfs://masters/Rscript_model/data.txt hdfs://masters/Rscript_model/model.Rds
    ```

> -------------
R on SparkR  tutorials for Big Data analysis and Machine Learning as IPython/Jupyter notebooks
https://github.com/jadianes/spark-r-notebooks
> -------------

> *********************************************************************
A good example for R app
> *********************************************************************

``` bash
http://blog.fens.me/r-app-china-weather/
RandomForest in R with parallel trainning.
# the parallel computing by RandomForest
library(randomForest)
 cl <- makeCluster(4)
 registerDoParallel(cl)
 rf <- foreach(ntree=rep(25000, 4),
                  .combine=combine,
                  .packages='randomForest') %dopar%
          randomForest(Species~., data=iris, ntree=ntree)
stopCluster(cl)
```


> *********************************************************************
SparkR configure
> *********************************************************************

SparkR is an R package that provides a light-weight frontend to use Apache Spark from R
  - Ref https://github.com/amplab-extras/SparkR-pkg | http://amplab-extras.github.io/SparkR-pkg/
  - Configure the sparkR environment
    - Required
      - openjdk 7, R
    - Steps for set up
    ``` bash
    sudo R
    install.packages("rJava")
    install.packages("devtools", dependencies = TRUE)
    # after install rJava & devtools
    library(devtools)
    install_github("amplab-extras/SparkR-pkg", subdir="pkg")
    # Resolve
    # sudo apt-get install r-cran-rjava
    ```
  - Required
  ``` bash
  sudo apt-get install libxml2-dev
  sudo apt-get install libcurl4-openssl-dev
  sudo apt-get install libcurl4-gnutls-dev
  sudo apt-get install curl
  /etc/apt/source.list
    #deb http://cran.rstudio.com/bin/linux/ubuntu trusty/
  sudo apt-get install libssl-dev
  ```

* Sort the SparkR

``` bash
./bin/sparkR --packages com.databricks:spark-csv_2.11:1.2.0
 sc <- sparkR.init(sparkPackages="com.databricks:spark-csv_2.11:1.2.0")
sc <- sparkR.init(master="spark://example-data01:7077", sparkEnvir=list(spark.executor.memory="10g", spark.cores.max="4"), sparkPackages="com.databricks:spark-csv_2.11:1.2.0" )
sqlContext <- sparkRSQL.init(sc)
dataT <- read.df(sqlContext, "hdfs://masters/Rscript_model/data.txt","com.databricks.spark.csv",header="true",delimiter="\t")
on example-data01: dataT <- read.df(sqlContext, "/home/admin/data/data.txt","com.databricks.spark.csv",header="true",delimiter="\t", transpose = "true", is.dgCMatrix = "false")
Ref script
dataT <- read.df(sqlContext, "/home/admin/data/data.txt","com.databricks.spark.csv",header="true",delimiter="\t")
head(select(dataT,dataT$is_win))
test <- structure(dataT, package="SparkR")
dataT <- read.table(sqlContext, "hdfs://masters/Rscript_model/data.txt","com.databricks.spark.csv",header="true",delimiter="\t")
test <- cbind(select(dataT, "is_win"), select(dataT, "days"), select(dataT, "hours"), select(dataT, "exchange_id"), select(dataT, "app_id"), select(dataT, "publiser_id"), select(dataT, "bidfloor"), select(dataT, "w"), select(dataT, "h"), select(dataT, "os"), select(dataT, "Osv"), select(dataT, "model"), select(dataT, "connectiontype"), select(dataT,"country"), select(dataT, "ua"), select(dataT,"carrier"), select(dataT, "js"), select(dataT, "user"), select(dataT, "carriername"), select(dataT, "app_cat"), select(dataT,"btype"), select(dataT,"mimes"), select(dataT,"badv"), select(dataT,"bcat"))
as.data.frame(test)
```

> ***************************************************************
Output Format using R
> ***************************************************************

- pdf  format
  ``` bash
  pdf(file="myplot.pdf")
  dev.off()
  ```
- jpeg format
  ``` bash
  setwd("path")
  jpeg(file="myplot.jpeg")
  plot(1:10)
  dev.off()
  ```
- png format
  ``` bash
  png(file="myplot.png", bg="transparent")
  dev.off()
  #View the png on Ubuntu, by using "gthumb"
  #  sudo apt-get install gthumb
  #  $gthumb myplot.png
  ```
- bmp format
  ``` bash
  bmp("myplot.bmp")
  ```
- PostScript format
  ``` bash
  postscript("myplot.ps")
  ```
- Windows image file format
  ``` bash
  win.metafile("myplot.ps")
  ```
