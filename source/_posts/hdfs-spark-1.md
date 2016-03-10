---
title: HDFS configure with Zookeeper (01)
date: 2016-01-12 15:14:59
categories: cloud-tech
tags: [Spark, Hadoop]
---

Construct the platform for Big Data project

## Build HardDisk RAID0

This paragraph describes the HDFS configure progress on Azure Cloud Server. You need have a azure account to login in and purchase the platform you will perform on. Here is my platform construction details to share with you.

<!--more-->


- Unbuntu 14.0 LTS


### lvm2
- command [--lvcreate](http://linux.about.com/library/cmd/blcmdl8_lvcreate.htm)
- Configure the raid 0
  - Login in the url: http://manage.windowsazure.com
  - Attached/Added 4 empty disks
- Create logical volume ( striped disks)

``` bash
            $ sudo apt-get update
            $ sudo apt-get install lvm2
            // find the disk, using dmesg | grep SCSI
            #  grep SCSI /var/log/dmesg
            $ sudo fdisk /dev/sdc  -> n,p,1, enter, enter, p, w
            $ sudo fdisk /dev/sdd  -> n,p,1, enter, enter, p, w
            $ sudo fdisk /dev/sde  -> n,p,1, enter, enter, p, w
            $ sudo fdisk /dev/sdf  -> n,p,1, enter, enter, p, w
            $ sudo pvcreate /dev/sdc1
            $ sudo pvcreate /dev/sdd1
            $ sudo pvcreate /dev/sde1
            $ sudo pvcreate /dev/sdf1
            //  sudo pvscan
            // merge all the drives together
            $ sudo vgcreate datadrive /dev/sdc1 /dev/sdd1 /dev/sde1 /dev/sdf1
            // sudo vgdisplay
            $ sudo lvcreate -l 100%FREE datadrive -n example-log -I 64 -i 4
            // sudo lvdisplay
            //  sudo lvcreate -i <number of physical volumes to stripe> -I (大写i)<size of stripe in killobytes> -L <size in megabytes>M <name of virtual group>
            $ sudo mkfs -t ext4 /dev/datadrive/example-log
            $ sudo mkdir /datasource
            $ sudo mount /dev/datadrive/example-log /datasource
```
- Automatic Mount configure ([fstab](https://wiki.archlinux.org/index.php/Fstab))

``` bash
sudo blkid
sudo vim /etc/fstab
/dev/mapper/datadrive-example--datalog: UUID="b2e83db3-41b9-4f78-8b1f-f196bb9b9b6f" TYPE="ext4"

UUID=b2e83db3-41b9-4f78-8b1f-f196bb9b9b6f /datadrive ext4 defaults 0 0
// An example from mine (bolded GUID is from my blkid, be sure to change it!): UUID=63ab0827-4698-427a-818a-279b18886757 /mnt/datadrive ext3 defaults 0 0
// $ sudo chroot /target
// Test disk write speed
```
``` bahs
$ time sh -c "sudo dd if=/dev/zero of=/datasource/temp bs=4k count=2000000 && sync"
```



## HDFS

- Login in http://manage.windowsazure.com, build the server on Azure
  - Set the host: example-hadoop.cloudapp.net
  - Create VM (Ubuntu 14 LTS), with 8 cores and 14GB RAM
    - example-data01, example-data02, example-data03, example-data04
  - [Hadoop FAQ](http://wiki.apache.org/hadoop/FAQ)
- ssh-keygen

``` bash
admin@example-data01 $ cd .ssh
$ ssh-keygen -t rsa  -> enter, enter, enter
$ cat id_rsa.pub >> authorized_keys
// test the key: $ ssh localhost  -> successfully
$ scp authorized_keys admin@example-data02:~/.ssh/
$ scp authorized_keys admin@example-data03:~/.ssh/
// test $ ssh example-data02
```

Download the Hadoop Binary on each node
``` bash
$ Install java on ubuntu
$ wget http://mirrors.cnnic.cn/apache/hadoop/common/stable/hadoop-2.7.1.tar.gz
$ tar xvf hadoop-2.7.1.tar.gz
$ mv hadoop-2.7.1 hadoop
```
