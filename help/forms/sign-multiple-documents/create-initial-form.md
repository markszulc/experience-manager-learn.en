---
title: Create Initial Form
description: Create initial form to trigger the e-mail 
feature: adaptive-forms
topics: development
audience: developer
doc-type: tutorial
activity: implement
version: 6.3,6.4,6.5
---

# Create Initial Form

Create the adaptive form to initiate the process of signing multiple forms. This initial form has 2 hidden fields - signed and guid.

* **signed** - This field has a value of Y or N. The individual forms in the package display the appropriate panels based on this value. Initial value of this field is set to N.
* **guid** - The guid is unique identifier which identifies the form in the package of forms.

The forms to include in the package are identified by the items property of the formsToSign checkbox field. Please include all the forms that need to be included in the package are residing in the folder **formsandsigndemo**. 
All the forms that need to be included in the package need to be based on the same adaptive forms template **SignMultipleForms**.

When this form is filled and submitted AEM workflow **signmultipleforms** is triggered. 





