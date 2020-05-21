---
title: Barcode Service With Adaptive Forms
seo-title: Barcode Service With Adaptive Forms
description: Using barcode service to decode barcode and populate form fields from the extracted data
seo-description: Using barcode service to decode barcode and populate form fields from the extracted data
uuid: 42568b81-cbcd-479e-8d9a-cc0b244da4ae
feature: barcoded-forms
topics: development
audience: developer
doc-type: article
activity: implement
version: 6.4,6.5

discoiquuid: 1224de6d-7ca1-4e9d-85fe-cd675d03e262
---

# Barcode Service With Adaptive Forms{#barcode-service-with-adaptive-forms}

This article will demonstrate the use of Barcode Service to populate Adaptive Form. The use case is as follows:

1. The user adds PDF with Barcode as Adaptive Form attachment
1. The attachment's path is sent to the servlet
1. The servlet decoded the barcode and returns the data in JSON format
1. The Adaptive Form is then populated using the decoded data

The following code decodes the barcode and populates a JSON object with the decoded values. The servlet then returns the JSON object in its response to the calling application.

You can see this capability live, please visit the [samples portal](https://forms.enablementadobe.com/content/samples/samples.html?query=0) and search for Barcode Service Demo

```java
public JSONObject extractBarCode(Document pdfDocument) {
  // TODO Auto-generated method stub
  try {
   org.w3c.dom.Document result = barcodeService.decode(pdfDocument, true, false, false, false, false, false,
     false, false, CharSet.UTF_8);
   List<org.w3c.dom.Document> listResult = barcodeService.extractToXML(result, Delimiter.Carriage_Return,
     Delimiter.Tab, XMLFormat.XDP);
   log.debug("the form1 lenght is " + listResult.get(0).getElementsByTagName("form1").getLength());
   JSONObject decodedData = new JSONObject();
   decodedData.put("name", listResult.get(0).getElementsByTagName("Name").item(0).getTextContent());
   decodedData.put("address", listResult.get(0).getElementsByTagName("Address").item(0).getTextContent());
   decodedData.put("city", listResult.get(0).getElementsByTagName("City").item(0).getTextContent());
   decodedData.put("state", listResult.get(0).getElementsByTagName("State").item(0).getTextContent());
   decodedData.put("zipCode", listResult.get(0).getElementsByTagName("ZipCode").item(0).getTextContent());
   decodedData.put("country", listResult.get(0).getElementsByTagName("Country").item(0).getTextContent());
   log.debug("The JSON Object is " + decodedData.toString());
   return decodedData;
  } catch (Exception e) {
   // TODO Auto-generated catch block
   e.printStackTrace();
  }
  return null;
 }
```

The following is the servlet code. This servlet is called when the user adds an attachment to the Adaptive Form. The servlet returns the JSON object back to the calling application. The calling application then populates the Adaptive form with the values extracted from the JSON object.

```java {.line-numbers}
@Component(service = Servlet.class, property = {

  "sling.servlet.methods=get",

  "sling.servlet.paths=/bin/decodebarcode"

})
public class DecodeBarCode extends SlingSafeMethodsServlet {
 @Reference
 DocumentServices documentServices;
 @Reference
 GetResolver getResolver;
 private static final Logger log = LoggerFactory.getLogger(DecodeBarCode.class);
 private static final long serialVersionUID = 1L;

 protected void doGet(SlingHttpServletRequest request, SlingHttpServletResponse response) {
  ResourceResolver fd = getResolver.getFormsServiceResolver();
  Node pdfDoc = fd.getResource(request.getParameter("pdfPath")).adaptTo(Node.class);
  Document pdfDocument = null;
  log.debug("The path of the pdf I got was " + request.getParameter("pdfPath"));
  try {
   pdfDocument = new Document(pdfDoc.getPath());
   JSONObject decodedData = documentServices.extractBarCode(pdfDocument);
   response.setContentType("application/json");
   response.setHeader("Cache-Control", "nocache");
   response.setCharacterEncoding("utf-8");
   PrintWriter out = null;
   out = response.getWriter();
   out.println(decodedData.toString());
  } catch (RepositoryException | IOException e1) {
   // TODO Auto-generated catch block
   e1.printStackTrace();
  }

 }

}

```

The following code is part of the client library that is referenced by Adaptive Form. When a user adds the attachment to the adaptive form, this code will be triggered. The code makes a GET call to the servlet with the path of the attachment passed in the request parameter. The data received from the servlet call is then used to populate the adaptive form.

```
$(document).ready(function()
   {
       guideBridge.on("elementValueChanged",function(event,data){
             if(data.target.name=="fileAttachment")
         {
             window.guideBridge.getFileAttachmentsInfo({
        success:function(list) 
                 {
                     console.log(list[0].name + " "+ list[0].path);
                      const getFormNames = '/bin/decodebarcode?pdfPath='+list[0].path;
      $.getJSON(getFormNames, function (data) {
                            console.log(data);
                            var nameField = window.guideBridge.resolveNode("guide[0].guide1[0].guideRootPanel[0].Name[0]");
                            nameField.value = data.name;
                            var addressField = window.guideBridge.resolveNode("guide[0].guide1[0].guideRootPanel[0].Address[0]");
                            addressField.value = data.address;
                            var cityField = window.guideBridge.resolveNode("guide[0].guide1[0].guideRootPanel[0].City[0]");
                            cityField.value = data.city;
                            var stateField = window.guideBridge.resolveNode("guide[0].guide1[0].guideRootPanel[0].State[0]");
                            stateField.value = data.state;
                             var zipField = window.guideBridge.resolveNode("guide[0].guide1[0].guideRootPanel[0].Zip[0]");
                            zipField.value = data.zipCode;
                            var countryField = window.guideBridge.resolveNode("guide[0].guide1[0].guideRootPanel[0].Country[0]");
                            countryField.value = data.country;
                        });
                        }
                  });
             }
         });
        });

```

>[!NOTE]
>
>The Adaptive Form included with this package was built using AEM Forms 6.4. If you intend to use this package in AEM Forms 6.3 environment, please create the Adaptive Form in AEM Form 6.3

Line 12 - Custom code to get service resolver. This bundle is included as part of this articles assets.

Line 23 - Call the DocumentServices extractBarCode method to get the JSON object populated with decoded data

To get this running on your system, please follow the following steps

1. [Download BarcodeService.zip](assets/barcodeservice.zip) and import into AEM using the package manager
1. [Download and install the Custom DocumentServices Bundle](/help/forms/assets/common-osgi-bundles/AEMFormsDocumentServices.core-1.0-SNAPSHOT.jar)
1. [Download and install the DevelopingWithServiceUser Bundle](/help/forms/assets/common-osgi-bundles/DevelopingWithServiceUser.jar)
 1. [Download the sample PDF Form](assets/barcode.pdf)
1. Point your browser to the [sample adaptive form](http://localhost:4502/content/dam/formsanddocuments/barcodedemo/jcr:content?wcmmode=disabled)
1. Upload the sample PDF provided
1. You should see the forms populated with the data

