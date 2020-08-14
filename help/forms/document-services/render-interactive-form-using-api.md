---
title: Developing with Output and Forms Services in AEM Forms
seo-title: Developing with Output and Forms Services in AEM Forms
description: Using Output and Forms Service API in AEM Forms
seo-description: Using Output and Forms Service API in AEM Forms
feature: forms-service
topics: development
audience: developer
doc-type: article
activity: implement
version: 6.4,6.5

---

# Rendering Interactive PDF using Forms Services in AEM Forms

Using Forms Service API in AEM Forms to render interactive PDF

In this article we will take a look at the following service

* FormsService - This is a very versatile service which allows you to export/import data from and into PDF file and also generate interactive pdf by merging xml data into xdp template

The official javadoc for AEM Forms API is listed [here](https://helpx.adobe.com/aem-forms/6/javadocs/com/adobe/fd/output/api/package-summary.html)

The following code snippet renders interactive pdf using the renderPDFForm operation of the FormsService. The schengen.xdp is template that is being used to merge the xml data.

```java
String uri = "crx:///content/dam/formsanddocuments";
PDFFormRenderOptions renderOptions = new PDFFormRenderOptions();
renderOptions.setAcrobatVersion(AcrobatVersion.Acrobat_11);
renderOptions.setContentRoot(uri);
Document interactivePDF = null;
try {
interactivePDF = formsService.renderPDFForm("schengen.xdp", xmlData, renderOptions);
} catch (FormsServiceException e) {
 e.printStackTrace();
}
return interactivePDF;

```

Line 1: Location of the folder which contains the xdp template

Line2-4: Create PDFFormRenderOptions and set its properties

Line 7: Generate Interactive PDF using the renderPDFForm service operation of FormsService

Line 11: Returns the generated interactive pdf to the calling application

**To test the sample package on your system**
1. [Download and install the DocumentServices Sample Bundle using the Felix Web Console](/help/forms/assets/common-osgi-bundles/AEMFormsDocumentServices.core-1.0-SNAPSHOT.jar)
1. [Download and install the package using the AEM package manager](assets/downloadinteractivepdffrommobileform.zip)



1. [Login to configMgr](http://localhost:4502/system/console/configMgr)
1. Search for Adobe Granite CSRF Filter
1. Add the following path in the excluded sections and save
1. /bin/generateinteractivepdf
1. [Open the mobile form](http://localhost:4502/content/dam/formsanddocuments/schengen.xdp/jcr:content)
1. Fill in a couple of fields and then click the ***Download and fill ....*** button
1. The interactive pdf should be downloaded to your local system


The sample package contains the custom profile that is associated with the Mobile Form. Please explore the [customtoolbar.jsp](http://localhost:4502/apps/AEMFormsDemoListings/customprofiles/addImageToMobileForm/demo/customtoolbar.jsp) file. This jsp extracts the data from the mobile form and makes a POST request to servlet mounted on ***/bin/generateinteractivepdf*** path. The servlet return the interactive pdf to the calling application. The code in the customtoolbar.jsp then downloads the file to your local system


