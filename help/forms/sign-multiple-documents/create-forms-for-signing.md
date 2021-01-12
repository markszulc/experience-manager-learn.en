---
title: Create forms for signing
description: Create forms for signing
feature: adaptive-forms
topics: development
audience: developer
doc-type: tutorial
activity: implement
version: 6.4,6.5
---

# Create forms for signing

The next step is to create the adaptive forms you want to be included in the package.
Make sure the forms are based on the **SignMultipleForms** template. This ensures the forms are pre-populated with the data fetched form the database.

If you want to carry data from one form to another form in the package, please make sure the form fields are named identically in both the forms.
The forms also need to be associated with clientLib called **getnextform** and enabled to use Adobe Sign
The form must also use the custom Sign Multiple Form component. This component allows you to navigate to the next form to sign in the package.

Once you have authored your form, include the **commonfields** adaptive form fragment in the form.The fragment will be marked as hidden. This fragment contains the following fields.

* **signed** - The field to hold the status of the signature
* **guid** - Unique identifier to identify the form in the package
* **customerEmail** - This field will hold the customer's email

The sample forms used in this tutorial can be [downloaded from here](assets/forms-for-signing.zip)

>[!NOTE]
> The sample code provides in this tutorial assumes the forms are residing in the **formsandsigndemo** folder.




