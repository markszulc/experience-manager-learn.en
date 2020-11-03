---
title: Configure Data Source
description: Create DataSource instance for interacting with the database.
feature: adaptive-forms
topics: development
audience: developer
doc-type: tutorial
activity: implement
version: 6.3,6.4,6.5
thumbnail:
kt: 6541
thumbnail: 6541.jpg
---

# Configure Data Source

There are many ways with which AEM enables integration with external database. One of the most common & standard practice of database integration is by using Apache Sling Connection Pooled DataSource configuration properties through the [configMgr](http://localhost:4502/system/console/configMgr).
The first step is to download and deploy the appropriate [My SQL drivers](https://mvnrepository.com/artifact/mysql/mysql-connector-java) in AEM.
Then set the Sling Connection Pooled DataSource properties. These properties are specific to your database. The following screenshot shows the settings used for this tutorial. The database schema is provided to you as part of this tutorial assets.
![data-source](assets/data-source.JPG)

JDBC Driver Class: com.mysql.cj.jdbc.Driver

JDBC Connection URI:jdbc:mysql://localhost:3306/aemformstutorial

>[!NOTE]
>Please make sure you name your datasource aemformstutorial as this is the name used in the OSGi service


## Create database


The following database was used for the purpose of this use case. The database has one table called formdatawithattachments with the 4 columns as shown in the screen-shot below.
![data-base](assets/table-schema.JPG) 

* The column **afdata** will hold the adaptive form data.
* The column **attachmentsInfo** will hold the information about the form attachments.
* The columns **telephoneNumber** will hold the mobile number of the person filling out the form.

The [schema for this database can be downloaded from here](assets/data-base-schema.sql)