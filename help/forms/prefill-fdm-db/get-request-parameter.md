---
title: Get request parameter
description: Access the request parameter a form data model's prefill service
feature: adaptive-forms
topics: development
audience: developer
doc-type: article
activity: implement
version: 6.4,6.5
kt: 5815
thumbnail: kt-5815.jpg
---
# Access empID request parameter

The next step is to access the empID parameter from the url. The value of empID request parameter is then passed to the **_get_** service operation of the form data model.
For the purpose of this course we have created and provided the following

* Adatpive form Template called **_FDMDemo_**
* Page Component called **_fdmdemo_**
* Included our custom jsp with the page component
* Associated the adaptive form template with the page component

 By doing this our code in the custom jsp will only be executed when adaptive form based on this custom template is rendered
 
* [Import the package](assets/template-page-component.zip) using [package manager](http://localhost:4502/crx/packmgr/index.jsp)
* [Open fdmrequest.jsp](http://localhost:4502/crx/de/index.jsp#/apps/fdmdemo/component/page/fdmdemo/fdmrequest.jsp)
* Uncomment the commented lines.
* Save your changes

``` java

if(request.getParameter("empID")!=null)
    {
      //System.out.println("Adobe !!!There is a empID parameter in the request "+request.getParameter("empID"));
      //java.util.Map paraMap = new java.util.HashMap();
      //paraMap.put("empID",request.getParameter("empID"));
      //slingRequest.setAttribute("paramMap",paraMap);
    }

````

The value of empID is associated with key called empID in paraMap. This map is then passed to the slingRequest

>[!NOTE]The key empID has to match with the binding value of the newhire entities get service




