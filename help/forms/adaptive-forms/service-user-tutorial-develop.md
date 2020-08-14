---
title: Developing with Service Users in AEM Forms
seo-title: Developing with Service Users in AEM Forms
description: This article walks you through the process of creating a service user in AEM Forms
seo-description: This article walks you through the process of creating a service user in AEM Forms
uuid: 996f30df-3fc5-4232-a104-b92e1bee4713
feature: adaptive-forms
topics: development,administration
audience: implementer,developer
doc-type: article
activity: setup
discoiquuid: 65bd4695-e110-48ba-80ec-2d36bc53ead2
---

# Developing with Service Users in AEM Forms

This article walks you through the process of creating a service user in AEM Forms

In previous versions of Adobe Experience Manager (AEM), the administrative resource resolver was used for back-end processing which required access to the repository. Use of the administrative resource resolver is deprecated in AEM 6.3. Instead, a system user with specific permissions in the repository is used.

This article walks through the creation of a system user and configuring the user mapper properties.

   1. Navigate to [http://localhost:4502/crx/explorer/index.jsp](http://localhost:4502/crx/explorer/index.jsp)
   1. Login as ' admin '
   1. Click on ' User Administration '
   1. Click on ' Create System User '
   1. Set the userid type as ' data ' and click the green icon to complete the process of creating the system user
   1. [Open configMgr](http://localhost:4502/system/console/configMgr)
   1. Search for ' Apache Sling Service User Mapper Service ' and click to open the properties
   1. Click the *+* icon (plus) to add the following Service Mapping

        * DevelopingWithServiceUser.core:getresourceresolver=data
        * DevelopingWithServiceUser.core:getformsresourceresolver=fd-service

   1. Click ' Save '

   In the above configuration setting DevelopingWithServiceUser.core is the symbolic name of the bundle. getresourceresolver is the subservice name.data is the system user created in the earlier step.

   We can also get resource resolver on behalf of fd-service user. This service user is used for document services. For example, if you want to Certify/Apply Usage Rights etc, we will use resource resolver of fd-service user to perform the operations

1. [Download and unzip the zip file associated with this article.](assets/developingwithserviceuser.zip)
1. Navigate to [http://localhost:4502/system/console/bundles](http://localhost:4502/system/console/bundles)
1. Upload and start the OSGi bundle
1. Ensure the bundle is in active state
1. You have now successfully created a *System User* and also deployed the *Service User bundle*.

   To provide access to /content, give the system user (' data ') read permissions on the content node.

    1. Navigate to to [http://localhost:4502/useradmin](http://localhost:4502/useradmin)
    1. Search for user ' data '. This is the same system user you created in the earlier step.
    1. Double-click on the user and then click the ' Permissions ' tab
    1. Give ' read ' access to the 'content ' folder.
    1. To use the service user to gain access to /content folder use the following code



   ```java
   com.mergeandfuse.getserviceuserresolver.GetResolver aemDemoListings = sling.getService(com.mergeandfuse.getserviceuserresolver.GetResolver.class);
   
   resourceResolver = aemDemoListings.getServiceResolver();
   
   // get the resource. This will succeed because we have given ' read ' access to the content node
   
   Resource contentResource = resourceResolver.getResource("/content/forms/af/sandbox/abc.pdf");
   ```

   If you want to access /content/dam/data.json file in your bundle, you will use the following code. This code assusmes you have given read permissions to the "data" user on the /content/dam/ node

   ```java
   @Reference
   GetResolver getResolver;
   .
   .
   .
   ResourceResolver serviceResolver = getResolver.getServiceResolver();
   // to get resource resolver specific to fd-service user. This is for Document Services
   ResourceResolver fdserviceResolver = getResolver.getFormsServiceResolver();
   Node resNode = getResolver.getServiceResolver().getResource("/content/dam/data.json").adaptTo(Node.class);
   
   ```

   The complete code of the implementation is given below

   ```java
   package com.mergeandfuse.getserviceuserresolver.impl;
   
   import java.util.HashMap;
   
   import org.apache.sling.api.resource.LoginException;
   import org.apache.sling.api.resource.ResourceResolver;
   import org.apache.sling.api.resource.ResourceResolverFactory;
   import org.osgi.service.component.annotations.Component;
   import org.osgi.service.component.annotations.Reference;
   import com.mergeandfuse.getserviceuserresolver.GetResolver;

   @Component(service = GetResolver.class)
   public class GetResolverImpl implements GetResolver {
    @Reference
    ResourceResolverFactory resolverFactory;
    @Override
    public ResourceResolver getServiceResolver() {
     HashMap<String, Object> param = new HashMap<String, Object>();
     param.put(ResourceResolverFactory.SUBSERVICE, "getresourceresolver");
     ResourceResolver resolver = null;
     try {
      resolver = resolverFactory.getServiceResourceResolver(param);
     } catch (LoginException e) {
      // TODO Auto-generated catch block
      e.printStackTrace();
     }
     return resolver;
    }
   ```

