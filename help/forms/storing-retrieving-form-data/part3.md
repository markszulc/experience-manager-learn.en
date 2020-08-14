---
title: Storing and Retrieving Form Data from MySQL Database
description: Multi-Part tutorial to walk you through the steps involved in storing and retrieving form data
feature: adaptive-forms
topics: development
audience: developer
doc-type: tutorial
activity: implement
version: 6.3,6.4,6.5
---

# Create OSGI Service to fetch data

The following code was written to fetch the stored Adaptive Form data. A simple query is used to fetch the Adaptive Form data associated with a given GUID. The fetched data is then returned to the calling application. The same data source created in the first step is referenced in this code.


```java
package com.techmarketing.core.impl;

import com.techmarketing.core.AemFormsAndDB;
import org.osgi.service.component.annotations.Component;
import org.osgi.service.component.annotations.Reference;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.sql.DataSource;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

@Component(
        service = AemFormsAndDB.class
)
public class AemformWithDB implements AemFormsAndDB {
    private final Logger log = LoggerFactory.getLogger(getClass());
   
    @Reference(target = "(&(objectclass=javax.sql.DataSource)(datasource.name=aemformstutorial))")
    private DataSource dataSource;

    @Override
    public String getData(String guid) {
        log.debug("### inside my getData of AemformWithDB");
        Connection con = getConnection();
        try {
            Statement st = con.createStatement();
            String query = "SELECT afdata FROM aemformstutorial.formdata where guid = '" + guid + "'" + "";
            log.debug(" The query is " + query);
            ResultSet rs = st.executeQuery(query);
            while (rs.next()) {
                return rs.getString("afdata");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public Connection getConnection() {
        log.debug("Getting Connection ");
        Connection con = null;
        try {
            con = dataSource.getConnection();
            log.debug("got connection");
            return con;
        } catch (Exception e) {
            log.debug("not able to get connection ");
            e.printStackTrace();
        }
        return null;
    }
}
```

## Interface

The following is the interface declaration that was used

```java
package com.techmarketing.core;

public interface AemFormsAndDB {
   public String getData(String guid);
}
```
