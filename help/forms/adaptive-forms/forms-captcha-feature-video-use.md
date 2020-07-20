---
title: Using CAPTCHAs with AEM Adaptive Forms
seo-title: Using CAPTCHAs with AEM Adaptive Forms
description: Adding and using a CAPTCHA with AEM Adaptive Forms.
seo-description: Adding and using a CAPTCHA with AEM Adaptive Forms.

feature: adaptive-forms
topics: integrations
audience: developer
doc-type: technical video
activity: setup
version: 6.4,6.5
uuid: bd63e207-4f4d-4f34-9ac4-7572ed26f646
discoiquuid: 5e184e44-e385-4df7-b7ed-085239f2a642
---

# Using CAPTCHAs with AEM Adaptive Forms{#using-captchas-with-aem-adaptive-forms}

Adding and using a CAPTCHA with AEM Adaptive Forms.

Please visit the [AEM Forms samples](https://forms.enablementadobe.com/content/samples/samples.html?query=0) page for a link to a live demo of this capability.

>[!VIDEO](https://video.tv.adobe.com/v/18336/?quality=9&learn=on)

*This video walks through the process of adding a CAPTCHA to an AEM Adaptive Form using both the built-in AEM CAPTCHA service as well as Google's reCAPTCHA service.*

>[!NOTE]
>
>This feature is available only with AEM 6.3 onwards.

>[!NOTE]
>
>**To configure reCaptcha on publish instance please follow the steps**
>
>Configure reCaptach on author instance
>
>open the felix [web console](http://localhost:4502/system/console/bundles) on the author instance
>
>search for com.adobe.granite.crypto.file bundle
>
>Note the bundle id. On my instance it is 20
>
>Navigate to the bundle id on the file system on your author instance 
>
>* &lt;author-aem-install-dir&gt;/crx-quickstart/launchpad/felix/bundle20/data
>* Copy the HMAC and master files
>
>Open the [felix web console](http://localhost:4502/system/console/bundles) on your publish instance. Search for com.adobe.granite.crypto.file bundle. Note the bundle id
>
>Navigate to the bundle id on the file system of your publish instance
>
>* &lt;publish-aem-install-dir&gt;/crx-quickstart/launchpad/felix/bundle20/data
>* delete the exisiting HMAC and master files.
>* paste the HMAC and master files copied from the author intance 
>
>Restart your AEM publish server

## Supporting materials {#supporting-materials}

* [Google reCAPTCHA](https://www.google.com/recaptcha)

