---
title: Create the required adaptive forms
description: Create the adaptive forms to capture applicant information and adaptive form to retrieve the saved adaptive form
feature: adaptive-forms
topics: development
audience: developer
doc-type: tutorial
activity: implement
version: 6.3,6.4,6.5
kt: 6552
thumbnail: 6552.pg
---
# Create Adaptive Forms

## Create the main adaptive form

This adaptive form is the main entry point to the use case. In this form the user will be asked to enter mobile number and will be able to add some attachments. When the Save and Exit button is clicked a unique application id will be generated that will be used to retrieve the saved form after the mobile number is confirmed.

## Create form to retrieve saved application

This form is used to retrieve the partially completed adaptive form after the user has verified the application id and their mobile number associated with the adaptive form

The 2 sample forms(MyAccountForm and StoreAFWithAttachments) are provided and can be [downloaded from here](assets/sample-forms.zip)
