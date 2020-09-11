---
title: Using functions and code editor
seo-title: Using functions and code editor
description: Using functions and code editor to author business rule
seo-description: Using functions and code editor to author business rule
uuid: 578e91f8-0d93-4192-b7af-1579df2feaf8
feature: adaptive-forms
topics: authoring
audience: developer
doc-type: tutorial
activity: understand
version: 6.4,6.5
discoiquuid: f480ef3e-7e38-4a6b-a223-c102787aea7f
kt: 4270
thumbnail: 22282.jpg
---

# Using custom functions and code editor {#using-functions-and-code-editor}

In this part, we will use custom functions and the code editor to author business rules.

you have already installed the [ClientLib with custom function](assets/client-libs-and-logo.zip) earlier in this tutorial.

Typically a client library consists of CSS and Javascript file. This client library contains javascript file which exposes a function to populate drop-down list values.


## Function to Populate Drop Down List {#function-to-populate-drop-down-list}

>[!VIDEO](https://video.tv.adobe.com/v/22282?quality=9&learn=on)

### Set Summary Title of Panel {#set-the-summary-title-of-panels}

>[!VIDEO](https://video.tv.adobe.com/v/28387?quality=9&learn=on)

#### Validate Panel {#validate-panels-using-rule-editor}

>[!VIDEO](https://video.tv.adobe.com/v/28409?quality=9&learn=on)

The following is the code used to validate panel fields

```javascript
//debugger;
var errors =[];
var fields ="";
var currentPanel = guideBridge.getFocus({"focusOption": "navigablePanel"});
window.guideBridge.validate(errors,currentPanel);
console.log("The errors are "+ errors.length);
if(errors.length===0)
{
        window.guideBridge.setFocus(this.panel.somExpression, 'nextItem', true);
}
else
  {
    for(var i=0;i<errors.length;i++)
      {
        var fields = fields+guideBridge.resolveNode(errors[i].som).title+" , ";
      }
        window.confirm("Please fill out  "+fields.slice(0,-1)+ " fields");
  }
```

You can uncomment line 1 to  debug  the code in  browser  window.

Line 4 - Get the current panel

Line 5 - Validate the current panel.

Line 9 - If no errors move to the next panel

Preview the form, and test the newly enabled functionality.
