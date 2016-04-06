---
title: Build Blog with Github and Hexo
date: 2016-01-09
categories: web-building
tags: [Hexo + Github, Mac]
---

Beginning the blog journey of Hexo & Gituhub

Welcome to [Hexo](https://hexo.io/)! This is your very first post. Check [documentation](https://hexo.io/docs/) for more info. If you get any problems when using Hexo, you can find the answer in [troubleshooting](https://hexo.io/docs/troubleshooting.html) or you can ask me on [GitHub](https://github.com/hexojs/hexo/issues).


## Quick Start

### Create a new post

``` bash
$ hexo new "My New Post"
```

More info: [Writing](https://hexo.io/docs/writing.html)

### Run server

``` bash
$ hexo server
```

More info: [Server](https://hexo.io/docs/server.html)

### Generate static files

``` bash
$ hexo generate
```

More info: [Generating](https://hexo.io/docs/generating.html)

### Deploy to remote sites

``` bash
$ hexo deploy
```

More info: [Deployment](https://hexo.io/docs/deployment.html)




## Create a domain of yourself bolg website

### Step 1

Register on [Godaddy](https://support.dnspod.cn/Kb/showarticle/tsid/42/),  If possible, also should to use CDN on [DNSPod](https://www.dnspod.cn/)

### Step 2

Create Personal Rep. on github, and name the Rep. is <snakecy.github.io>, add the README.md file to describe the Rep.

### Step 3

Using ping to get github pages ip  < 103.245.222.133>

### Step 4

On Mac OS, the necessary thing is to download Xcode CommandLine Tools in AppStore, and then
<!-- download Xcode and install, then xcode-select --install -->
``` bash
$ sudo xcode-select -switch /Applications/Xcode.app/Contents/Developer
```

### Step 5

Install jekyll (optional)
``` bash
$ sudo gem update --system
$ sudo gem install jekyll
```

Install Hexo (use)
- Install Xcode and [Node.js](https://nodejs.org/en/)
- Install Hexo on mac

``` bash
$ sudo npm install hexo-cli -g
$ mkdir blog
$ cd blog
$ hexo init & npm install
```

Configure the homepage by
- [jianshu]( http://www.jianshu.com/p/73779eacb494)
- [iissnan]( http://theme-next.iissnan.com)


## Update
### Update hexo
``` bash
$ npm update -g hexo
```

### Update themes
``` bash
$ cd themes/next
$ git pull
```

### Update plugins
``` bash
$ npm update
```  

### Add plugins

``` bash
npm install hexo-generator-index --save
npm install hexo-generator-archive --save
npm install hexo-generator-category --save
npm install hexo-generator-tag --save
npm install hexo-server --save
npm install hexo-deployer-git --save
npm install hexo-deployer-heroku --save
npm install hexo-deployer-rsync --save
npm install hexo-deployer-openshift --save
npm install hexo-renderer-marked@0.2.7 --save
npm install hexo-renderer-stylus@0.3.0 --save
npm install hexo-generator-feed@1.0.3 --save
npm install hexo-generator-sitemap@1.0.1 --save
```
