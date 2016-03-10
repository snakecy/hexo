---
title: Json parsered by Java
date: 2016-01-13 01:26:05
categories: open-source
tags: [Json, Java, Eclipse]
---

Describe how to parser Json flows in (eclipse)  Java, also in Scala

## Json in Java

Json-lib must contain the jars blowing ( versions not limited)

- [Java-org-json]( http://www.studytrails.com/java/json/java-org-json.jsp)

- Json-lib
``` bash
commons-beanutils-1.7.0.jar  or commons-beanutils-1.9.2.jar
commons-collections-3.1.jar  or commons-collections-3.2.1.jar
commons-lang-2.5.jar  or commons-lang-2.6.jar
commons-logging-1.1.1.jar  or commons-logging-1.2.jar
ezmorph-1.0.3.jar  or ezmorph-1.0.6.jar
json-lib-2.2.2-jdk15.jar  or json-lib-2.4-jdk15.jar
```

<!--more-->

- [Json-smart](http://www.cnblogs.com/zhenjing/p/json-smart.html)
  - Compare with each json jar package [compare](https://code.google.com/p/json-smart/wiki/FeaturesTests)

- simple-json
- org.json

- example
  - http://crunchify.com/how-to-write-json-object-to-file-in-java/
  - http://crunchify.com/how-to-read-json-object-from-file-in-java/

``` bash
# reference:
> json格式如下：{"response":{"data":[{"address":"南京市游乐园","province":"江苏","district":"玄武区","city":"南京"}]},"status":"ok"}
Result： 江苏 南京 玄武区 南京市游乐园
﻿
JSONObject dataJson=new JSONObject("Json data");
JSONObject response=dataJson.getJSONObject("response");
JSONArray data=response.getJSONArray("data");
JSONObject info=data.getJSONObject(0);
String province=info.getString("province");
String city=info.getString("city");
String district=info.getString("district");
String address=info.getString("address");
System.out.println(province+city+district+address);
```
