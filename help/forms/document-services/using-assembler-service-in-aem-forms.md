---
title: Using Assembler Service in AEM Forms
seo-title: Using Assembler Service in AEM Forms
description: Using Assembler Service in AEM Forms to assemble multiple pdf files
seo-description: Using Assembler Service in AEM Forms to assemble multiple pdf files
uuid: 7895b1a3-6f9d-4413-bb7f-692ea0380fcd
feature: assembler
topics: development
audience: developer
doc-type: article
activity: implement
version: 6.4,6.5
discoiquuid: a12f52af-7039-4452-a58d-9ad2c0096347
---

# Using Assembler Service in AEM Forms{#using-assembler-service-in-aem-forms}

This article provides you the assets for demonstrating the ability to drag and drop multiple PDF files into the browser and save the assembled pdf file to your file system. The following is the code for the servlet which assembles the pdf files uploaded using the browser.

```java

protected void doPost(SlingHttpServletRequest request, SlingHttpServletResponse response) {
        log.debug("In Assemble Uploaded Files");
 
        Map<String, Object> mapOfDocuments = new HashMap<String, Object>();
        final boolean isMultipart = org.apache.commons.fileupload.servlet.ServletFileUpload.isMultipartContent(request);
        DocumentBuilderFactory docFactory = DocumentBuilderFactory.newInstance();
        DocumentBuilder docBuilder = null;
        try {
            docBuilder = docFactory.newDocumentBuilder();
        } catch (ParserConfigurationException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        org.w3c.dom.Document ddx = docBuilder.newDocument();
        Element rootElement = ddx.createElementNS("http://ns.adobe.com/DDX/1.0/", "DDX");
 
        ddx.appendChild(rootElement);
        Element pdfResult = ddx.createElement("PDF");
        pdfResult.setAttribute("result", "GeneratedDocument.pdf");
        rootElement.appendChild(pdfResult);
        if (isMultipart) {
            final java.util.Map<String, org.apache.sling.api.request.RequestParameter[]> params = request
                    .getRequestParameterMap();
            for (final java.util.Map.Entry<String, org.apache.sling.api.request.RequestParameter[]> pairs : params
                    .entrySet()) {
                final String k = pairs.getKey();
 
                final org.apache.sling.api.request.RequestParameter[] pArr = pairs.getValue();
                final org.apache.sling.api.request.RequestParameter param = pArr[0];
 
                try {
                    if (!param.isFormField()) {
                        final InputStream stream = param.getInputStream();
                        log.debug("the file name is " + param.getFileName());
                        log.debug("Got input Stream inside my servlet####" + stream.available());
                        com.adobe.aemfd.docmanager.Document document = new Document(stream);
                        mapOfDocuments.put(param.getFileName(), document);
                        org.w3c.dom.Element pdfSourceElement = ddx.createElement("PDF");
                        pdfSourceElement.setAttribute("source", param.getFileName());
                        pdfSourceElement.setAttribute("bookmarkTitle", param.getFileName());
                        pdfResult.appendChild(pdfSourceElement);
                        log.debug("The map size is " + mapOfDocuments.size());
                    } else {
                        log.debug("The form field is" + param.getString());
 
                    }
                } catch (IOException e) {
                    // TODO Auto-generated catch block
                    e.printStackTrace();
                }
 
            }
        }
 
        com.adobe.aemfd.docmanager.Document ddxDocument = documentServices.orgw3cDocumentToAEMFDDocument(ddx);
        Document assembledDocument = documentServices.assembleDocuments(mapOfDocuments, ddxDocument);
        String path = documentServices.saveDocumentInCrx("/content/ocrfiles", assembledDocument);
        JSONObject jsonObject = new JSONObject();
        try {
            jsonObject.put("path", path);
            response.setContentType("application/json");
            response.setHeader("Cache-Control", "nocache");
            response.setCharacterEncoding("utf-8");
            PrintWriter out = null;
            out = response.getWriter();
            out.println(jsonObject.toString());
 
        } catch (JSONException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        } catch (IOException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
 
    }
 
}

```

To get this capability working on your AEM Server

* Download the [AssembleMultipleFiles.zip](assets/assemble-multiple-files.zip) to your local system.
* Upload and install the package using the [package manager](http://localhost:4502/crx/packmgr/index.jsp)
* Download[Custom Document Services Bundle](/help/forms/assets/common-osgi-bundles/AEMFormsDocumentServices.core-1.0-SNAPSHOT.jar)
* Download [Developing with Service User Bundle](/help/forms/assets/common-osgi-bundles/DevelopingWithServiceUser.jar)
* Deploy and start the bundles using the [felix web console](http://localhost:4502/system/console/bundles)
* Point your browser to [AssemblePdfs.html](http://localhost:4502/content/DocumentServices/AssemblePdfs.html)
* Drag and Drop a couple of files of PDF files

>[!NOTE]
>
>Make sure your AEM Forms install is complete. All your bundles need to be in active state.
>
>Make sure you have added - Boot delegate RSA and BouncyCastle libraries as mentioned in this [Installing AEM Forms](https://helpx.adobe.com/aem-forms/6-3/installing-configuring-aem-forms-osgi.html)
>
>**Caveats for this Demo**
>
> * The code does not handle XFA based PDF documents
>
> * Make sure you drag and drop PDF files only
>
>




