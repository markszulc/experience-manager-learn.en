---
title: Deploy the sample
description: Get use case running on your local AEM Forms instance
feature: adaptive-forms
topics: development
audience: developer
doc-type: tutorial
activity: implement
version: 6.3,6.4,6.5
---


# Deploy the sample

To get this use case working on your system, please follow the following instructions

>[!NOTE]
It is assumed that you are running AEM Forms on port 4502


## Create database

This sample uses MySql database to store the adaptive form data. You will need to create the [database schema by importing the schema file](assets/data-base-schema.sql) into MySql workbench. 

## Create datasource

You need to create a datasource called StoreAndRetrieveAfData. This is the name that the code in the OSGi bundle uses

## Create Form Data Model

Form Data Model needs to be created based on this datasource. This form data model is used to fetch the mobile phone number associated with the application id. The form data model can be [downloaded from here](assets/2-Factor-Authentication-DataSource-and-FDM.zip)

## Create developer account with nexmo

Create a developer account with Nexmo for sending and verifying OTP codes.Make a note of the API Key and API Secret Key. The data source and form data model have already been created for you against this service and are included with the assets mentioned in the previous step.

## Deploy the following OSGi bundles

Deploy the bundle which has the [code to store and fetch data from database](assets/FetchPartiallyCompletedForm.PartiallyCompletedForm.core-1.0-SNAPSHOT.jar)
Deploy the [DevelopingWithServiceUser Bundle](https://docs.adobe.com/content/help/en/experience-manager-learn/forms/assets/common-osgi-bundles/DevelopingWithServiceUser.jar). 

## Deploy the client library

The sample uses 2 client libraries. Import these [client libraries](assets/client-libraries.zip) into AEM.

## Import the custom adaptive form template

The sample forms used in this demo are based on a custom template. Import the [custom template into AEM](assets/custom-template-with-page-component.zip)

## Import the sample adaptive forms

The 2 forms that make up this sample need to be imported into AEM. The sample forms can be [downloaded from here](assets/sample-forms.zip)

Open the [MyAccountForm](http://localhost:4502/editor.html/content/forms/af/myaccountform.html) in edit mode. Specify the API Key and API Secret values in the appropriate fields in the adaptive form

## Test the solution

Preview the [StoreAFWithAttachments](http://localhost:4502/content/dam/formsanddocuments/storeafwithattachments/jcr:content?wcmmode=disabled)
Enter your mobile number including the country code ,fill in your user details and add some attachments. Click the "Save And Exit" button to save the adaptive form and its attachments


## Demonstration of the use case

>[!VIDEO](https://video.tv.adobe.com/v/327122?quality=9&learn=on)

