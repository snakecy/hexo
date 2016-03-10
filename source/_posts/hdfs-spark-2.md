---
title: HDFS configure with Zookeeper (02)
date: 2016-01-12 15:15:04
categories: cloud-tech
tags: [Spark, Hadoop]
---

Construct the platform for Big Data project

## Configure Zookeeper
- on each server, configure the java environment
``` bash
$ tar -zxvf zookeeper-3.4.6.tar.gz
$ mv zookeeper-3.4.6 zookeeper
$ cd zookeeper/conf
$ cp zoo_sample.cfg zoo.cfg
$ vi zoo.cfg
```

<!--more-->

| Server role     | 	example-data01（namenode1）| 	example-data02（namenode2）|  	example-data03（datanode1）	 |  example-data04（datanode2）|
| ---------------- | : ---------------------------------: | : ---------------------------------: | : ---------------------------------: | ---------------------------------: |
|  NameNode	  |     YES	   |     YES      |     NO       |   NO      |
|   DataNode    |   NO	      |       NO	   |       YES	  |   YES    |
| JournalNode | 	YES	   |   YES  |   	YES  |	NO  |
| ZooKeeper  |	YES  | 	YES  |	YES  |   	NO    |
|     ZKFC	    |   YES   |  	YES   |  	NO	   |   NO   |

- 8080 => example-data01:50070
- 8000 => example-data02:50070

### Hadoop configure
  - hosts
``` bash
*.*.*.*  example-data01
*.*.*.*  example-data02
*.*.*.*  example-data03
*.*.*.*  example-data04
```

  - $ vi ~/.bashrc
``` bash
# vim ~/.bashrc
export ZOO_HOME=/home/admin/zookeeper
export ZOO_LOG_DIR=/home/admin/zookeeper/logs
export PATH=$PATH:$ZOO_HOME/bin
# source ~/.bashrc
```
  - $ mkdir -p /data/hadoop/zookeeper/{data,logs}
  - $ cp ~/zookeeper/conf/zoo_sample.cfg ~/zookeeper/conf/zoo.cfg
  - $ vim zoo.cfg
  ``` bash
# vim /home/admin/zookeeper/conf/zoo.cfg
tickTime=2000
initLimit=10
syncLimit=5
dataDir=/home/admin/zookeeper/data
clientPort=2181
server.1=example-data01:2888:3888
server.2=example-data02:2888:3888
server.3=example-data03:2888:3888
```
  - $ create myid in zkData file   -> echo 1 > myid
  - $ scp -r zookeeper/* admin@example-data02:~  -> echo 2 > myid
  - $ scp -r zookeeper/* admin@example-data03:~   -> echo 3 > myid
  - $ cp ~/zookeeper to each server ( example-data02, example-data03)
  - on example-data01
    - check status by using  
    - $  ./bin/zkCli.sh -server example-data01:2181
    - $  or ./bin/zkCli.sh -server example-data02:2181
    - exit by using "quit"
  - on each node to perform
    - ./bin/zkServer.sh start
    - ./bin/zkServer.sh status

####  Configure

    - example-data01(Namenode) example-data02(Sec-namenode) example-data03(datanode)  example-data04 (datanode)

#### On example-data01

* Step 1:

  - vim ~/.bashrc ( then copy the ~/.bashrc to example-data02( namenode) & example-data03 (datanode)

``` bash
# java configure
export JAVA_HOME=/usr/lib/jvm/java-8-oracle
export PATH=$JAVA_HOME/bin:$PATH
export CLASSPATH=.:$CLASSPATH:$JAVA_HOME/lib:$JAVA_HOME/jre/lib

# hadoop configure
export HADOOP_HOME=/home/admin/hadoop
export PATH=$HADOOP_HOME/bin:$PATH

export HADOOP_CONF_DIR=$HADOOP_HOME/etc/hadoop

#zookeeper configure

export ZOO_HOME=/home/admin/zookeeper
export PATH=$PATH:$ZOO_HOME/bin
export ZOO_LOG_DIR=/home/admin/zookeeper/logs

#
export HADOOP_COMMON_LIB_NATIVE_DIR=$HADOOP_HOME/lib/native
export HADOOP_OPTS="-Djava.library.path=$HADOOP_HOME/lib/native"
export HADOOP_PID_DIR=/home/admin/hadoop/pids
export HADOOP_COMMON_HOME=$HADOOP_HOME
export HADOOP_HDFS_HOME=$HADOOP_HOME

export PATH=$HADOOP_HOME/sbin:$PATH     
```

* Step 2:

``` bash
$ mkdir -p /home/admin/hadoop/{pids,storage}
$ mkdir -p /home/admin/hadoop/storage/{hdfs,tmp,journal}
$ mkdir -p /home/admin/hadoop/storage/hdfs/{name,data}
in example-data03 & example-data04
$ mkdir -p /datadriver/hdfs/data
$ sudo chown admin /datadriver/hdfs/data/
```

* Step 3:

> configure the core-site.xml, hadoop-env.sh, hdfs-site.xml

- configure core-site.xml

``` bash
<configuration>
        <property>
                <name>fs.defaultFS</name>
                <value>hdfs://masters</value>
        </property>
        <property>
                <name>hadoop.tmp.dir</name>
                <value>file:/home/admin/hadoop/storage/tmp</value>
        </property>
        <property>
                <name>ha.zookeeper.quorum</name>
                <value>example-data01:2181,example-data02:2181,example-data03:2181</value>
        </property>
        <property>
                <name>hadoop.native.lib</name>
                <value>true</value>
        </property>
</configuration>
configure  hdfs-site.xml
<configuration>
        <property>
                <name>dfs.nameservices</name>
                <value>masters</value>
        </property>
        <property>
                <name>dfs.ha.namenodes.masters</name>
                <value>nn1,nn2</value>
        </property>
        <property>
                <name>dfs.namenode.name.dir</name>
                <value>file:///home/admin/hadoop/storage/hdfs/name</value>
        </property>
        <property>
                <name>dfs.datanode.data.dir</name>
//                <value>file:/home/admin/hadoop/storage/hdfs/data</value>
                <value>file:///datadriver/hdfs/data</value>
        </property>
        <property>
                <name>dfs.replication</name>
                <value>2</value>
        </property>

        <property>
                <name>dfs.webhdfs.enabled</name>
                <value>true</value>
        </property>
        <property>
                <name>dfs.namenode.rpc-address.masters.nn1</name>
                <value>example-data01:9000</value>
        </property>
        <property>
                <name>dfs.namenode.http-address.masters.nn1</name>
                <value>example-data01:50070</value>
        </property>
        <property>
                <name>dfs.namenode.rpc-address.masters.nn2</name>
                <value>example-data02:9000</value>
        </property>
        <property>
                <name>dfs.namenode.http-address.masters.nn2</name>
                <value>example-data02:50070</value>
        </property>
        <property>
                <name>dfs.namenode.shared.edits.dir</name>
         <value>qjournal://example-data01:8485;example-data02:8485;example-data03:8485/masters</value>
        </property>
        <property>
                <name>dfs.journalnode.edits.dir</name>
                <value>/home/admin/hadoop/storage/journal</value>
        </property>
        <property>
                <name>dfs.ha.fencing.methods</name>
                <value>sshfence(hdfs)
                shell(/bin/true)</value>
        </property>
        <property>
                <name>dfs.ha.fencing.ssh.private-key-files</name>
                <value>/home/admin/.ssh/id_rsa</value>
        </property>
        <property>
                <name>dfs.ha.fencing.ssh.connect-timeout</name>
                <value>30000</value>
        </property>
        <property>
                <name>dfs.ha.automatic-failover.enabled</name>
                <value>true</value>
        </property>
        <property>
                <name>dfs.client.failover.proxy.provider.masters</name>
                <value>org.apache.hadoop.hdfs.server.namenode.ha.ConfiguredFailoverProxyProvider</value>
        </property>
</configuration>
```


- configure hadoop-env.sh

``` bash
export JAVA_HOME=/usr/lib/jvm/java-8-oracle
```

- configure slaves

``` bash
example-data03
example-data04
```

* Step 4:

> scp hadoop to each node ( example-data02, example-data03, example-data04)

* Step 5:

> Setup the  HDFS Cluster with ZooKeeper Using Demo (example)

  - on the namenode1 (example-data01)
  ``` bash
  $ hdfs zkfc -formatZK
  ```
  - on each zookeeper node

  ``` bash
  $ hadoop-daemon.sh start journalnode
  // $ ./sbin/hadoop-daemons.sh --hostnames 'example-data01 example-data02 example-data03' start journalnode  // this command is used to start the journalnode of zookeeper
  ```

  - on the namenode1 (example-data01)
  ``` bash
  $ hdfs namenode -format
  ```

  - on the namenode1 (example-data01)
  ``` bash
  $ ./sbin/hadoop-daemon.sh start namenode
  ```

  - on namenode2 (example-data02)
  ``` bash
  $ hdfs namenode -bootstrapStandby
  ```
  - on namenode2 (example-data02)
  ``` bash
  $ ./sbin/hadoop-daemon.sh start namenode
  ```

  - on the two namenode (namenode1, namenode2)
  ``` bash
  $ ./sbin/hadoop-daemon.sh start zkfc
  ```

  - on the all datanode (datanode1, datanode2)
  ``` bash
  $ ./sbin/hadoop-daemon.sh start datanode
  ```

  - still now, we can see the following name on namenode1 (example-data01)
  > QuorumPeerMain, NameNode, DFSZKFailoverController(basically), JournalNode

* Step 6: Testing the HDFS's  function
  -
``` bash
#  login on web
example-data01: namenode (active)  => example-data01:9000
website: example-hadoop.cloudapp.net:8080
example-data02: namenode (standby)  => example-data02:9000
website: example-hadoop.cloudapp.net:8000
# $ hadoop-daemon.sh start namenode
```

* Step 7: Import , excute on namenode1 (example-data01)
  - Before Starting HDFS , Formating the zookeeper
  ``` bash
  $ hdfs zkfc -formatZK
  Start the HDFS  --> $ cd /home/admin/hadoop && sbin/start-dfs.sh
  Stop the HDFS  --> $ cd /home/admin/hadoop && sbin/stop-dfs.sh
  $ start-dfs.sh
  ```

  - check the status on two namenode
  ``` bash
  $ hdfs haadmin -getServiceState nn1 --> active
  $ hdfs haadmin -getServiceState nn2 --> standby
  ```

  - when the stop-dfs.sh turn to [error](http://taoo.iteye.com/blog/1730406)
  ``` bash
  $ vi ~/.bashrc
  export HADOOP_PID_DIR=/home/hadoop/pids
  ```

* hdfs dfsadmin -report

### [Spark on Yarn Reference](http://wuchong.me/blog/2015/04/04/spark-on-yarn-cluster-deploy/)

configure additional two file
yarn-site.xml & maperd-site.xml
