---
title: Generating Print Channel Documents Using Watched Folder
seo-title: Generating Print Channel Documents Using Watched Folder
description: This is part 10 of multistep tutorial for creating your first interactive communications document for the print channel. In this part, we will generate print channel documents using the watched folder mechanism.
seo-description: This is part 10 of multistep tutorial for creating your first interactive communications document for the print channel. In this part, we will generate print channel documents using the watched folder mechanism.
uuid: 9e39f4e3-1053-4839-9338-09961ac54f81
feature: interactive-communication
topics: development
audience: developer
doc-type: tutorial
activity: implement
version: 6.4,6.5
contentOwner: gbedekar
discoiquuid: 23fbada3-d776-4b77-b381-22d3ec716ae9


---

# Generating Print Channel Documents Using Watched Folder

In this part, we will generate print channel documents using the watched folder mechanism.

After creating and testing your print channel document, we need a mechanism to generate these document in batch mode or on demand. Typically, these kinds of documents are generated in batch mode and the most common mechanism is using watched folder.

When you configure a watched folder in AEM, you associate an ECMA script or java code that gets executed when a file is dropped into the watched folder. In this article, we will focus on ECMA script which will generate print channel documents and save them to the file system.

The watched folder configuration and the ECMA script are part of the assets you imported at the [beginning of this tutorial](introduction.md)

The input file that is dropped into the watched folder has the following structure. ECMA script reads the account numbers and generates print channel document for each of these accounts.

For more details on the ECMA script for generating documents, [refer to this article](/help/forms/interactive-communications/generating-interactive-communications-print-document-using-api-tutorial-use.md)

```xml {.line-numbers}
<accountnumbers>
 <accountnumber>509840</accountnumber>
 <accountnumber>948576</accountnumber>
 <accountnumber>398762</accountnumber>
 <accountnumber>291723</accountnumber>
 <accountnumber>291724</accountnumber>
 <accountnumber>291725</accountnumber>
 <accountnumber>291726</accountnumber>
 <accountnumber>291727</accountnumber>
</accountnumbers>
```

To generate print channel document using the watched folder mechanism, please follow the steps below:

* [Follow the steps mentioned in this document](/help/forms/adaptive-forms/service-user-tutorial-develop.md)

* Login to crx and navigate to /etc/fd/watchfolder/scripts/PrintPDF.ecma

* Make sure the path to interactiveCommunicationsDocument is pointing to the correct document that you want to print.( Line 1)
* Make a note of the saveLocation(Line 2).You can change it as per your needs.
* Make sure the input parameter to the Form Data Model is bound to the Request Attribute and its binding value is set to "accountnumber". Refer to the screenshot below.
![request](assets/requestattributeprintchannel.gif)

 * Create accountnumbers.xml  file with the following content

``` xml {.line-numbers}
<accountnumbers>
<accountnumber>1</accountnumber>
<accountnumber>100</accountnumber>
<accountnumber>101</accountnumber>
<accountnumber>1009</accountnumber>
<accountnumber>10009</accountnumber>
<accountnumber>11990</accountnumber>
</accountnumbers>
```

* Drop the xml file into C:\RenderPrintChannel\input

* Check the pdf files in the save location as specified in the ECMA script.




