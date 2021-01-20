---
title: Troubleshoot Signing Multiple Documents Solution
description: Test and trouble shoot the solution
feature: adaptive-forms
topics: development
audience: developer
doc-type: tutorial
activity: implement
version: 6.4,6.5
kt: 6960
thumbnail: 6960.jpg
---

# Test and troubleshoot


## Preview the refinance form

The use case gets triggered when customer service agent fills and submits [refinance form](http://localhost:4502/content/dam/formsanddocuments/formsandsigndemo/refinanceform/jcr:content?wcmmode=disabled). 

The Sign Multiple Forms workflow gets triggers on this form submission and the customer gets an e-mail notification with a link to start the form filling and signing process.

## Fill out forms in the package

The customer is presented to fill and sign the first form in the package. On successful signing of the form, the customer can navigate to the next form in the package. Once all the forms are filled and signed the customer is presented with the "**AllDone**" form.

## Troubleshoot

### E-mail notification is not being generated

The E-mail notification are sent by Send Email component in the Sign Multiple Form workflow. If any of the steps in this workflow fail, the e-mail notification will be sent. Make sure the custom process step in the workflow is creating rows in your MySQL database. If the rows are being created then check your Day CQ Mail Service configuration settings

### The link in the e-mail notification not working

The links in the e-mail notifications are generated dynamically. If your AEM server is not running on localhost:4502, please provide the correct server name and port in the arguments of the Store Forms To Sign step of the Sign Multiple Forms workflow

### Not able to sign the form

This can happen if the form was not populated correctly by fetching the data from the data source. Check the stdout logs of your server. The fetchformdata.jsp writes out some useful messages to the stdout.

### Not able to navigate to the next form in the package

On successful signing of a form in the package, the Update Signature Status workflow is triggered. The first step in the workflow updates the signature status of the form in the database. Please check if the status for the form is updated from 0 to 1.

### Not seeing the AllDone form

When there are no more forms to sign in the package, the AllDone form is presented to the user.If you are not seeing the AllDone form, please check the URL used in line 33 of the GetNextFormToSign.js file which is part of the **getnextform** client lib. 











