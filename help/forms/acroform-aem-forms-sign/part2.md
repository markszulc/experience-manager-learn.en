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

# Create Schema from the acroform

The next step is to create a schema from the Acroform created in the earlier step. A sample application is provided to create the schema as part of this tutorial. To create the schema, please follow the following instructions:

1. Login to [CRXDE Lite](http://localhost:4502/crx/de)
2. Open to the file `/apps/AemFormsSamples/components/createxsd/POST.jsp`
3. Change the `saveLocation` to an appropriate folder on your hard drive. Make sure the folder you are saving to is already created.
4. Point your browser to [Create XSD](http://localhost:4502/content/DocumentServices/CreateXsd.html) page hosted on AEM.
5. Drag and drop the Acroform.
6. Check the folder specified in Step 3. The schema file is saved to this location.

## Upload the Acroform

For this demo to work on your system, you will need to create a folder called `acroforms` in AEM Assets. Upload the Acroform into this `acroforms` folder.

>[!NOTE]
>
>The sample code looks for the acroform in this folder. The acroform is needed to merge the adaptive form's submitted data.
