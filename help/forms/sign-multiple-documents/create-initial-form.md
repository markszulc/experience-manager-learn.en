---
title: Create Initial Form
description: Create initial form to trigger the e-mail 
feature: adaptive-forms
topics: development
audience: developer
doc-type: tutorial
activity: implement
version: 6.4,6.5
kt: 6892
thumbnail: 6892.jpg
---

# Create Initial Form

The initial form(Refinance Form) is used to trigger the process of signing multiple forms by triggering the **Sign Multiple Forms** AEM workflow. You may author the form the way you want, but please remember to add the following fields to the form.




Field Type|Name | Purpose| Hidden| Default Value
------------------------|---------------------------------------|--------------------|--------|-----------------
TextField| signed| To indicate the signing status |Y|N
TextField| guid| To uniquely identify form|Y| 3889
TextField| customerName| To capture customers name|N|
TextField| customerEmail| Customer email to send notification|N| 
CheckBox| formsToSign| The items identify the forms in the package|N| 




The initial form needs to be configure to trigger an AEM workflow called **signmultipleforms**
Make sure the Data File Path is set to **Data.xml**. This is very important as the sample code looks for a file called Data.xml in the payload the process the form submission.

## Assets

The initial form (Refinance Form) can be [downloaded from here](assets/refinance-form.zip)







