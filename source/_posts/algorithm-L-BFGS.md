---
title: L-BFGS Algorithm (01)
date: 2016-03-15 01:56:22
categories: algorithm
tags: [Java]
---

### 1. Introduction of  L-BFGS

> L-BFGS(Limited-Memory BFGS)是BFGS算法在受限内存时的一种近似算法，BFGS是数学优化中一种无约束最优化算法。[links](http://mlworks.cn/posts/introduction-to-l-bfgs/
)

### 2. Optimization algorithm - BFGS
> BGFS是一种准牛顿算法, 所谓的"准"是指牛顿算法会使用Hessian矩阵来进行优化, 但是直接计算Hessian矩阵比较麻烦, 所以很多算法会使用近似的Hessian, 这些算法就称作准牛顿算法(Quasi Newton Algorithm).

The Details description can refer to the [notes](http://www.cnblogs.com/kemaswill/p/3352898.html)
<!-- more -->
