---
title: Use the SSL Wizard in AEM
description: Adobe Experience Manager's SSL setup wizard to make it easier to set up an AEM instance to run over HTTPS.
seo-description: Adobe Experience Manager's SSL setup wizard to make it easier to set up an AEM instance to run over HTTPS.
version: 6.3, 6,4, 6.5
feature: 
topics: security, operations
activity: use
audience: administrator
doc-type: technical video
uuid: 82a6962e-3658-427a-bfad-f5d35524f93b
discoiquuid: 9e666741-0f76-43c9-ab79-1ef149884686
---

# Use the SSL Wizard in AEM

Adobe Experience Manager's SSL setup wizard to make it easier to set up an AEM instance to run over HTTPS.

>[!VIDEO](https://video.tv.adobe.com/v/17993/?quality=12&learn=on)

>[!NOTE]
>
>For managed environments, it is best for the IT department to provide CA-trusted certificates and keys.
>
>Self-signed certificates are only to be used for development purposes.

## Private key and self-signed certificate download

The following zip contains [!DNL DER] and [!DNL CRT] files required for setting up AEM SSL on localhost and intended for local development purposes only.

The [!DNL DER] and [!DNL CERT] files are provided for convenience and generated using the steps outlined in the Generate Private Key and Self-Signed Certificate section below.

If needed, the certificate pass phrase is **admin**.

localhost - private key and self-signed certificate.zip (expires July 2028)

[Download the Certificate file](assets/use-the-ssl-wizard/certificate.zip)

## Private key and self-signed certificate generation

The above video depicts the setup and configuration of SSL on an AEM author instance using self-signed certificates. The below commands using [[!DNL OpenSSL]](https://www.openssl.org/) can generate a private key and certificate to be used in Step 2 of the wizard.

```shell
### Create Private Key
$ openssl genrsa -aes256 -out localhostprivate.key 4096

### Generate Certificate Signing Request using private key
$ openssl req -sha256 -new -key localhostprivate.key -out localhost.csr -subj '/CN=localhost'

### Generate the SSL certificate and sign with the private key, will expire one year from now
$ openssl x509 -req -days 365 -in localhost.csr -signkey localhostprivate.key -out localhost.crt

### Convert Private Key to DER format - SSL wizard requires key to be in DER format
$ openssl pkcs8 -topk8 -inform PEM -outform DER -in localhostprivate.key -out localhostprivate.der -nocrypt

```
