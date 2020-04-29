---
title: Create HTML5 Forms
description: Create and configure HTML5 forms
feature: mobile-forms
topics: development
audience: developer
doc-type: article
activity: implement
version: 6.4,6.5
KT: 4418
---

# HTML5 forms

HTML5 forms is a new capability in Adobe Experience Manager that offers rendering of XFA form templates in HTML5 format. This capability enables the rendering of forms on mobile devices and desktop browsers on which XFA-based PDF is not supported. HTML5 forms not only supports the existing capabilities of XFA form templates but also adds new capabilities, such as scribble signature, for mobile devices. 

## Create your first HTML5 form

1. [Download and extract the contents of zip file](assets/assets.zip). The zip file contains xdp and data file
2. [Navigate to Forms and Documents](http://localhost:4502/aem/forms.html/content/dam/formsanddocuments)
3. Click on Create -> File Upload
4. Select the xdp template downloaded in step 2

## Preview as HTML

The xdp can be previewed in HTML5 format or PDF format. To preview the xdp in HTML5 format, please follow the following steps

* Tap on the newly uploaded xdp and click _Preview -> Preview as HTML_. You should see the xdp rendered as HTML5

>[!NOTE]
>When you select _Preview as PDF_ option the rendered PDF will not be displayed in the browser because AEM Forms render dynamic pdf's which require Acrobat plugin.You will have to download the PDF and open it using Adobe Acrobat/Reader to view


## Preview with Data

To preview the xdp in HTML5 format with data file please follow the following steps:

* Tap on the newly uploaded xdp and click _Preview -> Preview with Data_. Browse and select the data file and click on _Preview_.
* You should see template rendered in HTML5 format pre filled with the data

## Explore Advanced Properties of xdp template

 The advanced properties of the xdp template allow you to specify publish date, submit handler, render profile for your form, prefill service etc. To view the advanced properties of the template tap on the xdp and click _properties -> Advanced_. Here you will find a number of properties. Some of these properties are covered here.
 **Submit URL** - This is the URL which will handle your HTML5 form submission. We will cover this in the next lesson. If a submit URL is not specified here the default submit handler is invoked which returns the form data to the browser.
 **HTML Render Profile** - HTML5 forms have the notion of Profiles which are exposed as REST Endpoints to enable Mobile Rendering of Form Templates. Majority of times the default render profile should be sufficient to render the form. If the default render profile does not meet your needs, a [custom profile](https://docs.adobe.com/content/help/en/experience-manager-64/forms/html5-forms/custom-profile.html) can be created and associated with the form.
**Prefill Service** - Prefill service is typically used to populate your form with data fetched from a backend data source.

