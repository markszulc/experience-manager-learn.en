---
title: Configuring Adaptive Form to trigger AEM Workflow
description: Configure payload options when triggering AEM workflow on form submission
sub-product: forms
feature: workflow
topics: integrations
audience: developer
doc-type: article
activity: setup
version: 6.4,6.5
kt: 5407
thumbnail: 40258.jpg
---

# Configuring Adaptive Form to trigger AEM Workflow

## Prerequisites

The sample form used in this workflow is based on a custom adaptive form template which needs to be imported into your AEM server. The sample form that is provided needs to be imported after importing the template.

### Get the Adaptive Form Templates

* Download [Adaptive Form Template](assets/af-form-template.zip)
* [Import the template using package manager](http://localhost:4502/crx/packmgr/index.jsp)
* Upload and install the Adaptive Form template

### Get the sample Adaptive Form

* Download [Adaptive Form](assets/peak-application-form.zip) 
* Browse to [Form And Documents](http://localhost:4502/aem/forms.html/content/dam/formsanddocuments)
* Click Create -> File Upload
* The sample adaptive form will be placed in a folder called [Application Forms](http://localhost:4502/aem/forms.html/content/dam/formsanddocuments/applicationforms)

The following video explains how to configure an Adaptive Form to trigger an AEM Workflow
>[!VIDEO](https://video.tv.adobe.com/v/40258/?quality=9&learn=on)

The following video shows you the workflow payload and other details in the crx repository

>[!VIDEO](https://video.tv.adobe.com/v/40259/?quality=9&learn=on)


