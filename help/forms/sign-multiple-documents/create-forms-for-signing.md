---
title: Create Forms for Signing
description: Create forms that need to be included in the signing package.
feature: adaptive-forms
topics: development
audience: developer
doc-type: tutorial
activity: implement
version: 6.4,6.5
kt: 6893
thumbnail: 6893.jpg
---

# Create forms for signing

The next step is to create the adaptive forms you want to be included in the package. Please remember to adhere to the following points when creating forms for signing:

* Make sure the forms are based on the **SignMultipleForms** template. This ensures the forms are pre-populated with the data fetched form the database.

* The forms need to be configured to use Adobe Sign and the signer1 field needs to be associated with the Customer Email field
* The forms also need to be associated with clientLib called **getnextform**
* The forms need to use Signature Step component.
* The form must also use the custom **Sign Multiple Form** component. This component allows you to navigate to the next form to sign in the package.
* The submission of the form must be configured to trigger AEM workflow **Update Signature Status**
* Make sure the Data File Path is set to **Data.xml**. This is very important as the sample code looks for a file called Data.xml in the payload the process the form submission.

Once you have authored your form, include the **commonfields** adaptive form fragment in the form. The fragment will be marked as hidden. This fragment contains the following fields.

* **signed** - The field to hold the status of the signature
* **guid** - Unique identifier to identify the form in the package
* **customerEmail** - This field will hold the customer's email



>[!NOTE]
>If you want to carry data from one form to another form in the package, please make sure the form fields are named identically in all the forms.

## All Done Form

Once all the forms in the package are filled and signed, we need to display the appropriate message. This message is displayed with the help of Alldone form. The Alldone form is included in the sample forms.

## Assets

The sample forms including the  used in this tutorial can be [downloaded from here](assets/forms-for-signing.zip)
