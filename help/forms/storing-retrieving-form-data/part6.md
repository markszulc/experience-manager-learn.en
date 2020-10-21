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
>* MYSQL Database

To test this capability on your AEM Forms instance, please follow the following steps

* Download and unzip the [tutorial assets](assets/store-retrieve-form-data.zip) on to your local system
* Deploy and start the techmarketingdemos.jar and mysqldriver.jar bundles using [Felix web console](http://localhost:4502/system/console/configMgr)
* Import the aemformstutorial.sql using MYSQL Workbench. This will create the necessary schema and tables in your database for this tutorial to work.
* Import StoreAndRetrieve.zip using [AEM package manager.](http://localhost:4502/crx/packmgr/index.jsp) This package contains the Adaptive Form template, page component client lib, and sample adaptive form and data source configuration. 
* Login to [configMgr.](http://localhost:4502/system/console/configMgr) Search for "Apache Sling Connection Pooled DataSource. Open the data source entry associated with aemformstutorial and enter the username and password specific to your database instance.
* Open the [Adaptive Form](http://localhost:4502/content/dam/formsanddocuments/demostoreandretrieveformdata/jcr:content?wcmmode=disabled)
* Fill in some details and click on the "Save And Continue Later" button
* You should get back a URL with a GUID in it.
* Copy the URL and paste it in a new browser tab. **Make sure there are no empty space at the end of the URL**
* Adaptive Form should get populated with the data from the previous step
