---
title: Java Multi-thread
date: 2016-03-13 22:37:52
categories: cloud-tech
tags: [Java]
---


Java multi-threading implementation ways mainly contain three:

+ Inherit the "Thread class"
+ Realized the "Runnable interface"
+ ExecutorService, Callable, Future
    - The former two ways have no return value after the thread execution, only the last one is with a return value.

### Thread
``` bash
public class MyThread extends Thread{
    public void run(){
      # do something
    }
}
```

<!-- more -->
``` bash
MyThread myThread = new MyThread();
```

### Runnable

``` bash
public class MyThread extends OtherClass implements Runnable{
// public class MyThread implements Runnable{
    public void run(){
      # do something
    }
}
```

``` bash
MyThread myThread = new MyThread();
Thread thread = new Thread(myThread);
thread.start();
```

### ExecutorService, Callable, Future

``` bash
int taskSize = 4;
// init to create a thread pool
ExecutorService pool = Executors.newFixedThreadPool(taskSize);
// create multi-tasks with a return value
List<Future> list = new ArrayList<Future>();
# ...
Callable ca = new MyCallable(taskSize);
// implement the Obj of Future
Future f = pool.submit(c);
list.add(f);
# ...
pool.shutdown();
// obtain the results
for (Future f: list){
    f.get().toString();
}

// MyCallable class
class MyCallable implements Callable<Object>{}
```

* Statements

// public static ExecutorService newFixedThreadPool(int nThreads)
// create fixed number of threads
// public static ExecutorService newCachedThreadPool()    
// * create scheduled pool, which can instead of the Timer class
// public static ScheduledExecutorService newScheduledThreadPool(int corePoolSize)
* [Reference](http://blog.csdn.net/aboy123/article/details/38307539)
