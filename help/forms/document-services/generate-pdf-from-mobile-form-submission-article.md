---
title: Generate PDF from HTM5 Form Submission
seo-title: Generate PDF from HTML5 Form Submission
description: Generate PDF from Mobile Form submission
seo-description: Generate PDF from Mobile Form submission
uuid: 61f07029-d440-44ec-98bc-f2b5eef92b59
feature: mobile-forms
topics: development
audience: developer
doc-type: article
activity: implement
version: 6.4,6.5

discoiquuid: 816f1a75-6ceb-457b-ba18-daf229eed057
---

# Generate PDF from HTM5 Form Submission {#generate-pdf-from-htm-form-submission}

This article will walk you through the steps involved in generating pdf from an HTML5(aka Mobile Forms) form submission. This demo will also explain the steps needed to add an image to HTML5 form and merge the image into the final pdf.

To see a live demonstration of this capability please visit the [sample server](https://forms.enablementadobe.com/content/samples/samples.html?query=0) and search for "Mobile Form To PDF".

To merge the submitted data into the  xdp  template we do the following

Write a servlet to handle the HTML5 form submission

* Inside this servlet get hold of the submitted data
* Merge this data with the  xdp  template to generate pdf
* Stream the pdf back to the calling application

The following is the servlet code which extracts the submitted data from the request. It then calls the custom  documentServices .mobileFormToPDF method to get the pdf.

```java {.line-numbers}
protected void doPost(SlingHttpServletRequest request, SlingHttpServletResponse response) {
  StringBuffer stringBuffer = new StringBuffer();
  String line = null;
  try {
   InputStreamReader isReader = new InputStreamReader(request.getInputStream(), "UTF-8");
   BufferedReader reader = new BufferedReader(isReader);
   while ((line = reader.readLine()) != null)
    stringBuffer.append(line);
  } catch (Exception e) {
   System.out.println("Error");
  }
  String xmlData = new String(stringBuffer);
  Document generatedPDF = documentServices.mobileFormToPDF(xmlData);
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
   // TODO Auto-generated catch block
   e.printStackTrace();
  }

 }

```

To add  image  to mobile form and display that image in the pdf we have used the following

XDP Template - In the  xdp  template we added an image field and button called btnAddImage. The following code handles the click event of the btnAddImage in our  custom  profile. As you can see we trigger the file1 click event. No coding is needed in the  xdp  to accomplish this use case

``` javascript

$(".btnAddImage").click(function(){

$("#file1").click();

});
```

[Custom Profile](https://helpx.adobe.com/livecycle/help/mobile-forms/creating-profile.html#CreatingCustomProfiles). Using custom profile it makes it easier to manipulate HTML DOM objects of the mobile form. A hidden file element is added to the HTML.jsp. When the user clicks on "Add Your Photo" we trigger the click event of the file element. This allows the user to browse and select the photograph to attach. We then use javascript FileReader object to get the base64 encoded string of the image. The base64 image string is stored in the text field in the form. When the form is submitted we extract this value and insert it in the  img  element of the XML. This XML is then used to merge with the  xdp  to generate the final pdf.

The custom profile used for this article has been made available to you as part of this article's assets.

```javascript
function readURL(input) {
            if (input.files && input.files[0]) {
                var reader = new FileReader();
                reader.onload = function (e) {
                  window.formBridge.setFieldValue("xfa.form.topmostSubform.Page1.base64image",reader.result);
                    $('.img img').show();
                     $('.img img')
                        .attr('src', e.target.result)
                        .width(180)
                        .height(200)
                };

                reader.readAsDataURL(input.files[0]);
            }
        }

```

The above code is executed when we trigger the click event of the file element. Line 5 we extract the content of the uploaded file as base64 string and store in the text field. This value is then extracted when the form is submitted to our servlet.

We then configure the following properties(advanced) of our mobile form in AEM

* Submit URL - http://localhost:4502/bin/handlemobileformsubmission. This is our servlet that will merge the submitted data with the xdp template
* HTML Render Profile - Make sure you select "AddImageToMobileForm". This will trigger the code to add image to the form.

To test this capability on your own server please follow the following steps:

* [Deploy the AemFormsDocumentServices bundle](/help/forms/assets/common-osgi-bundles/AEMFormsDocumentServices.core-1.0-SNAPSHOT.jar)

* [Deploy the Developing with Service User bundle](/help/forms/assets/common-osgi-bundles/DevelopingWithServiceUser.jar)

* [Download and install the package associated with this article.](assets/pdf-from-mobile-form-submission.zip)

* Make sure the submit URL and HTML Render profile are set correctly by viewing the properties page of the  [xdp](http://localhost:4502/libs/fd/fm/gui/content/forms/formmetadataeditor.html/content/dam/formsanddocuments/schengen.xdp)

* [Preview the XDP as html](http://localhost:4502/content/dam/formsanddocuments/schengen.xdp/jcr:content)

* Add an image to the form and submit. You should get PDF back with the image in it.

