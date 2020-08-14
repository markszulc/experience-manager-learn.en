---
title: Opening Agent UI On POST Submission
seo-title: Opening Agent UI On POST Submission
description: This is part 11 of multistep tutorial for creating your first interactive communications document for the print channel. In this part, we will launch the agent ui interface for creating ad-hoc correspondence on form submission.
seo-description: This is part 11 of multistep tutorial for creating your first interactive communications document for the print channel. In this part, we will launch the agent ui interface for creating ad-hoc correspondence on form submission.
uuid: 96f34986-a5c3-400b-b51b-775da5d2cbd7
feature: interactive-communication
topics: development
audience: developer
doc-type: tutorial
activity: implement
version: 6.4,6.5
discoiquuid: 5682f024-a2f3-46a0-8274-3bdefe4a3905

---

# Opening Agent UI On POST Submission

In this part, we will launch the agent ui interface for creating ad-hoc correspondence on form submission.

This article will walk you through the steps involved in opening agent ui interface on submitting a form. Typical use case is for customer service agent to fill in a form with some input parameters and on form submission agent ui is opened with data prepopulated from form data model prefill service.The input parameters to the form data model prefill service are extracted from the form submission.

```java
String accountNumber = request.getParameter("accountnumber"))
ParameterMap parameterMap = new ParameterMap();
RequestParameter icLetterId[] = new RequestParameter[1];
icLetterId[0] = new FormFieldRequestParameter("/content/dam/formsanddocuments/retirementstatementprint");
parameterMap.put("documentId", icLetterId);
RequestParameter Random[] = new RequestParameter[1];
Random[0] = new FormFieldRequestParameter("209457");
parameterMap.put("Random", Random);
Map map = new HashMap();
map.put("accountnumber",accountNumber);
slingRequest.setAttribute("paramMap",map);
CustomParameterRequest wrapperRequest = new CustomParameterRequest(slingRequest,parameterMap,"GET");
wrapperRequest.getRequestDispatcher("/aem/forms/createcorrespondence.html").include(wrapperRequest, response);

```

Line 1 : Get the accountnumber from the requestparameter

Line 2-8: Create parameter map and set appropriate keys and values to reflect the documentId,Random.

Line 9-10: Create another Map object to hold the input parameter defined in the Form Data Model.

Line 11: Set the slingRequest attribute "paramMap"

Line 12-13: Forward the request to the servlet

To test this capability on your server

* [Import and install the assets related to this article using package manager.](assets/launch-agent-ui.zip)
* [Login to configMgr](http://localhost:4502/system/console/configMgr)
* Search for _Adobe Granite CSRF Filter_
* Add _/content/getprintchannel_ in the Excluded Paths
* Save your changes. 
* [Open POST.jsp](http://localhost:4502/apps/AEMForms/openprintchannel/POST.jsp). Make sure the string passed to FormFieldRequestParameter is valid documentId.(Line 19).
* [Open the webpage](http://localhost:4502/content/OpenPrintChannel.html) and enter accountnumber and submit the form.
* Agent UI interface should open with the data pre-populated specific to the accountnumber entered in the form.

>[!NOTE]
>
>Make sure your Form Data Model's Get operation's input parameter is bound to Request Attribute called "accountnumber" for this to work. If you change the name of the bindingvalue to any other name, make sure the change is reflected on line 25 of the POST.jsp

