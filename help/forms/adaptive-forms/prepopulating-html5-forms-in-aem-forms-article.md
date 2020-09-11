---
title: PrePopulate HTML5 Forms using data attribute.
seo-title: PrePopulate HTML5 Forms using data attribute.
description: Populate HTML5 forms by fetching data from the backend source.
seo-description: Populate HTML5 forms by fetching data from the backend source.
feature: integrations
topics: mobile-forms
audience: developer
doc-type: article
activity: implement
version: 6.3,6.4,6.5.
uuid: 889d2cd5-fcf2-4854-928b-0c2c0db9dbc2
discoiquuid: 3aa645c9-941e-4b27-a538-cca13574b21c
---

# PrePopulate HTML5 Forms using data attribute {#prepopulate-html-forms-using-data-attribute}

Please visit the [AEM Forms samples](https://forms.enablementadobe.com/content/samples/samples.html?query=0) page for a link to a live demo of this capability.

XDP Templates rendered in HTML format using AEM Forms are called HTML5 or Mobile Forms. A common use case is to pre-populate these forms when they are being rendered.

There are 2 ways to merge data with the  xdp  template when it is being rendered as HTML.

**dataRef**: You can use the  dataRef  parameter in the URL. This parameter specifies the absolute path of the data file that is merged with the template. This parameter can be a URL to a rest service returning the data in XML format.

**data**: This parameter specifies the UTF-8 encoded data bytes that are merged with the template. If this parameter is specified, the HTML5 form ignores dataRef parameter. As a best practice, we recommend using the data approach.

The recommended approach is to set the data attribute in the request with the data that you want to pre-populate the form with.

slingRequest.setAttribute("data", content);

In this example, we are setting the data attribute with the content. The content represents the data that you want to pre-populate the form with. Typically you would fetch the "content" by making a REST call to an internal service.

To achieve this use case you need to create a custom profile. The details on creating custom profile are clearly documented in [AEM Forms documentation here](https://helpx.adobe.com/aem-forms/6/html5-forms/custom-profile.html).

Once you create your custom profile, you will then create a JSP file which will fetch the data by making calls to your backend system. Once the data is fetched you will use the slingRequest.setAttribute("data", content); to pre-populate the form

When the XDP is being rendered, you can also pass in some parameters to the  xdp  and based on the value of the parameter you can fetch the data from the backend system.

[For example this url has name parameter](http://localhost:4502/content/dam/formsanddocuments/PrepopulateMobileForm.xdp/jcr:content?name=john)

The JSP that you write will have access to the name parameter through the request.getParameter("name") . You can then pass the value of this parameter to your backend process to fetch the required data.
To get this capability working on your system, please follow the steps mentioned below:

* [Download and Import the assets into AEM using package manager](assets/prepopulatemobileform.zip)
The package will install the following  

  * CustomProfile  
  * Sample XDP  
  * Sample POST endpoint that will return data to populate your form  

>[!NOTE]
>
>If you want to populate your form by calling workbench process, you may want to include the callWorkbenchProcess.jsp in your /apps/AEMFormsDemoListings/customprofiles/PrepopulateForm/html.jsp instead of the setdata.jsp
  
* [Point your favorite browser to this url](http://localhost:4502/content/dam/formsanddocuments/PrepopulateMobileForm.xdp/jcr:content?name=Adobe%20Systems). Form should get pre-populated with the value of the name parameter
