---
title: Understand Adobe Cloud Manager
description: Adobe Cloud Manager provides a simple, yet robust solution that allows easy management, introspect and self-service of AEM environments.
sub-product: cloud-manager, foundation
feature: pipelines, programs, projects, quality-gates, reports
topics: best-practices, cicd, development, operations, governance
doc-type: feature-video
activity: understand
audience: developer, implementer, administrator, architect
---

# Understand Adobe Cloud Manager

Adobe Cloud Manager provides a simple, yet robust solution that allows easy management, introspect and self-service of AEM environments.

## Cloud Manager Overview

This video series explores the key features of Cloud Manager's for AEM including:

* [Programs](#programs)
* [Environments](#environments)
* [Reports](#reports)
* [CI/CD Production Pipeline](#cicd-production-pipeline)
* [CI/CD Non-production Pipelines](#cicd-non-production-pipeline)
* [Activity](#activity)

For a complete overview, please review the [Cloud Manager User Guide](https://docs.adobe.com/content/help/en/experience-manager-cloud-manager/using/introduction-to-cloud-manager.html).

## Programs {#programs}

[Cloud Manager Programs](https://docs.adobe.com/content/help/en/experience-manager-cloud-manager/using/getting-started/setting-up-program.html) represent sets of AEM environments supporting logical sets of business initiatives, typically corresponding to a purchased Service Level Agreement (SLA). For example, one Program may represent the AEM resources to support the global public Web sites, while another Program represents an internal Central DAM.

>[!VIDEO](https://video.tv.adobe.com/v/26313/?quality=12)

## Environments {#environments}

[Cloud Manager Environments](https://docs.adobe.com/content/help/en/experience-manager-cloud-manager/using/how-to-use/manage-your-environment.html) are composed of AEM Author, AEM Publish and Dispatcher instances. Different environments support roles and can be engaged using different CI/CD Pipelines (described below). Cloud Manager environments typically have one Production environment and one Stage environment.

>[!VIDEO](https://video.tv.adobe.com/v/26318/?quality=12)

## Reports {#reports}

[Cloud Manager Reports](https://docs.adobe.com/content/help/en/experience-manager-cloud-manager/using/how-to-use/monitor-your-environments.html) provide a view into the Program's Environments and AEM instances through a set of charts that report on and track a variety of metrics for each AEM instance.

>[!VIDEO](https://video.tv.adobe.com/v/26315/?quality=12)

## CI/CD Production Pipeline {#cicd-production-pipeline}

*[Use the CI/CD Pipeline in Adobe Cloud Manager](./use-the-cicd-pipeline-in-cloud-manager-for-aem.md) video series provides a deep dive into the Production Pipeline execution, including exploration of failing and successful deployments.*

>[!NOTE]
>
> Throughout these videos, the build, test and deployment times has been sped up to reduce the time of the video. A complete pipeline execution typically takes 45 minutes or more (including the mandatory 30 minute performance testing), depending on the project size, number of AEM instances and UAT processes.

### Configuration

The [CI/CD Production Pipeline](https://docs.adobe.com/content/help/en/experience-manager-cloud-manager/using/how-to-use/configuring-pipeline.html) configuration defines the trigger that will initiate the pipeline, parameters controlling the production deployment and performance test parameters.

>[!VIDEO](https://video.tv.adobe.com/v/26314/?quality=12)

### Pipeline Execution

The [CI/CD Production Pipeline](https://docs.adobe.com/content/help/en/experience-manager-cloud-manager/using/how-to-use/deploying-code.html) is used to build and deploy code through Stage to the Production environment, decreasing time to value.

>[!VIDEO](https://video.tv.adobe.com/v/26317/?quality=12)

## CI/CD Non-production Pipelines {#cicd-non-production-pipeline}

[CI/CD Non-production pipelines](https://docs.adobe.com/content/help/en/experience-manager-cloud-manager/using/how-to-use/configuring-pipeline.html#non-production--code-quality-only-pipelines) are broken into two categories, Code Quality pipelines, and Deployment pipelines. Code Quality pipelines all code from a Git branch to build and be evaluated against Cloud Manager's code quality scan. Deployment pipelines support the automated deployment of code from the Git repository to any Non-production environment, meaning any provisioned AEM environment that is not Stage or Production.

>[!VIDEO](https://video.tv.adobe.com/v/26316/?quality=12)

## Activity {#activity}

Cloud Manager provides a consolidated view into a Program's activity, listing all CI/CD Pipeline executions, both production and non-production, allowing visibility into the past and present activity, and any activity's details can be reviewed.

Cloud Manager also integrates at a per-user level with [Adobe Experience Cloud Notifications](https://docs.adobe.com/content/help/en/experience-manager-cloud-manager/using/how-to-use/notifications.html), providing a omnipresent view into events and actions of interest.

>[!VIDEO](https://video.tv.adobe.com/v/26319/?quality=12)
