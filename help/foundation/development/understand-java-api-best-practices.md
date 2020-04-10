---
title: Understand Java API Best Practices in AEM
description: AEM is built on a rich open-source software stack that exposes many Java APIs for use during development. This article explores the major APIs and when and why they should be used.
version: 6.2, 6.3, 6.4, 6.5
sub-product: foundation, assets, sites
feature: 
topics: best-practices, development
activity: develop
audience: developer
doc-type: article
---

# Understand Java API Best Practices

Adobe Experience Manager (AEM) is built on a rich open-source software stack that exposes many Java APIs for use during development. This article explores the major APIs and when and why they should be used.

AEM is built on 4 primary Java API sets.

* **Adobe Experience Manager (AEM)**

  * Product abstractions such as pages, assets, workflows, etc.

* **[!DNL Apache Sling] Web Framework**

  * REST and resource-based abstractions such as resources, value maps, and HTTP requests.

* **JCR ([!DNL Apache Jackrabbit Oak])**

  * Data and content abstractions such as node, properties and sessions.

* **[!DNL OSGi (Apache Felix)]**

  * OSGi application container abstractions such as services and (OSGi) components.

## Java API preference "rule of thumb"

The general rule is to prefer the APIs/abstractions the following order:

1. **AEM**
1. **[!DNL Sling]**
1. **JCR**
1. **OSGi**

If an API is provided by AEM, prefer it over [!DNL Sling], JCR, and OSGi. If AEM doesn't provide an API, then prefer [!DNL Sling] over JCR and OSGi.

This order is a general rule, meaning exceptions exist. Acceptable reasons to break from this rule are:

* Well-known exceptions, as described below.
* Required functionality is not available in a higher level API.
* Operating in the context of existing code (custom or AEM product code) which itself uses a less-preferred API, and the cost to move to the new API is unjustifiable.

    * It is better to consistently use the lower level API than create a mix.

## AEM APIs

* [**AEM API JavaDocs**](https://helpx.adobe.com/experience-manager/6-5/sites/developing/using/reference-materials/javadoc/index.html)

AEM APIs provide abstractions and functionality specific to productized use cases.

For example, AEM's [PageManager](https://helpx.adobe.com/experience-manager/6-3/sites/developing/using/reference-materials/javadoc/com/day/cq/wcm/api/PageManager.html) and [Page](https://helpx.adobe.com/experience-manager/6-5/sites/developing/using/reference-materials/javadoc/com/day/cq/wcm/foundation/model/Page.html) APIs provide abstractions for `cq:Page` nodes in AEM that represent web pages.

While these nodes are available via [!DNL Sling] APIs as Resources, and JCR APIs as Nodes, AEM's APIs provide abstractions for common use cases. Using the AEM APIs ensures consistent behavior between AEM the product, and customizations and extensions to AEM.

### com.adobe.&#42; vs com.day.&#42; APIs

AEM APIs have an intra-package preference, identified by the following Java packages, in order of preference:

1. `com.adobe.cq`
1. `com.adobe.granite`
1. `com.day.cq`

`com.adobe.cq` supports product use cases whereas `com.adobe.granite` supports cross-product platform use-cases, such as workflow or tasks (which are used across products: AEM Assets, Sites, etc.).

`com.day.cq` contains "original" APIs. These APIs address core abstractions and functionalities that existed before and/or around Adobe's acquisition of [!DNL Day CQ]. These APIs are supported and should not be avoided, unless `com.adobe.cq` or `com.adobe.granite` provide a (newer) alternative.

New abstractions such as [!DNL Content Fragments] and [!DNL Experience Fragments] are built out in the `com.adobe.cq` space rather than `com.day.cq` described below.

### Query APIs

AEM supports multiple query languages. The 3 main languages are [JCR-SQL2](https://docs.jboss.org/jbossdna/0.7/manuals/reference/html/jcr-query-and-search.html), XPath and [AEM Query Builder](https://helpx.adobe.com/experience-manager/6-5/sites/developing/using/querybuilder-api.html).

The most important concern is maintaining a consistent query language across the code base, to reduce complexity and cost to understand.

All the query languages have effectively the same performance profiles, as [!DNL Apache Oak] trans-piles them to JCR-SQL2 for final query execution, and the conversion time to JCR-SQL2 is negligible compared to the query time itself.

The preferred API is [AEM Query Builder](https://helpx.adobe.com/experience-manager/6-5/sites/developing/using/querybuilder-api.html), which is the highest level abstraction and provides a robust API for constructing, executing and retrieving results for queries, and provides the following:

* Simple, parameterized query construction (query params modeled as a Map)
* Native [Java API and HTTP APIs](https://helpx.adobe.com/experience-manager/6-3/sites/developing/using/querybuilder-api.html)
* [OOTB Query Debugger](https://helpx.adobe.com/experience-manager/6-5/sites/developing/using/querybuilder-api.html#TestingandDebugging)
* [OOTB predicates](https://helpx.adobe.com/experience-manager/6-5/sites/developing/using/querybuilder-predicate-reference.html) supporting common query requirements  

* Extensible API, allowing for the development of custom [query predicates](https://helpx.adobe.com/experience-manager/6-3/sites/developing/using/implementing-custom-predicate-evaluator.html)
* JCR-SQL2 and XPath can be executed directly via [[!DNL Sling]](https://sling.apache.org/apidocs/sling10/org/apache/sling/api/resource/ResourceResolver.html#findResources-java.lang.String-java.lang.String-) and [JCR APIs](https://docs.adobe.com/docs/en/spec/jsr170/javadocs/jcr-2.0/javax/jcr/query/package-summary.html), returning results a [[!DNL Sling] Resources](https://sling.apache.org/apidocs/sling10/org/apache/sling/api/resource/Resource.html) or [JCR Nodes](https://docs.adobe.com/docs/en/spec/jsr170/javadocs/jcr-2.0/javax/jcr/Node.html), respectively.

>[!CAUTION]
>
>AEM QueryBuilder API leaks a ResourceResolver object. To mitigate this leak follow this [code sample](https://github.com/Adobe-Consulting-Services/acs-aem-samples/blob/master/bundle/src/main/java/com/adobe/acs/samples/search/querybuilder/impl/SampleQueryBuilder.java#L164).
>

## [!DNL Sling] APIs

* [**Apache [!DNL Sling] API JavaDocs**](https://sling.apache.org/apidocs/sling10/)

[Apache [!DNL Sling]](https://sling.apache.org/) is the RESTful web framework that underpins AEM. [!DNL Sling] provides HTTP request routing, models JCR nodes as resources, provides security context, and much more.

[!DNL Sling] APIs have the added benefit of being built for extension, which means it is often easier and safer to augment behavior of applications built using [!DNL Sling] APIs than the less extensible JCR APIs.

### Common uses of [!DNL Sling] APIs

* Accessing JCR nodes as [[!DNL Sling Resources]](https://sling.apache.org/apidocs/sling10/org/apache/sling/api/resource/Resource.html) and accessing their data via [ValueMaps](https://sling.apache.org/apidocs/sling10/org/apache/sling/api/resource/ValueMap.html).

* Providing security context via the [ResourceResolver](https://sling.apache.org/apidocs/sling10/org/apache/sling/api/resource/ResourceResolver.html).
* Creating and removing resources via ResourceResolver's [create/move/copy/delete methods](https://sling.apache.org/apidocs/sling10/org/apache/sling/api/resource/ResourceResolver.html).
* Updating properties via the [ModifiableValueMap](https://sling.apache.org/apidocs/sling10/org/apache/sling/api/resource/ModifiableValueMap.html).
* Building request processing building blocks

    * [Servlets](https://sling.apache.org/documentation/the-sling-engine/servlets.html)
    * [Servlet Filters](https://sling.apache.org/documentation/the-sling-engine/filters.html)

* Asynchronous work processing building blocks

    * [Event and Job Handlers](https://sling.apache.org/documentation/bundles/apache-sling-eventing-and-job-handling.html)
    * [Scheduler](https://sling.apache.org/documentation/bundles/scheduler-service-commons-scheduler.html)
    * [Sling Models](https://sling.apache.org/documentation/bundles/models.html)

* [Service users](https://helpx.adobe.com/experience-manager/6-5/sites/administering/using/security-service-users.html)

## JCR APIs

* **[JCR 2.0 JavaDocs](https://docs.adobe.com/docs/en/spec/javax.jcr/javadocs/jcr-2.0/index.html)**

The [JCR (Java Content Repository) 2.0 APIs](https://docs.adobe.com/docs/en/spec/javax.jcr/javadocs/jcr-2.0/index.html) is part of a specification for JCR implementations (in the case of AEM, [Apache Jackrabbit Oak](https://jackrabbit.apache.org/oak/)). All JCR implementation must conform to and implement these APIs, and thus, is the lowest level API for interacting with AEM's content.

The JCR itself is a hierarchical/tree-based NoSQL datastore AEM uses as its content repository. The JCR has a vast array of supported APIs, ranging from content CRUD to querying content. Despite this robust API, it is rare  they're preferred  over the higher level AEM and [!DNL Sling] abstractions.

Always prefer the JCR APIs over the Apache Jackrabbit Oak APIs. The JCR API's are for ***interacting*** with a JCR repository, whereas the Oak APIs are for ***implementing*** a JCR repository.

### Common misconceptions about JCR APIs

While the JCR is AEM's content repository, its APIs are NOT the preferred method for interacting with the content. Instead prefer the AEM APIs (Page, Assets, Tag, etc.) or Sling Resource APIs as they provide better abstractions.

>[!CAUTION]
>
>Broad use of JCR APIs' Session and Node interfaces in an AEM application is code-smell. Ensure [!DNL Sling] APIs should not be used instead.

### Common uses of JCR APIs

* [Access control management](https://helpx.adobe.com/experience-manager/6-5/sites/administering/using/security-service-users.html)
* [Authorizable management (users/groups)](https://jackrabbit.apache.org/api/2.8/org/apache/jackrabbit/api/security/user/package-summary.html)
* JCR observation (listening for JCR events)
* Creating deep node structures

    * While the Sling APIs support the creation of resources, the JCR APIs have convenience methods in [JcrUtils](https://jackrabbit.apache.org/api/2.10/index.html?org/apache/jackrabbit/commons/JcrUtils.html) and [JcrUtil](https://helpx.adobe.com/experience-manager/6-5/sites/developing/using/reference-materials/javadoc/com/day/cq/commons/jcr/JcrUtil.html) that expedite creating deep structures.

## OSGi APIs

* [**OSGi R6 JavaDocs**](https://osgi.org/javadoc/r6/cmpn/index.html?overview-summary.html)
* **[OSGi Declarative Services 1.2 Component Annotations JavaDocs](https://osgi.org/javadoc/r6/cmpn/org/osgi/service/component/annotations/package-summary.html)**
* **[OSGi Declarative Services 1.2 Metatype Annotations JavaDocs](https://osgi.org/javadoc/r6/cmpn/org/osgi/service/metatype/annotations/package-summary.html)**
* [**OSGi Framework JavaDocs**](https://osgi.org/javadoc/r6/core/org/osgi/framework/package-summary.html)

There is little overlap between the OSGi APIs and the higher level APIs (AEM, [!DNL Sling], and JCR), and the need to use OSGi APIs is rare and requires a high-level of AEM development expertise.

### OSGi vs Apache Felix APIs

OSGi defines a specification all OSGi containers must implement and conform to. AEM's OSGi implementation, Apache Felix, provides several of its own APIs as well.

* Prefer OSGi APIs (`org.osgi`) over Apache Felix APIs (`org.apache.felix`).

### Common uses of OSGi APIs

* OSGi annotations for declaring OSGi services and components.

    * Prefer [OSGi Declarative Services (DS) 1.2 Annotations](https://osgi.org/javadoc/r6/cmpn/org/osgi/service/component/annotations/package-summary.html) over [Felix SCR Annotations](https://felix.apache.org/documentation/subprojects/apache-felix-maven-scr-plugin/scr-annotations.html) for declaring OSGi services and components

* OSGi APIs for dynamically in-code [un/registering OSGi services/components](https://osgi.org/javadoc/r6/core/org/osgi/framework/package-summary.html).

    * Prefer the use of OSGi DS 1.2 annotations when conditional OSGi Service/Component management is not needed (which is most often the case).

## Exceptions to the rule

The following are common exceptions to the rules defined above.

### AEM Asset APIs

* Prefer [ `com.day.cq.dam.api`](https://helpx.adobe.com/experience-manager/6-5/sites/developing/using/reference-materials/javadoc/com/day/cq/dam/api/package-summary.html) over [ `com.adobe.granite.asset.api`](https://helpx.adobe.com/experience-manager/6-5/sites/developing/using/reference-materials/javadoc/com/adobe/granite/asset/api/package-summary.html).

    * While the `com.day.cq` Assets API's provide more complimentary tooling to AEM's asset management use-cases.
    * The Granite Assets APIs support low-level asset management use-cases (version, relations).

### Query APIs

* AEM QueryBuilder does not support certain query functions such as [suggestions](https://jackrabbit.apache.org/oak/docs/query/query-engine.html#Suggestions), spellcheck and index hints amongst other less common functions. To query with these functions JCR-SQL2 is preferred.

### [!DNL Sling] Servlet Registration {#sling-servlet-registration}

* [!DNL Sling] servlet registration, prefer [OSGi DS 1.2 annotations w/ @SlingServletResourceTypes](https://sling.apache.org/documentation/the-sling-engine/servlets.html) over `@SlingServlet`

### [!DNL Sling] Filter Registration {#sling-filter-registration}

* [!DNL Sling] filter registration, prefer [OSGi DS 1.2 annotations w/ @SlingServletFilter](https://sling.apache.org/documentation/the-sling-engine/filters.html) over `@SlingFilter`

## Helpful code snippets

The following are helpful Java code snippets that illustrate best practices for common use cases using discussed APIs. These snippets also illustrate how to move from less preferred APIs to more preferred APIs.

### JCR Session to [!DNL Sling] ResourceResolver

#### Auto-closing Sling ResourceResolver

Since AEM 6.2, the [!DNL Sling] ResourceResolver is `AutoClosable` in a [try-with-resources](https://docs.oracle.com/javase/tutorial/essential/exceptions/tryResourceClose.html) statement. Using this syntax, an explicit call to `resourceResolver .close()` is not needed.

```java
@Reference
ResourceResolverFactory rrf;
...
Map<String, Object> authInfo = new HashMap<String, Object>();
authInfo.put(JcrResourceConstants.AUTHENTICATION_INFO_SESSION, jcrSession);

try (ResourceResolver resourceResolver = rrf.getResourceResolver(authInfo)) {
    // Do work with the resourceResolver
} catch (LoginException e) { .. }
```

#### Manually closed Sling ResourceResolver

ResourceResolvers can be must be manually closed in a `finally` block, if the auto-closing technique shown above cannot be used.

```java
@Reference
ResourceResolverFactory rrf;
...
Map<String, Object> authInfo = new HashMap<String, Object>();
authInfo.put(JcrResourceConstants.AUTHENTICATION_INFO_SESSION, jcrSession);

ResourceResolver resourceResolver = null;

try {
    resourceResolver = rrf.getResourceResolver(authInfo);
    // Do work with the resourceResolver
} catch (LoginException e) {
   ...
} finally {
    if (resourceResolver != null) { resourceResolver.close(); }
}
```

### JCR Path to [!DNL Sling] [!DNL Resource]

```java
Resource resource = ResourceResolver.getResource("/path/to/the/resource");
```

### JCR Node to [!DNL Sling] [!DNL Resource]

```java
Resource resource = resourceResolver.getResource(node.getPath());
```

### [!DNL Sling] [!DNL Resource] to AEM Asset

#### Recommended approach

`DamUtil.resolveToAsset(..)`resolves any resource under the `dam:Asset` to the Asset object by walking up the tree as needed.

```java
Asset asset = DamUtil.resolveToAsset(resource);
```

#### Alternative approach

Adapting a resource to an Asset requires the resource itself to be the `dam:Asset` node.

```java
Asset asset = resource.adaptTo(Asset.class);
```

### [!DNL Sling] Resource to AEM Page

#### Recommended approach

`pageManager.getContainingPage(..)` resolves any resource under the `cq:Page` to the Page object by walking up the tree as needed.

```java
PageManager pageManager = resourceResolver.adaptTo(PageManager.class);
Page page = pageManager.getContainingPage(resource);
Page page2 = pageManager.getContainingPage("/content/path/to/page/jcr:content/or/component");

```

#### Alternative approach {#alternative-approach-1}

Adapting a resource to a Page requires the resource itself to be the `cq:Page` node.

```java
Page page = resource.adaptTo(Page.class);
```

### Read AEM Page properties

Use the Page object's getters to get well known properties (`getTitle()`, `getDescription()`, etc.) and `page.getProperties()` to obtain the `[cq:Page]/jcr:content` ValueMap for retrieving other properties.

```java
Page page = resource.adaptTo(Page.class);
String title = page.getTitle();
Calendar value = page.getProperties().get("cq:lastModified", Calendar.getInstance());
```

### Read AEM Asset metadata properties

The Asset API provides convenient methods for reading properties from the `[dam:Asset]/jcr:content/metadata` node. Note that this is not a ValueMap, the 2nd parameter (default value, and auto-type casting) is not supported.

```java
Asset asset = resource.adaptTo(Page.class);
String title = asset.getMetadataValue("dc:title");
Calendar lastModified = (Calendar) asset.getMetadata("cq:lastModified");
```

### Read [!DNL Sling] [!DNL Resource] properties {#read-sling-resource-properties}

When properties are stored in locations (properties or relative resources) where the AEM APIs (Page, Asset) cannot directly access, the [!DNL Sling] Resources and ValueMaps can be used to obtain the data.

```java
ValueMap properties = resource.getValueMap();
String value = properties.get("jcr:title", "Default title");
String relativeResourceValue = properties.get("relative/propertyName", "Default value");
```

In this case, the AEM object may have to be converted into a [!DNL Sling] [!DNL Resource] to efficiently locate the desired property or sub-resource.

#### AEM Page to [!DNL Sling] [!DNL Resource]

```java
Resource resource = page.adaptTo(Resource.class);
```

#### AEM Asset to [!DNL Sling] [!DNL Resource]

```java
Resource resource = asset.adaptTo(Resource.class);
```

### Write properties using [!DNL Sling]'s ModifiableValueMap

Use [!DNL Sling]'s [ModifiableValueMap](https://sling.apache.org/apidocs/sling10/org/apache/sling/api/resource/ModifiableValueMap.html) to write properties to nodes. This can only write to the immediate node (relative property paths are not supported).

Note the call  to `.adaptTo(ModifiableValueMap.class)` requires write permissions to the resource, else it will return null.

```java
ModifiableValueMap properties = resource.adaptTo(ModifiableValueMap.class);

properties.put("newPropertyName", "new value");
properties.put("propertyNameToUpdate", "updated value");
properties.remove("propertyToRemove");

resource.getResourceResolver().commit();
```

### Create an AEM Page

Always use PageManager to create pages as it takes a Page Template, is required to properly define and initialize Pages in AEM.

```java
String templatePath = "/conf/my-app/settings/wcm/templates/content-page";
boolean autoSave = true;

PageManager pageManager = resourceResolver.adaptTo(PageManager.class);
pageManager.create("/content/parent/path", "my-new-page", templatePath, "My New Page Title", autoSave);

if (!autoSave) { resourceResolver.commit(); }
```

### Create a [!DNL Sling] Resource

ResourceResolver supports basic operations for creating resources. When creating higher level abstractions (AEM Pages, Assets, Tags, etc.) use the methods provided by their respective Managers.

```java
resourceResolver.create(parentResource, "my-node-name", new ImmutableMap.Builder<String, Object>()
           .put("jcr:primaryType", "nt:unstructured")
           .put("jcr:title", "Hello world")
           .put("propertyName", "Other initial properties")
           .build());

resourceResolver.commit();
```

### Delete a [!DNL Sling] Resource

ResourceResolver supports removing a resource. When creating higher-level abstractions (AEM Pages, Assets, Tags, etc.) use the methods provided by their respective Managers.

```java
resourceResolver.delete(resource);

resourceResolver.commit();
```
