---
title: Create OSGi Service
description: Create OSGi service to store the forms to sign
feature: adaptive-forms
topics: development
audience: developer
doc-type: tutorial
activity: implement
version: 6.4,6.5
thumbnail: 6886.jpg
kt: 6886
---

# Create OSGi service

The following code was written to store the forms that need to be signed. Each form to sign is associated with a unique guid and a customer id. So one or more forms can be associated with the same customer ID, but will have a unique GUID assigned to the form.

## Interface

The following is the interface declaration that was used

```java
package com.aem.forms.signmultipleforms;
import com.adobe.granite.workflow.WorkflowSession;
import com.adobe.granite.workflow.exec.WorkItem;
public interface SignMultipleForms
{
    public void insertData(String []formNames,String formData,String serverURL,WorkItem workItem, WorkflowSession workflowSession);
    public String getNextFormToSign(int customerID);
    public void updateSignatureStatus(String formData,String guid);
    public String getFormData(String guid);
}

```



## Insert Data

The insert data method inserts a row in the database identified by the datasource. Each row in the database corresponds to a form and is uniquely identified by a GUID and customer id. The form data and the form URL are also stored in this row. The status column is to indicate if the form has been filled and signed. Value of 0 indicates the form is yet to be signed.

```java
@Override
public void insertData(String[] formNames, String formData, String serverURL, WorkItem workItem, WorkflowSession workflowSession) {
  String insertTableSQL = "INSERT INTO aemformstutorial.signingforms(formName,formData,guid,status,customerID) VALUES(?,?,?,?,?)";
  Random r = new Random();
  Connection con = getConnection();
  PreparedStatement pstmt = null;
  int customerIDGnerated = r.nextInt((1000 - 1) + 1) + 1;
  log.debug("The number of forms to insert are  " + formNames.length);
  try {
    for (int i = 0; i < formNames.length; i++) {
      log.debug("Inserting form name " + formNames[i]);
      UUID uuid = UUID.randomUUID();
      String randomUUIDString = uuid.toString();
      String formUrl = serverURL + "/content/dam/formsanddocuments/formsandsigndemo/" + formNames[i] + "/jcr:content?wcmmode=disabled&guid=" + randomUUIDString + "&customerID=" + customerIDGnerated;
      pstmt = con.prepareStatement(insertTableSQL);
      pstmt.setString(1, formUrl);
      pstmt.setString(2, formData.replace("<guid>3938</guid>", "<guid>" + uuid + "</guid>"));
      pstmt.setString(3, uuid.toString());
      pstmt.setInt(4, 0);
      pstmt.setInt(5, customerIDGnerated);
      log.debug("customerIDGnerated the insert statment  " + pstmt.execute());
      if (i == 0) {
        WorkflowData wfData = workItem.getWorkflowData();
        wfData.getMetaDataMap().put("formURL", formUrl);
        workflowSession.updateWorkflowData(workItem.getWorkflow(), wfData);
        log.debug("$$$$ Done updating the map");

}

}
    con.commit();
  }
  catch(Exception e) {
    log.debug(e.getMessage());
  }
  finally {
    if (pstmt != null) {
      try {
        pstmt.close();
      } catch(SQLException e) {

log.debug(e.getMessage());
      }
    }
    if (con != null) {
      try {
        con.close();
      } catch(SQLException e) {
        log.debug(e.getMessage());
      }
    }
  }

}

```


## Get Form Data

The following code is used to fetch adaptive form data associated with the given GUID. The form data is then used to pre-populate the adaptive form.

```java
@Override
public String getFormData(String guid) {
  log.debug("### Getting form data asscoiated with guid " + guid);
  Connection con = getConnection();
  try {
    Statement st = con.createStatement();
    String query = "SELECT formData FROM aemformstutorial.signingforms where guid = '" + guid + "'" + "";
    log.debug(" The query being consrtucted " + query);
    ResultSet rs = st.executeQuery(query);
    while (rs.next()) {
      return rs.getString("formData");
    }
  } catch(SQLException e) {
    // TODO Auto-generated catch block
    log.debug(e.getMessage());
  }

  return null;

}
```

## Update Signature Status

Successful completion of the signing ceremony triggers an AEM workflow associated with the form. The first step in the workflow is a process step which updates the  status in the database for the row identified by the guid and customer id. We also set the value of the signed element in the formdata to Y to indicate that the form has been filled and signed. The adaptive form will be populated with this data and the value of the signed data element in the xml data will be used to display the appropriate message. The updateSignatureStatus code is invoked from the custom process step.


```java
public void updateSignatureStatus(String formData, String guid) {
  String updateStatment = "update aemformstutorial.signingforms SET formData = ?, status = ? where guid = ?";
  PreparedStatement updatePS = null;
  Connection con = getConnection();
  try {
    updatePS = con.prepareStatement(updateStatment);
    updatePS.setString(1, formData.replace("<signed>N</signed>", "<signed>Y</signed>"));
    updatePS.setInt(2, 1);
    updatePS.setString(3, guid);
    log.debug("Updated the signature status " + String.valueOf(updatePS.execute()));
  } catch(SQLException e) {
    log.debug(e.getMessage());
  }
  finally {
    try {
      con.commit();
      updatePS.close();
      con.close();
    } catch(SQLException e) {
      
      log.debug(e.getMessage());
    }

  }

}
```

## Get next form to sign

The following code was used to get the next form for signing for a given customerID with a status of 0. If the sql query does not return any rows we return the string **"AllDone"** which indicates that there are no more forms for signing for the given customer id.

```java
@Override
public String getNextFormToSign(int customerID) {
  System.out.println("### inside my next form to sign " + customerID);
  String selectStatement = "SELECT formName FROM aemformstutorial.signingforms where status = 0 and customerID=" + customerID;
  Connection con = getConnection();
  try
   {
    Statement st = con.createStatement();
    ResultSet rs = st.executeQuery(selectStatement);
    while (rs.next()) {
      log.debug("Got result set object");
      return rs.getString("formName");
    }
    if (!rs.next()) {
      return "AllDone";
    }
  } catch(SQLException e) {
    log.debug(e.getMessage());
  }
  finally {
    try {
      con.close();
    } catch(SQLException e) {
      // TODO Auto-generated catch block
      log.debug(e.getMessage());
    }
  }

  return null;

}
```



## Assets

The OSGi bundle with the above mentioned services can be [downloaded from here](assets/sign-multiple-forms.jar)