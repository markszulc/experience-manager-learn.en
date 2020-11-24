---
title: Storing and Retrieving Form Data from MySQL Database
description: Multi-Part tutorial to walk you through the steps involved in storing and retrieving form data
feature: adaptive-forms
topics: development
audience: developer
doc-type: tutorial
activity: implement
version: 6.3,6.4,6.5
---
# Configure Data Source

There are many ways with which AEM enables integration with external database. One of the most common & standard practice of database integration is by using Apache Sling Connection Pooled DataSource configuration properties through the [configMgr](http://localhost:4502/system/console/configMgr).
The first step is to download and deploy the appropriate [My SQL drivers](https://mvnrepository.com/artifact/mysql/mysql-connector-java) in AEM.
Then set the Sling Connection Pooled DataSource properties. These properties are specific to your database. The following screenshot shows the settings used for this tutorial. The database schema is provided to you as part of this tutorial assets.
![data-source](assets/save-and-continue-data-source.PNG)

Database has one table called formdata with the 3 columns as shown in the screen-shot below
![data-base](assets/data-base-tables.PNG) 

The sql file to create the schema can be [downloaded from here](assets/form-data-db.sql). You will need to import this file using MySql workbench to create the schema and the table.

>![NOTE]
>Please make sure you name your datasource **SaveAndContinue**. The sample code uses the name to connect to the database

JDBC Driver Class: com.mysql.cj.jdbc.Driver
JDBC Connection URL: jdbc:mysql://localhost:3306/aemformstutorial?autoReconnect=true&useSSL=false&characterEncoding=utf8&useUnicode=true
