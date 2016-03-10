---
title: ipinyou-database
date: 2016-03-10 20:35:08
categories: cloud-tech
tags: [R]
---

### iPinyou Reference

> **************************************
  Ipinyou database
Features = {IP,Region,City,Ad exchange,ad slot id,ad slot width, ad slot height,ad visiblility,ad slot format,advertiser id,user tags}
> **************************************

* RankSorce = CTR * BidPrice
  - [Advertising Calculating](http://sobuhu.com/ml/2013/01/25/r-ctr.html)

* Aim
  - Low-latency and scalale predictions as a service
  - Integrated approach leads to fresher, better predictions
  - Easy translation to production predictions
  - Eases Operational pain

<!--more-->

#### Experiment using R

* First //
  - [make-ipinyou-data](https://github.com/wnzhang/make-ipinyou-data)
  - Paper: Real-Time Bidding Benchmarking with iPinYou Dataset

* Second
  - [rtbcontrol](https://github.com/wnzhang/rtbcontrol)
  - Paper: Experiment Code for RTB Feedback Control Techniques

* Third
  - [rtbarbitrage](https://github.com/wnzhang/rtbarbitrage)
  - Paper: Statistical Arbitrage Mining for Display Advertising

* Fourth //
  - [optimal-rtb](https://github.com/wnzhang/optimal-rtb)
  - Paper: Optimal Real-Time Bidding for Display Advertising

* Fifth
  - [KDD2015wpp](https://github.com/wush978/KDD2015wpp)
  - Predicting Winning Price in Real Time Bidding with Censored Data

### Winning price steps
  - What features should be taken in
  - Considering of the Winning Rate
  - Combine Win Rate & Winning Price
    - [logistic factor solution]( http://blog.csdn.net/star_liux/article/details/39666737)
    - Paper reference
      - http://www.slideshare.net/WushWu/predicting-winning-price-in-real-time-bidding-with-censored-data
      - Programmatic buying bidding strategies with Win Rate and Winning Price Estimation in real time mobile advertising
  - Join bid_req, bid_resp and win_notice for Winning Rate/Winning Price Prediction

- Testing Winning Rate running by python (examples with ipinyou)
  - Example of CTR Using Python
    - http://www.dataguru.cn/thread-460417-1-1.html  
  - Example of CTR using R
    - http://f.dataguru.cn/thread-329637-1-1.html  
    - http://blog.csdn.net/yucan1001/article/details/23228053  

``` bash
#CRT_DATA.txt
0 20 0.294181968932 0.508158622733 0.182334278695 0.629420618229
0 68 0.1867187241 0.606174671096 0.0748709302071 0.806387550943
0 18 0.62087371082 0.497772456954 0.0321750684638 0.629224616618
1 90 0.521405561387 0.476048142961 0.134707792901 0.400062294097
0 75 0.0126899618353 0.507688693623 0.377923880332 0.998697036848
0 8 0.308646073229 0.930652495254 0.755735916926 0.0519441699996
0 64 0.444668888126 0.768001428418 0.501163712702 0.418327345087
0 79 0.842532595853 0.817052919537 0.0709486928253 0.552712019723
1 32 0.410650495262 0.164977576847 0.491438436479 0.886456782492
// first col is whether click, second is the number of impressions

ctr_data <- read.csv('CTR_DATA.txt',header = F, sep = " ")
head(ctr_data)
attach(ctr_data)
ctr_logr <- glm(cbind(V1,V2)~V3+V4+V5+V6,family=binomial(link="logit"))
record <- data.frame(V3=0.294181968932,V4=0.508158622733,V5=0.182334278695,V6=0.629420618229)
d <- predict(ctr_logr,newdata = record,type="response")
```
