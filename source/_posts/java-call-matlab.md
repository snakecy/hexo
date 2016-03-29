---
title: java-call-matlab
date: 2016-03-06 01:49:37
categories: open-source
tags: [JAVA, MATLAB]
---

[TOC]

###  环境准备

    + Eclipse & Matlab

1. JAVA_HOME

    - i. JAVA_HOME (JDK的安装位置 如C:\Program Files\Java\jdk1.5.0)

        - 设置后，重启matlab才能有效.

        - 用getenv JAVA_HOME，在Matlab的命令窗口中试验，看看得到的返回值正确方可说明其对Matlab生效了。

<!--more-->

    - ii. Classpath
        - 添加 matlabInstallRoot\toolbox\javabuilder\jar\javabuilder.jar
    - iii. Path
        - 添加%JAVA_HOME%/bin/javac

2. build matlab m-file into a jar
    - a) 在matlab的command窗口，输入 deploytool。会在右侧弹出一个新窗口（Deployment Tool）。
    - b) 在Deployment Tool中，点击new按钮，选择 Matlab Builder for Java 与 Java Package。新建一个工程名字，如flying.prj 。对该工程，要进入其设置对话框，设置其compiler为“matlabInstallRoot\toolbox\javabuilder\jar\javabuilder.jar ”。
    - c) In the Deployment Tool pane, ensure that the Generate Verbose Output option is selected
    - d) 将欲被java调用的.m 文件，（如mydraw.m，其中包括两个参数(x,y)），从Matlab整个界面的左侧工作目录面板，拖拽到Deployment Tool中的新建的类下面的class文件夹下。
    - e) 点击build 按钮，则会在matlab的当前目录下，生成以一个与工程同名的(如flying)文件夹。

3. 编写java函数，准备调用刚刚生成好的flying.jar中的方法。
    - a) 在java工程Test属性的BuildPath中，添加两个jar包：
        - i. matlabroot\toolbox\javabuilder\jar\javabuilder.jar
        - ii. TestDirectory\ flying.jar
    - b) 编写函数示例如下

    ``` bash
    package test;
    import com.mathworks.toolbox.javabuilder.*;
    import flrying.*;
    public class testMatlabClass {
        public static void main(String[] args) {
            // TODO Auto-generated method stub
            try {
                System.out.println("Begin");
                flyingclass flyingDraw=new flyingclass();
                System.out.println("Middle");
                flyingDraw.mydraw(7,2);
                System.out.println("Here");
            }catch (Exception e){System.out.println(e);}
        }
    }
    ```

    - d) 如果不能正常运行，可以考虑在classpath中，加入flying.jar所在的位置。
4. 详细
    - a) 参见matlab的帮助文件
    - b) www.simwe.com/forum/archiver/tid-747229.html
    - c) 数据类型相关
        - i. Java的数值型数组，可以直接作为输入参数传递到.m文件上。
        如：mydraw(x,y)，可以画x=[1 2 3 4] ,y=[3.3 -5 6 10.2] 这样的线图。Java调用该方法时候，如果传递的参数是整型或者实数型数组，则直接可成功。

    ``` bash
    如 java中 :
    int[] a=new int[4];
    int[] b=new int[4];
    // 给 a,b 赋值…//
    //调用
    flyingclass flyingDraw=new flyingclass();
    flyingDraw.mydraw(a,b);
    //注意：a,b最好所有有索引的位置都有值，否则如果没有充分赋值曲线可能会最终折回(0,0)点。
    ```
5. Matlab程序(.m文件)的修改
    - a) 找到TestDirectory\ flying.jar所在的位置（因为按照上述步骤的话，.m源文件就在该位置附近）。这个位置，从Eclipse的Package Explore可以用看到。
    - b) 直接修改欲改动的.m文件
    - c) 打开Matlab, 在Command输入 Deploytool, 在新打开的部署面板中，“打开”该m文件所在的工程，如 flying.prj。
    - d) 选中相应工程下Class文件夹下的.m文件，点击工具栏的Build按钮。
    - e) 则相应源文件被重新编译。如果按照前面步骤添加的jar包，则编译后新生成的jar包自动替换掉原有的jar。又由于这个jar的位置，已经作为BuildPath告诉了java的相应工程，因此Java端不需要做任何调整，即可正确调用到新修改了内容的matlab方法。
