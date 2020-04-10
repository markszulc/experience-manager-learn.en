---
title: Understanding InDesign files and Asset Templates in AEM Assets 
description: This video tutorial walks through defining an InDesign file, and all the accompanying considerations, for use in AEM Assets' Asset Templates feature.
feature: catalogs, asset-templates
topics: authoring, renditions, documents
audience: all
doc-type: tutorial
activity: understand
version: 6.3, 6.4, 6.5
---

# Understanding InDesign files and Asset Templates in AEM Assets {#understanding-indesign-files-and-asset-templates-in-aem-assets}

This video tutorial walks through defining an InDesign file, and all the accompanying considerations, for use in AEM Assets' Asset Templates feature.

## Constructing the InDesign template file {#constructing-the-indesign-template-file}

>[!VIDEO](https://video.tv.adobe.com/v/19293/?quality=9)

1. Download and Open the [**InDesign file template**](assets/asset-templates-tutorial-video--supporting-files.zip)
2. **Open the Tags panel,** review the Tag naming convention, and note that the author-able elements in the InDesign file are already tagged. Remember, only tagged elements are editable in AEM.

    * **Window &gt; Utilities &gt; Tags**

3. On Page, Add a new text element, provide the text "Header" and apply the **Heading** Paragraph Style.

    * **Window &gt; Styles &gt; Paragraph Styles**

   Then, create and apply a new Tag named **Page2Heading.**

4. Add the FPO Logo image ([provided in the zip](assets/asset-templates-tutorial-video--supporting-files.zip)) to the Logo element on the Master page.

    * **Right click **and select** Fitting &gt; Frame Fitting Options... &gt; Content Fitting &gt; Fill Frame Proportionally**

   [Learn more about Frame Fitting options](https://helpx.adobe.com/indesign/using/frames-objects.html#fitting_objects_to_frames), and which is right for your use case.

5. Copy down the header (Logo and Company Name) from the Master template in Page and Page via Paste In Place.

    * On Page 1, Shift-Cmd-Click on macOS or Shift-Alt-Click on Windows, to select the Header exposed from the Master page, and delete it.
    * From the Master page, copy the header into Page 1 via Paste in Place
    * Repeat the steps for Page 2

6. Open the Structure panel, by double-clicking on each, ensure all structural elements correspond to real elements in the InDesign file. Remove any un-used or un-needed elements. Ensure all tagging is semantic and elements are tagged properly.

   >[!NOTE]
   >
   >Remember, a poorly constructed InDesign file is the most common cause for issues with AEM Asset Templates, so ensure the tagging and structure is clean and correct.

## Creating and authoring an Asset Template in AEM Assets {#creating-and-authoring-an-asset-template-in-aem-assets}

>[!VIDEO](https://video.tv.adobe.com/v/19294/?quality=9)

1. **Start InDesign Server** on port 8080.
2. Ensure the **AEM Author instance is configured to interact with your InDesign Server**(and vice-versa).

    * [IDS Worker Cloud Service configuration](http://localhost:4502/etc/cloudservices/proxy/ids.html)
    * [Cloud Proxy Cloud Service configuration](http://localhost:4502/etc/cloudservices/proxy.html)
    * [AEM Externalizer OSGi configuration](http://localhost:4502/system/console/configMgr)

3. **Uploaded the InDesign file to AEM Assets** and allow AEM Workflow and InDesign Server to fully process the assets.
4. **Create a new Template** under **Assets &gt; Templates** and select the InDesign file uploaded to AEM in Step #4.  
5. **Edit the Asset Template** created in Step #5, and author the editable fields.
6. Click **Done** to generate the final high-fidelity renditions of the Asset Template.
7. Click on the Asset Template card to open, and review the Asset Renditions to download the high-fidelity renditions.

## Additional Resources {#additional-resources}

InDesign template file and supporting Images

Download [InDesign template file and supporting Images](assets/asset-templates-tutorial-video--supporting-files-1.zip)

* [InDesign CC trial download](https://creative.adobe.com/products/download/indesign)
* [InDesign Server trial download](https://www.adobe.com/devnet/indesign/indesign-server-trial-downloads.html)
