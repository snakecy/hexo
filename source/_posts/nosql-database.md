---
title: Install NoSQL Database
date: 2016-01-13 02:25:57
categories: open-source
tags: [NoSQL, Redis]
---

NoSQL database for a key-value DB Redis


* Quick Start [Redis](http://redis.io/topics/quickstart)

* use the key value DB (redis)
``` bash
sudo apt-get install redis-server
to test redis using: >> redis-cli   to enter
then : 127.0.0.1:6379> set test 1
> get test
```

* Or download the redis from website
``` bash
wget http://download.redis.io/releases/redis-3.0.2.tar.gz
```

<!--more-->


* Or download
``` bash
wget http://download.redis.io/redis-stable.tar.gz
tar xvzf redis-stable.tar.gz
cd redis-stable
make
```

* Update the redis-server
  - first way
  ``` bash
sudo add-apt-repository ppa:chris-lea/redis-server
sudo apt-get update
sudo apt-get install redis-server
```
  - another way to do this update
  ``` bash
sudo apt-get install -y python-software-properties
sudo add-apt-repository -y ppa:rwky/redis
sudo apt-get update
sudo apt-get install -y redis-server
```
