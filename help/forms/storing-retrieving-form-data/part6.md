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

# Deploy this on your server

>[!NOTE]
>
>The following are required to get this running on your system
>
>* AEM Forms(version 6.3 or above)
>* MySql Database

To test this capability on your AEM Forms instance, please follow the following steps

* Download and deploy the [MySql Driver Jar](assets/mysqldriver.jar) files using the [felix web console](http://localhost:4502/system/console/bundles)
* Download and deploy the [OSGi bundle](assets/SaveAndContinue.SaveAndContinue.core-1.0-SNAPSHOT.jar) using the [felix web console](http://localhost:4502/system/console/bundles)
* Download and install the [package containing client lib, adaptive form template, and the custom page component](assets/store-and-fetch-af-with-data.zip) using the [package manager](http://localhost:4502/crx/packmgr/index.jsp)
* Import the [sample Adaptive form](assets/sample-adaptive-form.zip) using the [FormsAndDocuments interface](http://localhost:4502/aem/forms.html/content/dam/formsanddocuments)

* Import the [form-data-db.sql](assets/form-data-db.sql) using MySql Workbench. This will create the necessary schema and tables in your database for this tutorial to work.
* Login to [configMgr.](http://localhost:4502/system/console/configMgr) Search for "Apache Sling Connection Pooled DataSource. Create a new Apache Sling Connection Pooled Datasource entry called **SaveAndContinue** using the following properties:

Property Name| Value
------------------------|---------------------------------------
Datasource Name| SaveAndContinue
JDBC Driver Class| com.mysql.cj.jdbc.Driver
JDBC connection uri| jdbc:mysql://localhost:3306/aemformstutorial


* Open the [Adaptive Form](http://localhost:4502/content/dam/formsanddocuments/demostoreandretrieveformdata/jcr:content?wcmmode=disabled)
* Fill in some details and click on the "Save And Continue Later" button.
* You should get back a URL with a GUID in it.
* Copy the URL and paste it in a new browser tab. **Make sure there are no empty space at the end of the URL.**
* Adaptive Form should get populated with the data from the previous step.
