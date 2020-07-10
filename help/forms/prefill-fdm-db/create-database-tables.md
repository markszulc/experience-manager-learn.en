---
title: Create database
description: Create database to be used by form data model
feature: adaptive-forms
topics: development
audience: developer
doc-type: article
activity: implement
version: 6.4,6.5
kt: 5811
thumbnail: kt-5811.jpg
---

# Create Database Tables

Form data model can be based on RDBMS, RESTfull, SOAP or OData sources. This course's focus is on pre-filing Adaptive Form using form data model backed by RDBMS data source. For the purpose of this tutorial MYSQL database was used. We created the following two tables to demonstrate the use case

* **newhire** table - This table stores the newhire information

  ![newhire](assets/newhire-table.png)


* **beneficiaries** table - This stores newhire beneficiaries

  ![beneficiaries](assets/beneficiaries-table.png)

You can import the [sql file](assets/db-schema.sql) using MySQL workbench to create to tables with some sample data.