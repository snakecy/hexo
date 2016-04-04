---
title: Apache Server Configure on Mac
date: 2016-03-18 18:15:59
categories: cloud-tech
tags: [PHP, HTTP]
---

### Apache Server
* Start up Apache on Mac
    - sudo apachectl (-k) start
    - //sudo apachectl (-k) restart
    - sudo apachectl (-k) stop
* Check the apache version
    - sudo apachectl -v
    - or apachectl -v
* (Mac) Apache: You don't have permission to access / on this server
    ``` bash
        <Directory "/Users/andy/Sites/">
        AllowOverride All
        Options Indexes MultiViews FollowSymLinks
        Require all granted
        </Directory>
    ```

### Configure PHP Server

1. Search httpd.conf
    ``` bash
    cd /etc/apache2
    //sudo cp httpd.conf httpd.conf.bak
    sudo vim httpd.conf
    ```
2. Configure httpd.conf
    ``` bash
    // Change the DocumentRoot "/Library/WebServer/Documents"
    DocumentRoot "/Users/andy/Sites"
    // Change the <Directory "/Library/WebServer/Documents">
    <Directory "/Users/andy/Sites">
    ```
3. Find php
    ``` bash
    #LoadModule php5_module libexec/apache2/libphp5.so
    drop "#"
    ```
4. cd /etc/
    ``` bash
    sudo cp php.ini.default php.ini
    ```
5. Create index.php in /Users/andy/Sites", and type in
    ``` bash
    <?php phpinfo(); ?>    // <?php  without blank space
    ```
6. sudo apachectl restart
7. Scan localhost in website
    ``` bash
    http://loaclhost/index.php
    ```
