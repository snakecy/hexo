---
title: algorithm-Binary-Search-01
date: 2016-03-05 01:37:03
categories: Algorithm
tags: [JAVA]
---

[TOC]

## Binary Search（二分查找）

### Java实现二分查找
在一个有序的集合中查找元素，可以使用二分查找算法，也叫二分搜索。二分查找算法先比较位于集合中间位置的元素与键的大小，有三种情况（假设集合是从小到大排列的）：
1. 键小于中间位置的元素，则匹配元素必在左边（如果有的话），于是对左边的区域应用二分搜索。
2. 键等于中间位置的元素，所以元素找到。
3. 键大于中间位置的元素，则匹配元素必在右边（如果有的话），于是对右边的区域应用二分搜索。另外，当集合为空，则代表找不到。

<!--more-->

``` bash
import java.util.*;
public class BinarySearch {

    public static void main(String[] args) {
        ArrayList<Integer> a = new ArrayList<Integer>();
        addIntegerInSequence(a,1,10);
        print(a);
        int pos = binarySearch(a,10);
        if ( pos != -1 )
        {
            System.out.print("Element found: " + pos);
        }
    else
        {
            System.out.print("Element not found");
        }
    }

    /**
    * 二分查找法
    * @param a
    * @param value 待查找元素
    * @return
    */
    public static int binarySearch(ArrayList<Integer> a, int value)
    {
        int size = a.size();
        int low = 0 , high = size - 1;
        int mid;
        while (low <= high)
        {
            mid = (low + high) / 2;
            if ( a.get(mid) < value )
            {
                low = low + 1;
            }
        else if ( a.get(mid) > value )
            {
                high = high - 1;
            }
        else
            {
                return mid;
            }
        }
        return -1;
    }

    /**
    * 填充顺序元素到数组
    * @param a
    * @param begin 开始元素
    * @param size 大小
    */
    public static void addIntegerInSequence(ArrayList<Integer> a, int begin, int size)
    {
        for (int i = begin; i < begin + size; i++)
        {
            a.add(i);
        }
    }

    /**
    * 打印数组
    * @param a
    */
    public static void print(ArrayList<Integer> a)
    {
        Iterator<Integer> i = a.iterator();
        while (i.hasNext())
        {
            System.out.print(i.next() + " ");
        }
        System.out.println("");
    }

}

//JAVA 库中的二分查找使用非递归方式实现，返回结果与前面写的有所不同：找不到时返回的是负数，但不一定是-1
private static int binarySearch0(int[] a, int fromIndex, int toIndex,
int key) {
    int low = fromIndex;
    int high = toIndex - 1;

    while (low <= high) {
        int mid = (low + high) >>> 1;
        int midVal = a[mid];

        if (midVal < key)
        low = mid + 1;
    else if (midVal > key)
        high = mid - 1;
    else
        return mid; // key found
    }
    return -(low + 1);  // key not found.
}

```
