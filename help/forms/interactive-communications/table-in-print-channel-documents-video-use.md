---
title: Using Table Component in AEM Forms Print Channel Document
seo-title: Using Table Component in AEM Forms Print Channel Document
description: The following video walks through the steps required to use table component in Interactive Communications for print channel documents.
feature: interactive-communication
topics: development
audience: developer
doc-type: technical video
activity: implement
version: 6.4,6.5


---

# Using Table Component in AEM Forms Print Channel Document {#using-table-component-in-aem-forms-print-channel-document}

The following video walks through the steps required to use table component in Interactive Communications for print channel documents.

>[!VIDEO](https://video.tv.adobe.com/v/27769?quality=9&learn=on)

Tables are used to display data in tabular manner. The rows in the table need to grow or shrink depending on the data returned by the data source. To use a table in print channel document, we need to create layout file(xdp file) using AEM Forms Designer. In this layout file, we add the table with the required number of columns. Make sure the column field object type is either TextField or Numeric Field depending on your requirements. For each of the column, fields make sure the data binding is set to Use Name.

>[!NOTE]
To make table dynamic, make sure you have marked the Row as repeating.

**Try it on your own server**

* [Download and unzip the assets file on to your hard drive](assets/usingtablesinprintchannel.zip)

* Import the two zip files into AEM using package manager 

* Included in the assets associated with this article are the following:

    * Layout Fragment

    * Form Data Modal

    * Interactive Communication Document
    * sampleretirementaccountdata.json

* Open the Interactive Communication Document in [edit mode](http://localhost:4502/editor.html/content/forms/af/401kstatement/tablesinprintdocument/channels/print.html).

* Add the TableDemo layout fragment to the contributions section.
* Bind the table cells to the appropriate Form Data Model elements as shown in the video

* Preview Interactive Communication Document with the sample json data file provided to you

