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

# Creating Acroform

Acroforms are forms created using Acrobat. You can create a new form from scratch using Acrobat or take an existing form created in Micrsoft Word and convert it into Acroform using Acrobat. The following steps need to be followed to convert a form created in Microsoft Word to Acroform.

* Open word document using Acrobat
* Use Acrobat Prepare form tool to identify the form fields on the form.
* Save the pdf. Make sure the file name does not have any spaces in it.


>[!VIDEO](https://video.tv.adobe.com/v/22575?quality=9&learn=on)

>[!NOTE]
>
>If you want to send the fillable acroform for signing using Adobe Sign, Please name the fields accordingly. For example, you could name a field **Sig_es_:signer1:signature**. This is the syntax Adobe Sign understands.

>[!NOTE]
>
>If you are sending an XFA based document, you need to flatten the document and the Adobe Sign signature tags need be present as static text in the document.

[Adobe Sign Text Tags Document](https://helpx.adobe.com/sign/using/text-tag.html)

>[!NOTE]
>
>Make sure the acroform filename does not have any spaces in it. The current sample code does not handle spaces.
>
>The form field names can only contain the following:
>
>* single space 
>* single underscore
>* alphanumeric characters
