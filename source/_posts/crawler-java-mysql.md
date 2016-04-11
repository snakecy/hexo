---
title: Blog Crawler By Java and MySQL
date: 2016-04-10 00:39:20
categories: cloud-tech
tags: [Java, MySQL]
---

> XAMPP

### Environment
1. Mac + Eclipse
2. Before building the program, we need to prepare the related open-source classes, likes,
    - Apache HttpComponents 4.5 (Supply HTTP interface, submit the HTTP requires to the Target URL, so as to obtain the web's content. )
    - HTML Parser 2.0 (Used to parser website, to extract url links from DOM nodes)
    - MySQL Connector/J 5. 1.38 (Connect the Java with MySQL, then you can use java code to operate the database. )

<!-- more -->
Othewise, We only need to install the XAMPP(which contains all the jars that metioned above) to supply the URL port to access to MySQL database.

### Code
All codes are contained in three differents file, CrawlerMain.java, httpGet.java and parsePage.java.

### Demo using Java and MySQL to Crawler my blog

The blog crawler program code using Java and MySQL is uploaded to my [github](https://snakecy.github.io/crawler-java-mysql).
Then, with the results, I display it using nodejs.
