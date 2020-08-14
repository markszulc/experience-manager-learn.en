---
title: Trigger AEM workflow on HTM5 Form Submission
seo-title: Trigger AEM Workflow on HTML5 Form Submission
description: Continue filling mobile form in offline mode and submit mobile form to trigger AEM workflow
seo-description: Continue filling mobile form in offline mode and submit mobile form to trigger AEM workflow
feature: mobile-forms
topics: development
audience: developer
doc-type: article
activity: implement
version: 6.4, 6.5
---

# Create Custom Profile

In this part we will create a [custom profile.](https://helpx.adobe.com/livecycle/help/mobile-forms/creating-profile.html) A profile is responsible for rendering the XDP as HTML. A default profile is provided out of the box for rendering XDP's as HTML. It represents a customized version of Mobile Forms Rendition service. You can use the Mobile Form Rendition service to customize appearance, behavior, and interactions of the Mobile Forms. In our custom profile we will capture the data filled in the mobile form using the guidebridge API. This data is then sent to custom servlet that will then generate an interactive PDF and stream it back to the calling application.

Get the form data using the `formBridge` JavaScript API. We make use of the `getDataXML()` method:

```javascript
window.formBridge.getDataXML({success:suc,error:err});
```

In the success handler method we make a call to custom servlet running in AEM. This servlet will render and return interactive pdf with the data from the mobile form

```javascript
var suc = function(obj) {
    let xhr = new XMLHttpRequest();
    var data = obj.data;
    console.log("The data: " + data);
    xhr.open('POST','/bin/generateinteractivepdf');
    xhr.responseType = 'blob';
    let formData = new FormData();
    formData.append("formData", data);
    formData.append("xdpPath", window.location.pathname);
    xhr.send(formData);
    xhr.onload = function(e) {
        
        console.log("The data is ready");
        if (this.status == 200) {
            var blob = new Blob([this.response],{type:'image/pdf'});
                let a = document.createElement("a");
                a.style = "display:none";
                document.body.appendChild(a);
                let url = window.URL.createObjectURL(blob);
                a.href = url;
                a.download = "schengenvisaform.pdf";
                a.click();
                window.URL.revokeObjectURL(url);
        }
    }
}
```

## Generate Interactive PDF

The following is the servlet code that is responsible for rendering interactive pdf and returning the pdf to the calling application. The servlet invokes `mobileFormToInteractivePdf` method of the custom DocumentServices OSGi service.

```java
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.PrintWriter;

import javax.servlet.Servlet;

import org.apache.sling.api.SlingHttpServletRequest;
import org.apache.sling.api.SlingHttpServletResponse;
import org.apache.sling.api.servlets.SlingAllMethodsServlet;

import org.osgi.service.component.annotations.Component;
import org.osgi.service.component.annotations.Reference;

import com.adobe.aemfd.docmanager.Document;
import com.aemformssamples.documentservices.core.DocumentServices;

@Component(
  service = { Servlet.class }, 
  property = { 
    "sling.servlet.methods=post",
    "sling.servlet.paths=/bin/generateinteractivepdf" 
  }
)
public class GenerateInteractivePDF extends SlingAllMethodsServlet {
    @Reference
    DocumentServices documentServices;

    protected void doGet(SlingHttpServletRequest request, SlingHttpServletResponse response) { 
       doPost(request, response);
    }

    protected void doPost(SlingHttpServletRequest request, SlingHttpServletResponse response) {
      String dataXml = request.getParameter("formData");
      org.w3c.dom.Document xmlDataDoc = documentServices.w3cDocumentFromStrng(dataXml);
      Document xmlDocument = documentServices.orgw3cDocumentToAEMFDDocument(xmlDataDoc);
      Document generatedPDF = documentServices.mobileFormToInteractivePdf(xmlDocument,request.getParameter("xdpPath"));
      try {
          InputStream fileInputStream = generatedPDF.getInputStream();
          response.setContentType("application/pdf");
          response.addHeader("Content-Disposition", "attachment; filename=AemFormsRocks.pdf");
          response.setContentLength((int) fileInputStream.available());
          OutputStream responseOutputStream = response.getOutputStream();
          int bytes;
          while ((bytes = fileInputStream.read()) != -1) {
              responseOutputStream.write(bytes);
          }
          responseOutputStream.flush();
          responseOutputStream.close();
      } catch (IOException e) {
        // TODO Add proper error logging
      }
    }
}
```

### Render Interactive PDF

The following code makes use of the [Forms Service API](https://helpx.adobe.com/aem-forms/6/javadocs/com/adobe/fd/forms/api/FormsService.html) to render interactive PDF with the data from the mobile form.

```java
public Document mobileFormToInteractivePdf(Document xmlData,String path) {
    // In mobile form to interactive pdf
    
    String uri = "crx:///content/dam/formsanddocuments";
    String xdpName = path.substring(31,path.lastIndexOf("/jcr:content"));
    PDFFormRenderOptions renderOptions = new PDFFormRenderOptions();
    renderOptions.setAcrobatVersion(AcrobatVersion.Acrobat_11);
    renderOptions.setContentRoot(uri);
    Document interactivePDF = null;

    try {
        interactivePDF = formsService.renderPDFForm(xdpName, xmlData, renderOptions);
    } catch (FormsServiceException e) {
        // TODO Add proper error logging
    }
    
    return interactivePDF;
}
```

To view the ability to download interactive PDF from partially completed mobile form, [please click here](https://forms.enablementadobe.com/content/dam/formsanddocuments/schengen.xdp/jcr:content).
Once the PDF is downloaded, the next step is to submit the PDF to trigger an AEM workflow. This workflow will merge the data from the submitted PDF and generate non-interactive PDF for review.

The custom profile created for this use case is available as part of this tutorial assets.
