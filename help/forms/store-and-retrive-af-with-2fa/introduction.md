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

# Storing and Retrieving Adaptive Form Data with 2FA

This tutorial will walk you through the steps involved in saving and retrieving Adaptive Form Data with attachments using 2FA. This tutorial used MySQL database to store Adaptive Form data. Database of your choice can be used to store the data as long as you have deployed the database specific drivers in AEM. At a high-level, the following steps are needed to achieve the use case:

* Use the GuideBridge API get access to the Adaptive Form data

* Make a POST call to a servlet. This servlet stores the data in the database. The stored data is associated with a GUID.

* When you want to populate the Adaptive Form with the stored data, you retrieve the data associated with the GUID and populate the Adaptive Form using the **request.setAttribute** method.

## Demonstration of the use case

>[!VIDEO](https://video.tv.adobe.com/v/327122?quality=9&learn=on)
