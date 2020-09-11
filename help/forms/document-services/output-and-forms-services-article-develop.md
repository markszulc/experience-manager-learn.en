---
title: Developing with Output and Forms Services in AEM Forms
seo-title: Developing with Output and Forms Services in AEM Forms
description: Using Output and Forms Service API in AEM Forms
seo-description: Using Output and Forms Service API in AEM Forms
uuid: be018eb5-dbe7-4101-a1a9-bee11ac97273
feature: output-service
topics: development
audience: developer
doc-type: article
activity: implement
version: 6.4,6.5
discoiquuid: 57f478a9-8495-469e-8a06-ce1251172fda

---

# Developing with Output and Forms Services in AEM Forms{#developing-with-output-and-forms-services-in-aem-forms}

Using Output and Forms Service API in AEM Forms

In this article we will take a look at the following

* Output Service - Typically this service is used to merge xml data with xdp template or pdf to generate flattened pdf
* FormsService - This is a very versatile service which allows you to export/import data from and into PDF file

The official javadoc for AEM Forms API is listed [here](https://helpx.adobe.com/aem-forms/6/javadocs/com/adobe/fd/output/api/package-summary.html)

The following code snippet exports data from PDF file

```java
javax.servlet.http.Part pdfPart = request.getPart("pdffile");
String filePath = request.getParameter("saveLocation");
java.io.InputStream pdfIS = pdfPart.getInputStream();
com.adobe.aemfd.docmanager.Document pdfDocument = new com.adobe.aemfd.docmanager.Document(pdfIS);
com.adobe.fd.forms.api.FormsService formsservice = sling.getService(com.adobe.fd.forms.api.FormsService.class);
com.adobe.aemfd.docmanager.Document xmlDocument = formsservice.exportData(pdfDocument,com.adobe.fd.forms.api.DataFormat.Auto);
```

Line 1 extracts  pdffile  from the request

Line2 extracts the saveLocation from the request

Line 5 gets hold of FormsService

Line 6 exports the xmlData from the PDF File

**To test the sample package on your system**

[Download and install the package using the AEM package manager](assets/outputandformsservice.zip)




**After you install the package you will have to allowlist the following URLs in Adobe Granite CSRF Filter.**

1. Please follow the steps mentioned below to allowlist the paths mentioned above.
1. [Login to configMgr](http://localhost:4502/system/console/configMgr)
1. Search for Adobe Granite CSRF Filter
1. Add the following 3 paths in the excluded sections and save
1. /content/AemFormsSamples/mergedata 
1. /content/AemFormsSamples/exportdata 
1. /content/AemFormsSamples/outputservice 
1. Search for "Sling Referrer filter"
1. Check the "Allow Empty" check box. (This setting should be for testing purposes only)
There are a number of ways to test the sample code. The quickest and easiest is to use Postman app. Postman allows you to make POST requests to your server. Install Postman app on your system. 
Launch the app and enter the following URL to test the export data API

Make sure you have selected "POST" from the drop down list
http://localhost:4502/content/AemFormsSamples/exportdata.html
Make sure you specify "Authorization" as "Basic Auth". Specify the AEM Server username and password
Navigate to the "Body" tab and specify the request parameters as shown in the image below
![export](assets/postexport.png)
Then click the Send button

The package contains 3 samples. The following paragraphs explains when to use the output service or Forms Service, the  url  of the service ,input parameters that each service expects

**Merge Data and Flatten Output:**

* Use Output Service to merge data with  xdp  or pdf document to generate flattened pdf
* **POST URL**: http://localhost:4502/content/AemFormsSamples/outputservice.html
* **Request Parameters -**

    * xdp_or_pdf_file : The xdp or pdf file that you want to merge data with
    * xmlfile: The xml data file that will be merged with xdp_or_pdf_file
    * saveLocation: The location to save the rendered document on your file system

**Import Data into PDF File:**
* Use FormsService to import data into PDF file  
* **POST URL** - http://localhost:4502/content/AemFormsSamples/mergedata.html
* **Request Parameters:**

    * pdffile : The pdf file that you want to merge data with
    * xmlfile: The xml data file that will be merged with pdf file
    * saveLocation: The location to save the rendered document on your file system. For example c:\\\outputsample.pdf.

**Export Data from PDF File**
* Use FormsService to export data from PDF File
* **POST UR**L - http://localhost:4502/content/AemFormsSamples/exportdata.html
* **Request Parameters:**

    * pdffile : The pdf file that you want to export data from
    * saveLocation: The location to save the exported data on your file system

[You could import this postman collection to test the API](assets/document-services-postman-collection.json)

