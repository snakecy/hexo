---
title: Install Python GUI spyder on Mac
date: 2016-01-11 00:22:08
categories: open-source
tags: [Python, Spyder, Mac]
---

Read more ......
<!--more-->

## Install Python

### Install Python 3.4.1 on Ubuntu

``` bash
sudo apt-get install libssl-dev openssl
wget https://www.python.org/ftp/python/3.4.1/Python-3.4.1.tgz
tar -xvf Python-3.4.1.tgz
cd Python-3.4.1/
./configure
make
sudo make install
> then run ./python in terminal
```

### Install Python 3.4.1 on Mac

Mac has installed the python 2.7, if you want to use the latest version,  go to the [Python](http://www.python.org/download/) website and download.


## Install the Python GUI on Mac

### Step 1, Intall the Python

### Step 2, Install the [Anaconda](http://www.continuum.io/downloads)

- Command-Line Install

``` bash
bash Anaconda2-2.4.1-MacOSX-x86_64.sh
```

### Step 3, Install [MacPorts](http://guide.macports.org/)

Make sure that you have installed the XCode on mac, which is the encession to install "spyder"
Also for the MacPorts install [reference](http://www.ccvita.com/434.html)


``` bash
curl -O https://distfiles.macports.org/MacPorts/MacPorts-2.3.3.tar.bz2
tar xf MacPorts-2.3.3.tar.bz2
```

Then, edit the /etc/profile file, add the following comand

``` bash
export PATH=/opt/local/bin:/opt/local/sbin:$PATH
```

For the first time to run:

``` bash
sudo port -v selfupdate
```

And if you update failed, you can re-run it with debug output, likes:

``` bash
sudo port -d selfupdate
```

### Step 4, install spyder

``` bash
$ sudo port install python27 // if python27 dose not installed, then install it before activate
$ sudo port select --set python python27  // set the default python
$ sudo port select --list python // available versions
$ sudo port -f activate python27
$ sudo port install py-spyder
```

﻿After long time waiting. Then, begin our python journey, run the spyder in the terminal

``` bash
$ spyder
```
