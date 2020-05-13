---
title: Using Form Data Model Service as Step in Workflow
seo-title: Using Form Data Model Service as Step in Workflow
description: Starting with AEM Forms 6.4, we now have the ability to use Form Data Model as part of AEM Workflow. The following video walks thru the steps needed to configure Form Data Model step in AEM Workflow.
seo-description: Starting with AEM Forms 6.4, we now have the ability to use Form Data Model as part of AEM Workflow. The following video walks thru the steps needed to configure Form Data Model step in AEM Workflow.
uuid: ecd5d5aa-01eb-48fb-872f-66c656ae14df.

feature: workflow
topics: integrations
audience: developer
doc-type: technical-video
activity: setup
version: 6.4,6.5

discoiquuid: c442f439-1e5d-4f96-85df-b818c28389ff
---

# Using Form Data Model Service as Step in Workflow {#using-form-data-model-service-as-step-in-workflow}

Starting with AEM Forms 6.4, we now have the ability to use Form Data Model as part of AEM Workflow. The following video walks thru the steps needed to configure Form Data Model step in AEM Workflow


>[!VIDEO](https://video.tv.adobe.com/v/21719/?quality=9&learn=on)

To test this capability on your server, follow the below instructions
* [Download and deploy the setvalue bundle](/help/forms/assets/common-osgi-bundles/SetValueApp.core-1.0-SNAPSHOT.jar). This is the custom OSGI bundle which sets metadata properties.
>![NOTE]In AEM Forms 6.5 and above this capability is available out of the box as [describe here](form-data-model-service-as-step-in-aem65-workflow-video-use.md)

* Setup tomcat with SampleRest.war file as described [here](https://docs.adobe.com/content/help/en/experience-manager-learn/forms/ic-print-channel-tutorial/introduction.html).The war file deployed in Tomcat has the code to return the applicant's credit score. The credit score is random number between 200 and 800

* [Import the assets into AEM using package manager](assets/invoke-fdm-as-service-step.zip).The package contains the following:

  * Workflow model which uses FDM step.
  * Form Data Model that is used in the FDM step.
  * Adaptive form to trigger the workflow on submission.
* Open the [MortgageApplicationForm](http://localhost:4502/content/dam/formsanddocuments/loanapplication/jcr:content?wcmmode=disabled). Fill in the details and submit. On the form submission the [loanapplication workflow](http://http://localhost:4502/editor.html/conf/global/settings/workflow/models/LoanApplication2.html) is triggered.

![ workflow ](assets/fdm-as-service-step-workflow.PNG).
 The workflow utilizes Or Split component to route the application to admin if the credit score is over 500. If the credit score is less than 500 the application is routed to cavery
