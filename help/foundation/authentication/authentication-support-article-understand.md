---
title: Understand Authentication support
seo-title: Understand Authentication support in AEM
description: A consolidated view into the authentication (and occasionally authorization) mechanisms supported by AEM. 
seo-description: A consolidated view into the authentication (and occasionally authorization) mechanisms supported by AEM. 
version: 6.3, 6.4, 6.5
feature: authentication
topics: authentication, security
activity: understand
audience: architect, developer, implementer
doc-type: article
kt: 406
uuid: 3adb0904-000b-423f-9d2e-13f1f0c56347
discoiquuid: 71d6216c-1b94-418a-a753-787bab0b0a16
---

# Understand Authentication Support in AEM

A consolidated view into the authentication (and occasionally authorization) mechanisms supported by AEM. 

*The following table describes how users can authenticate into AEM.*

<table>
    <tbody>
        <tr>
            <td><strong>Authentication</strong></td>
            <td><strong>AEM 6.3</strong></td>
            <td><strong>AEM 6.4</strong></td>
            <td><strong>AEM 6.5</strong></td>
        </tr>
        <tr>
            <td><strong>AEM as the canonical identity provider</strong></td>
            <td></td>
            <td></td>
            <td></td>
        </tr>
        <tr>
            <td>Basic authentication</td>
            <td>✔</td>
            <td>✔</td>
            <td>✔</td>
        </tr>
        <tr>
            <td>Forms-based</td>
            <td>✔</td>
            <td>✔</td>
            <td>✔</td>
        </tr>
        <tr>
            <td>Token-based (w/ <a href="https://docs.adobe.com/docs/en/aem/6-5/administer/security/encapsulated-token.html" target="_blank">encapsulated token</a>)</td>
            <td>✔</td>
            <td>✔</td>
            <td>✔</td>
        </tr>
        <tr>
            <td><strong>Non-AEM system as the canonical identity provider</strong></td>
            <td></td>
            <td></td>
            <td></td>
            <tr>
                <td><a href="https://docs.adobe.com/docs/en/aem/6-5/administer/security/ldap-config.html" target="_blank">LDAP</a></td>
                <td>✔</td>
                <td>✔</td>
                <td>✔</td>
            </tr>
            <tr>
                <td><a href="https://docs.adobe.com/docs/en/aem/6-5/deploy/configuring/single-sign-on.html" target="_blank">SSO</a></td>
                <td>✔</td>
                <td>✔</td>
                <td>✔</td>
            </tr>
            <tr>
                <td><a href="https://docs.adobe.com/docs/en/aem/6-5/administer/security/saml-2-0-authenticationhandler.html" target="_blank">SAML 2.0</a></td>
                <td>✔</td>
                <td>✔</td>
                <td>✔</td>
            </tr>
            <tr>
                <td><a href="https://docs.adobe.com/ddc/en/gems/oauth-server-functionality-in-aem---embrace-federation-and-unlea.html" target="_blank">OAuth 1.0a &amp; 2.0</a></td>
                <td>✔</td>
                <td>✔</td>
                <td>✔</td>
            </tr>
            <tr>
                <td><a href="https://sling.apache.org/documentation/the-sling-engine/authentication/authentication-authenticationhandler/openid-authenticationhandler.html" target="_blank">OpenID</a></td>
                <td>⁕</td>
                <td>⁕</td>
                <td>*</td>
            </tr>
    </tbody>
</table>

⁕ *Provided via community projects, but not directly supported by Adobe.*
