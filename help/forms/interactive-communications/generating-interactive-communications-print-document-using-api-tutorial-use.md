---
title: Generating Interactive Communications Document for print channel using watch folder mechanism
seo-title: Generating Interactive Communications Document for print channel using watch folder mechanism
description: Use watched folder to generate print channel documents
seo-description: Use watched folder to generate print channel documents

feature: interactive-communication
topics: development
audience: developer
doc-type: article
activity: implement
version: 6.4,6.5


---

# Generating Interactive Communications Document for print channel using watch folder mechanism

After you have designed and tested your print channel document, you will typically need to generate the document by making a making a REST call or generate print documents using watch folder mechanism.

This article explains the use case of generating print channel documents using watched folder mechanism.

When you drop a file into the watched folder, a script associated with watched folder gets executed. This script is explained in the article down below.

The file dropped into watched folder has the following structure. The code will generate statements for all the accountnumber(s) listed in the XML document.

&lt;accountnumbers&gt;

&lt;accountnumber&gt;509840&lt;/accountnumber&gt;

&lt;accountnumber&gt;948576&lt;/accountnumber&gt;

&lt;accountnumber&gt;398762&lt;/accountnumber&gt;

&lt;accountnumber&gt;291723&lt;/accountnumber&gt;

&lt;/accountnumbers&gt;

The code listing below does the following :

Line 1 - Path to the InteractiveCommunicationsDocument

Lines 15-20: Get the list of accountnumbers from the XML document dropped into the watched folder

Lines 24 -25: Get the PrintChannelService and Print Channel associated with the document.

Line 30: Pass the accountnumber as the key element to the Form Data Model.

Lines 32-36: Set the Data Options for the Document that is to be generated.

Line 38: Render the document.

Lines 39-40 - Saves the generated document to the file system.

The REST endpoint of the Form Data Model expects an id as an input parameter. this id is mapped to a Request Attribute called accountnumber as shown in the screenshot below.

![requestattribute](assets/requestattributeprintchannel.gif) 

```java
var interactiveCommunicationsDocument = "/content/forms/af/retirementstatementprint/channels/print/";
var saveLocation =  new Packages.java.io.File("c:\\scrap\\loadtesting");

if(!saveLocation.exists())
{
 saveLocation.mkdirs();
}

var inputMap = processorContext.getInputMap();
var entry = inputMap.entrySet().iterator().next();
var inputDocument = inputMap.get(entry.getKey());
var aemDemoListings = sling.getService(Packages.com.mergeandfuse.getserviceuserresolver.GetResolver);
var resourceResolver = aemDemoListings.getServiceResolver();
var resourceResolverHelper = sling.getService(Packages.com.adobe.granite.resourceresolverhelper.ResourceResolverHelper);
var dbFactory = Packages.javax.xml.parsers.DocumentBuilderFactory.newInstance();
var dBuilder = dbFactory.newDocumentBuilder();
var xmlDoc = dBuilder.parse(inputDocument.getInputStream());
var nList = xmlDoc.getElementsByTagName("accountnumber");
for(var i=0;i<nList.getLength();i++)
{
 var accountnumber = nList.item(i).getTextContent();
resourceResolverHelper.callWith(resourceResolver, {call: function()
       {
   var printChannelService = sling.getService(Packages.com.adobe.fd.ccm.channels.print.api.service.PrintChannelService);
   var printChannel = printChannelService.getPrintChannel(interactiveCommunicationsDocument);
   var options = new Packages.com.adobe.fd.ccm.channels.print.api.model.PrintChannelRenderOptions();
   options.setMergeDataOnServer(true);
   options.setRenderInteractive(false);
   var map = new Packages.java.util.HashMap();
   map.put("accountnumber",accountnumber);
    // Required Data Options
   var dataOptions = new Packages.com.adobe.forms.common.service.DataOptions(); 
   dataOptions.setServiceName(printChannel.getPrefillService()); 
   dataOptions.setExtras(map); 
   dataOptions.setContentType(Packages.com.adobe.forms.common.service.ContentType.JSON);
   dataOptions.setFormResource(resourceResolver.resolve(interactiveCommunicationsDocument));
            options.setDataOptions(dataOptions); 
    var printDocument = printChannel.render(options);
   var statement = new Packages.com.adobe.aemfd.docmanager.Document(printDocument.getInputStream());
            statement.copyToFile(new Packages.java.io.File(saveLocation+"\\"+accountnumber+".pdf"));

      }
   });
}

```


**To test this on your local system please follow the following instructions:**

* Setup Tomcat as described in this [article.](/help/forms/ic-print-channel-tutorial/partone.md) Tomcat has the war file which generates the sample data.
* Set up service aka system user as described in this [article](/help/forms/adaptive-forms/service-user-tutorial-develop.md).
Make sure this system user has read permissions on the following node. To give the permissions login to [user admin](https://localhost:4502/useradmin) and search for the system user "data" and give the read permissions on the following node by tabbing to the permissions tab
    * /content/dam/formsanddocuments
    * /content/dam/formsanddocuments-fdm
    * /content/forms/af
* Import the following package(s) into AEM using the package manager. This package contains the following:


 * [Sample Interactive Communications Document](assets/retirementstatementprint.zip)
 * [Watched Folder Script](assets/printchanneldocumentusingwatchedfolder.zip)
 * [Data Source Configuration](assets/datasource.zip)

* Open the /etc/fd/watchfolder/scripts/PrintPDF.ecma  file. Make sure the path to the interactiveCommunicationsDocument in line 1 is pointing to the correct document that you want to print

* Modify the saveLocation as per your preference on Line 2

* Create accountnumbers.xml file with the following content

```xml

<accountnumbers>
<accountnumber>1</accountnumber>
<accountnumber>100</accountnumber>
<accountnumber>101</accountnumber>
<accountnumber>1009</accountnumber>
<accountnumber>10009</accountnumber>
<accountnumber>11990</accountnumber>
</accountnumbers>

```


* Drop the accountnumbers.xml into the C:\RenderPrintChannel\input folder.

* The generated PDF files are written to the saveLocation as specified in the ecma script.

>[!NOTE]
>
>If you plan to use this on a non-windows operating system, please navigate to 
>
>/etc/fd/watchfolder /config/PrintChannelDocument and change the folderPath as per your preference

