---
title: Using API to generate Document of Record with AEM Forms
seo-title: Using API to generate Document of Record with AEM Forms
description: Generate Document Of Record (DOR) programmatically
seo-description: Using API to generate Document of Record with AEM Forms
feature: adaptive-forms
topics: development
audience: developer
doc-type: article
activity: implement
version: 6.4,6.5
uuid: 94ac3b13-01b4-4198-af81-e5609c80324c
discoiquuid: ba91d9df-dc61-47d8-8e0a-e3f66cae6a87
---

# Using API to generate Document of Record in AEM Forms {#using-api-to-generate-document-of-record-with-aem-forms}

Generate Document Of Record (DOR) programmatically

This article illustrates the use of the `com.adobe.aemds.guide.addon.dor.DoRService API` to generate **Document of Record** programmatically. [Document of Record](https://docs.adobe.com/content/help/en/experience-manager-65/forms/adaptive-forms-advanced-authoring/generate-document-of-record-for-non-xfa-based-adaptive-forms.html) is a PDF version of the data captured in Adaptive Form.

1. The following is the code snippet. The first line gets the DOR Service.
1. Set the DoROptions.
1. Invoke the render method of the DoRService and pass the DoROptions object to the render method

```java
com.adobe.aemds.guide.addon.dor.DoRService dorService = sling.getService(com.adobe.aemds.guide.addon.dor.DoRService.class);
com.adobe.aemds.guide.addon.dor.DoROptions dorOptions =  new com.adobe.aemds.guide.addon.dor.DoROptions();
 dorOptions.setData(dataXml);
 dorOptions.setFormResource(resource);
 java.util.Locale locale = new java.util.Locale("en");
 dorOptions.setLocale(locale);
 com.adobe.aemds.guide.addon.dor.DoRResult dorResult = dorService.render(dorOptions);
 byte[] fileBytes = dorResult.getContent();
 com.adobe.aemfd.docmanager.Document dorDocument = new com.adobe.aemfd.docmanager.Document(fileBytes);

```

To try this on your local system, please follow the following steps

1. [Download and install the article assets using package manager](assets/dor-with-api.zip)
1. Make sure you have installed and started the DevelopingWithServiceUser bundle provided as part of [Create Service User article](service-user-tutorial-develop.md)
1. [Login to configMgr](http://localhost:4502/system/console/configMgr)
1. Search for Apache Sling Service User Mapper Service
1. Make sure you the following entry _DevelopingWithServiceUser.core:getformsresourceresolver=fd-service_ in the Service Mappings section
1. [Open the form](http://localhost:4502/content/dam/formsanddocuments/sandbox/1201-borrower-payments/jcr:content?wcmmode=disabled)
1. Fill out the form and click on ' View PDF '
1. You should see DOR in new tab in your browser


**Troubleshooting Tips**

PDF isn't displayed in new browser tab:

1. Make sure you are not blocking popups in your browser
1. Make you have followed the steps outlined in this [article](service-user-tutorial-develop.md)
1. Make sure the 'DevelopingWithServiceUser' bundle is in *active state* 
1. Make sure the system user ' data ' has Read, Modify, and Create permissions on the following node `/content/usergenerated/content/aemformsenablement`

