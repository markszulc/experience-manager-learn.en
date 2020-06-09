---
title: Trigger AEM Workflow
description: Configure Adaptive Form to trigger AEM Workflow .
sub-product: forms
feature: workflow
topics: integrations
audience: developer
doc-type: article
activity: setup
version: 6.4,6.5
KT: 5407
thumbnail: kt-5407.jpg
---
# Configuring Adaptive Form to trigger AEM Workflow

* Download [Adaptive Form](assets/time-off-application.zip) 
* Browse to [Form And Documents](http://localhost:4502/aem/forms.html/content/dam/formsanddocuments)
* Click Create -> File Upload. Select the form downloaded in step 1
* Open [Adaptive Form in edit mode](http://localhost:4502/editor.html/content/forms/af/timeofapplication.html).
* Open the content explorer
![Content explorer](assets/af-workflow-submission.PNG)
* Select Form Container node and open its configuration properties
![Submission](assets/af-workflow-submission1.PNG)
* Expand the Submission panel
* Set the form's submit action as specified in the above screen shot.
_Please make sure you make a note of the value specified in the Data File Path field. This value must match the value you specify in the pre-populate section of the Assign Task component of your workflow._

Now when you fill and submit your Adaptive Form, the workflow associated with submit action of the form will be triggered.


