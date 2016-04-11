---
title: MySQL Notes Installation (01)
date: 2016-03-11 00:25:23
categories: cloud-tech
tags: [MySQL]
---


### MySQL Installation on Mac
> In the newest version of MySQL or later one, it has not need to install the startup item "MySQL_StartupItem.pkg", also use the default password as "root any more. After installed, Pop-up prompts a temporary password, as the message says:

``` bash
2016-03-08T15:35:58.686693Z 1 [Note] A temporary password is generated for root@localhost: E%*oVnN?d7sx
If you lose this password, please consult the section How to Reset the Root Password in the MySQL reference manual.
```

<!-- more -->
### Configure Env.
In terminal, type in “sudo vi /etc/bashrc”，then configure mysql and mysqladmin path in bash.

``` bash
#mysql
alias mysql='/usr/local/mysql/bin/mysql'
alias mysqladmin='/usr/local/mysql/bin/mysqladmin'
```
or in user's path, touch ~/.bash_profile
``` bash
MYSQL_HOME='usr/local/mysql/bin'
PATH=$PATH:$MYSQL_HOME
```

### Revise the default password
``` bash
mysqladmin -u root -p password
```

### Login in terminal
``` bash
mysql -u root -p
```
