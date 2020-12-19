---
title: Useful utility services
description: Some useful utility services for AEM Forms developer
feature: document-services
topics: development
audience: developer
doc-type: article
activity: implement
version: 6.4,6.5
---

# Useful utility services

This sample bundle provides useful utility services that can be used by an AEM Forms developer. The following services are available.


```java
package aemformsutilityfunctions.core;
import java.util.Map;
import com.adobe.aemfd.docmanager.Document;
public interface AemformsUtilities
{
public abstract com.adobe.aemfd.docmanager.Document createDDXFromMapOfDocuments(Map<String, com.adobe.aemfd.docmanager.Document> paramMap);
public abstract org.w3c.dom.Document w3cDocumentFromStrng(String xmlString);
public abstract com.adobe.aemfd.docmanager.Document orgw3cDocumentToAEMFDDocument(org.w3c.dom.Document xmlDocument);
public abstract String saveDocumentInCrx(String jcrPath,String fileExtension, Document documentToSave);

}

```

The sample bundle can be [downloaded from here](assets/aemformsutilityfunctions.aemformsutilityfunctions.core-1.0-SNAPSHOT.jar)

## Sample Code to use the utility service(s)

The following is the code that was used in jsp page to create org.w3c.dom.document from string and convert the document and store it in the CRX repository as shown in the following code snippet.

```java
 aemformsutilityfunctions.core.AemformsUtilities aemFormsUtilities = sling.getService(aemformsutilityfunctions.core.AemformsUtilities.class);
com.adobe.aemfd.docmanager.Document xmlStringDoc = aemFormsUtilities.orgw3cDocumentToAEMFDDocument(aemFormsUtilities.w3cDocumentFromStrng("<data><fname>Girish</fname></data>"));
aemFormsUtilities.saveDocumentInCrx("/content/ocrfiles",".xml",xmlStringDoc);
```

## Prerequisites


You will need to deploy [DevelopingWithServiceUserBundle](https://experienceleague.adobe.com/docs/experience-manager-learn/assets/DevelopingWithServiceUser.jar?lang=en) and start the bundle.


If you are going to save documents in the CRX repository using these utility service, please create a [service user and provide the necessary permissions to the service user as mentioned in the document](https://experienceleague.adobe.com/docs/experience-manager-learn/forms/adaptive-forms/service-user-tutorial-develop.html?lang=en#adaptive-forms)


