---
title: Acroforms with AEM Forms
seo-title: Merge Adaptive Form data with Acroform
feature: adaptive-forms
topics: development
audience: developer
doc-type: tutorial
activity: implement
version: 6.3,6.4
---

# Creating Adaptive Forms from Acroforms

Organizations have a wide variety of forms. Some of these forms are created in Microsoft Word and converted into PDF. These forms by default are not fillable using Adobe Reader or Acrobat. To make these forms fillable using Acrobat or Reader, we need to convert these forms into Acroform. Acroforms are forms created using Acrobat. This article walks through creating an Adaptive Form from Acroform and merging the data back into Acroform to get the PDF. The PDF with the merged data can also be sent for signing using Adobe Sign.

>[!NOTE]
>
>If you are using AEM Forms 6.5, Please use the Automated Forms Conversion capability.

## Prerequisites

* AEM Forms 6.3 or 6.4 installed and configured
* Access to Adobe Acrobat
* Familiarity with AEM/AEM Forms.

### The following are required to get this capability working on your system

* Download and deploy the bundles using the [Felix Web Console](http://localhost:4502/system/console/bundles)
* [DocumentServicesBundle](/help/forms/assets/common-osgi-bundles/AEMFormsDocumentServices.core-1.0-SNAPSHOT.jar)
* [DevelopingWithServiceUser](/help/forms/assets/common-osgi-bundles/DevelopingWithServiceUser.jar)
* [AcroFormsToAEMFormsBundle](https://forms.enablementadobe.com/content/DemoServerBundles/AcroFormToAEMForm.core-1.0-SNAPSHOT.jar)
* [Download and import this package into AEM](assets/acro-form-aem-form.zip). This package contains the sample workflow and html page to create XSD from acroform
* Open the [configMgr](http://localhost:4502/system/console/configMgr)
    * Search for 'Apache Sling Service User Mapper Service' and click to open the properties
    * Click the `+` icon (plus) to add the following Service Mapping
      * `DevelopingWithServiceUser.core:getresourceresolver=data`
      * `DevelopingWithServiceUser.core:getformsresourceresolver=fd-service`
    * Click 'Save'
