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

The form **storeafwithattachments** is the main adaptive form. This adaptive form is the entry point to the use case. In this form the user enter some user details including mobile number with the ability to add some attachments. When the Save and Exit button is clicked a unique application id will be generated and presented to the user for safe keeping. This application id will be used in the next form to retrieve the mobile number associated with the application.

This form is associated with an AEM workflow that gets triggered when the user clicks submit button.

This is associated with **bootboxjs540,storeAFWithAttachments** client libraries created earlier in the course

## Create form to retrieve saved application

The form **MyAccountForm** is used to retrieve the partially completed adaptive form after the user has verified the application id and the mobile number associated with the application id.

When the user enters the application id  and clicks the **FetchApplication** button, the mobile number associated with the application id is fetched from the database using the Get operation of the form data model.

This form makes use of the POST invocation of the Form Data Model to verify the mobile number using OTP. The form's submit action is triggered on successful verification of the mobile number using the following code. We are triggering the click event of the submit button named **submitForm**.

>[!NOTE]
> You will need to provide the API Key and the API Secret values specific to your [Nexmo](https://dashboard.nexmo.com/) account in the appropriate fields of the MyAccountForm

![trigger-submit](assets/trigger-submit.JPG)


This form is associated with custom submit action that forwards the form submission to the servlet mounted on **/bin/renderaf**

``` java
com.adobe.aemds.guide.utils.GuideSubmitUtils.setForwardPath(slingRequest,"/bin/renderaf",null,null);

```

The code in the servlet mounted on **/bin/renderaf** forwards the request to render the storeafwithattachments adaptive form prepopulated with the saved data.


The 2 sample forms(MyAccountForm and StoreAFWithAttachments) are provided and can be [downloaded from here](assets/sample-forms.zip)

The sample forms are based on [custom adaptive form template](assets/custom-template-with-page-component.zip) that needs to be imported into AEM for the sample forms to render correctly.
The [Custom submit and sample worklow](assets/custom-submit-and-workflow.zip) need to be imported into your AEM instance for the forms to work.
