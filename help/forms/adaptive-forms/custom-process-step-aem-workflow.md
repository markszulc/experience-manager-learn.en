---
title: Implementing Custom Process Step
seo-title: Implementing Custom Process Step
description: Writing Adaptive Form attachments to file system using custom process step
seo-description: Writing Adaptive Form attachments to file system using custom process step
feature: workflow
topics: development
audience: developer
doc-type: tutorial
activity: understand
version: 6.5
---

# Custom Process Step

This tutorial is intended for AEM Forms customers needing to implement custom process step. A process step can execute ECMA script or call custom java code to perform operations. This tutorial will explain the steps needed to implement WorkflowProcess that gets executed by the process step.

The main reason for implementing custom process step is to extend the AEM Workflow. For example, if you are using AEM Forms components in your workflow model, you may want to perform the following operations

* Save the Adaptive Form attachment(s) to the file system
* Manipulate the submitted data

To accomplish the above use case, you will typically write an OSGi service that gets executed by the process step.

## Create Maven Project

The first step is to create an maven project using the appropriate Adobe Maven Archetype. The detailed steps are listed in this [article](https://helpx.adobe.com/experience-manager/using/maven_arch13.html). Once you have your maven project imported into eclipse, you are ready to start writing your first OSGi component that can be used in your process step.


### Create class that implements WorkflowProcess

Open the maven project in your eclipse IDE. Expand **projectname** > **core** folder. Expand the src/main/java folder. You should see a package that ends with "core". Create Java class that implements WorkflowProcess in this package. You will need to override execute method. The signature of execute method is as follows
public void execute(WorkItem workItem, WorkflowSession workflowSession, MetaDataMap processArguments)throws WorkflowException 
The execute method gives access to the following 3 variables

**WorkItem**: The workItem variable will give access to data related to workflow. The public API documentation is available [here.](https://helpx.adobe.com/experience-manager/6-3/sites/developing/using/reference-materials/diff-previous/changes/com.adobe.granite.workflow.WorkflowSession.html)

 **WorkflowSession**: This workflowSession variable will give you the ability to control workflow. The public API documentation is available [here](https://helpx.adobe.com/experience-manager/6-3/sites/developing/using/reference-materials/diff-previous/changes/com.adobe.granite.workflow.WorkflowSession.html)

 **MetaDataMap**: All the metadata associated with the workflow. Any process arguments that are passed to the process step are available using the MetaDataMap object.[API Documentation](https://helpx.adobe.com/experience-manager/6-5/sites/developing/using/reference-materials/javadoc/com/adobe/granite/workflow/metadata/MetaDataMap.html)

In this tutorial, we are going to write the attachments added to Adaptive Form to the file system as part of the AEM Workflow.

To accomplish this use case, the following java class was written

Let's take a look at this code

```

@Component(property = { Constants.SERVICE_DESCRIPTION + "=Write Adaptive Form Attachments to File System",
        Constants.SERVICE_VENDOR + "=Adobe Systems",
        "process.label" + "=Save Adaptive Form Attachments to File System" })
public class WriteFormAttachmentsToFileSystem implements WorkflowProcess {
     private static final Logger log = LoggerFactory.getLogger(WriteFormAttachmentsToFileSystem.class);
     @Override
    public void execute(WorkItem workItem, WorkflowSession workflowSession, MetaDataMap processArguments)
            throws WorkflowException {
        // TODO Auto-generated method stub
        log.debug("The string I got was ..." + processArguments.get("PROCESS_ARGS", "string").toString());
        String[] params = processArguments.get("PROCESS_ARGS", "string").toString().split(",");
        String attachmentsPath = params[0];
        String saveToLocation = params[1];
        log.debug("The seperator is" + File.separator);
        String payloadPath = workItem.getWorkflowData().getPayload().toString();
 
        String attachmentsFilePath = payloadPath + "/" + attachmentsPath + "/attachments";
        log.debug("The data file path is " + attachmentsFilePath);
 
        ResourceResolver resourceResolver = workflowSession.adaptTo(ResourceResolver.class);
 
        Resource attachmentsNode = resourceResolver.getResource(attachmentsFilePath);
        Iterator<Resource> attachments = attachmentsNode.listChildren();
        while (attachments.hasNext()) {
            Resource attachment = attachments.next();
            String attachmentPath = attachment.getPath();
            String attachmentName = attachment.getName();
 
            log.debug("The attachmentPath is " + attachmentPath + " and the attachmentname is " + attachmentName);
            com.adobe.aemfd.docmanager.Document attachmentDoc = new com.adobe.aemfd.docmanager.Document(attachmentPath,
                    attachment.getResourceResolver());
            try {
                File file = new File(saveToLocation + File.separator + workItem.getId());
                if (!file.exists()) {
                    file.mkdirs();
                }
 
                attachmentDoc.copyToFile(new File(file + File.separator + attachmentName));
 
                log.debug("Saved attachment" + attachmentName);
                attachmentDoc.close();
 
            } catch (IOException e) {
                // TODO Auto-generated catch block
                e.printStackTrace();
            }
 
        }
 
    }

```

Line 1 - defines the properties for our component. The process.label property is what you will see when associating OSGi component with the process step as shown in one of the screenshots below.

Lines 13-15 - The process arguments passed to this OSGi component are split using the "," separator. The values for attachmentPath and saveToLocation are then extracted from the string array.

* attachmentPath - This is the same location that you have specified in the Adaptive Form when you configured the submit action of Adaptive Form to invoke AEM Workflow. This is a name of the folder that you want the attachments to be saved in AEM relative to the payload of the workflow.

* saveToLocation - This is the location that you want the attachments to be saved on your AEM server's file system.

These two values are passed as process arguments as shown in the screenshot below.

![ProcessStep](assets/implement-process-step.gif)


Line 19: we then construct the attachmentFilePath. The attachment file path is like

    /var/fd/dashboard/payload/server0/2018-11-19/3EF6ENASOQTHCPLNDYVNAM7OKA_7/Attachments/attachments

* The "Attachments" is the name of the folder relative to workflow's payload that was specified when you configured the Adaptive Form's submit option.

    ![submitoptions](assets/af-submit-options.gif)

Lines 24-26 - Get ResourceResolver and then the resource pointing to the attachmentFilePath.

The rest of the code creates Document objects by iterating through the child object of the resource pointing to attachmentFilePath using the API. This document object is specific to AEM Forms. We then use the copyToFile method of the document object to save the document object.

>[!NOTE]
>
>Since we are using Document object which is specific to AEM Forms, it is required that you include the aemfd-client-sdk dependency in your maven project. The group Id is com.adobe.aemfd and artefact id is aemfd-client-sdk.

#### Build and Deploy

[Build the bundle as described here](https://helpx.adobe.com/experience-manager/using/maven_arch13.html#BuildtheOSGibundleusingMaven)
[Make sure the bundle is deployed and in active state](http://localhost:4502/system/console/bundles)

Create a workflow model. Drag and drop process step in the workflow model. Associate the process step with "Save Adaptive Form Attachments to File System".

Provide the necessary process arguments separated by a comma. For example Attachments,c:\\scrappp\\. The first argument is the folder when your Adaptive Form attachments are going to be stored relative to the workflow payload. This has to be the same value you specified when configuring the submit action of Adaptive Form. The second argument is the location when you want the attachments to be stored.

Create an Adaptive Form. Drag and drop File Attachments component on to the form. Configure submit action of the form to invoke the workflow created in the earlier steps. Provide the appropriate attachment path.

Save the settings.

Preview the form. Add a couple of attachments and submit the form. The attachments should get saved to the file system in the location specified by you in the workflow.

