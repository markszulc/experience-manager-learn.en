---
title: Generating JSON Web Token and Access Token 
seo-title: Generating JSON Web Token and Access Token 
description: This article explains the code needed to generate JWT and Access Token needed for making REST calls to Adobe Campaign Standard
seo-description: This article explains the code needed to generate JWT and Access Token needed for making REST calls to Adobe Campaign Standard
uuid: 5b780eee-1e7c-4e1c-a164-49ce64939b91
feature: adaptive-forms, form-data-model
topics: integrations
audience: developer
doc-type: tutorial
activity: setup
version: 6.3,6.4,6.5
discoiquuid: cc268946-a7e4-42b3-bfad-5509e215871a
---

# Generating JSON Web Token and Access Token {#generating-json-web-token-and-access-token}

This article explains the code needed to generate JWT and Access Token needed for making REST calls to Adobe Campaign Standard

## Generate JSON Web Token {#generate-json-web-token}

The first step in using Adobe Campaign API is to generate JWT. There are numerous code samples on how to generate JWT for ACS. You can follow this [java code sample](https://github.com/AdobeDocs/adobeio-auth/tree/stage/JWT/samples/adobe-jwt-java) to generate JWT.

In order to use ACS API with AEM Forms, we need to create JWT inside an OSGi bundle. The following code snippet was used to generate JWT in this sample OSGI bundle. The details about the ACS instance are fetched from OSGI configuration properties which are set as shown above.

![configuration](assets/campaignconfiguration.gif)

**A.** The values shown here are dummy values

The following code fetches the details about the Adobe Campaign Server from the OSGI configuration. We create a private key from lines 80 to 104.

Once we have the private key we create JSON Web Token.

```java {.line-numbers}
package aemformwithcampaign.core.services.impl;
import static io.jsonwebtoken.SignatureAlgorithm.RS256;
import java.io.BufferedInputStream;
import java.io.BufferedReader;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.security.KeyFactory;
import java.security.NoSuchAlgorithmException;
import java.security.interfaces.RSAPrivateKey;
import java.security.spec.InvalidKeySpecException;
import java.security.spec.KeySpec;
import java.security.spec.PKCS8EncodedKeySpec;
import java.util.ArrayList;

import java.util.HashMap;
import java.util.List;

import javax.jcr.Node;

import org.apache.commons.compress.utils.IOUtils;
import org.apache.http.Consts;
import org.apache.http.HttpEntity;
import org.apache.http.HttpHost;
import org.apache.http.HttpResponse;
import org.apache.http.NameValuePair;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.HttpClient;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.HttpClientBuilder;
import org.apache.http.message.BasicNameValuePair;
import org.apache.http.util.EntityUtils;
import org.apache.sling.api.resource.Resource;
import org.apache.sling.api.resource.ResourceResolver;
import org.json.JSONObject;
import org.osgi.service.component.annotations.Component;
import org.osgi.service.component.annotations.Reference;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.mergeandfuse.getserviceuserresolver.GetResolver;

import aemforms.campaign.core.CampaignService;
import aemformwithcampaign.core.*;
import formsandcampaign.demo.CampaignConfigurationService;
import io.jsonwebtoken.Jwts;
@Component(service=CampaignService.class, immediate = true)
public class CampaignServiceImpl implements CampaignService {
 private final Logger log = LoggerFactory.getLogger(getClass());

    @Reference
    CampaignConfigurationService config;
    @Reference
    GetResolver getResolver;
    private static final String SERVER_FQDN = "mc.adobe.io";
    private static final String AUTH_SERVER_FQDN = "ims-na1.adobelogin.com";
    private static final String AUTH_ENDPOINT = "/ims/exchange/jwt/";
    private static final String CREATE_PROFILE_ENDPOINT = "/campaign/profileAndServicesExt/profile/";
 @SuppressWarnings("unused")
 @Override
 public String getAccessToken() throws IOException, NoSuchAlgorithmException, InvalidKeySpecException {
  // TODO Auto-generated method stub
  log.info("JWT: Generating Token");

        String apikey = config.getApiKey();
        log.debug("The API Key i got was "+apikey);
        String techact = config.getTechAcct();
        String orgid = config.getOrgId();
        String clientsecret = config.getClientSecret();
        String realm = config.getDomainRealm();
        
        HttpClient httpClient = HttpClientBuilder.create().build();
        Long expirationTime = System.currentTimeMillis() / 1000 + 86400L;
        try {
         ResourceResolver rr = getResolver.getServiceResolver();
            Resource privateKeyRes = rr.getResource("/etc/key/campaign/private.key");
         InputStream is = privateKeyRes.adaptTo(InputStream.class);
            BufferedInputStream bis = new BufferedInputStream(is);
            ByteArrayOutputStream buf = new ByteArrayOutputStream();
            int result = bis.read();
            while (result != -1) {
                byte b = (byte) result;
                buf.write(b);
                result = bis.read();
            }

            String privatekeyString = buf.toString();
            privatekeyString  = privatekeyString.replaceAll("\\n", "").replace("-----BEGIN PRIVATE KEY-----", "").replace("-----END PRIVATE KEY-----", "");
            log.debug("The sanitized private key string is "+privatekeyString);
            // Create the private key
            KeyFactory keyFactory = KeyFactory.getInstance("RSA");
            log.debug("The key factory algorithm is "+keyFactory.getAlgorithm());
            byte []byteArray = privatekeyString.getBytes();
            log.debug("The array length is "+byteArray.length);
            //KeySpec ks = new PKCS8EncodedKeySpec(Base64.getDecoder().decode(keyString));
            byte[] encodedBytes = javax.xml.bind.DatatypeConverter.parseBase64Binary(privatekeyString);
            //KeySpec ks = new PKCS8EncodedKeySpec(byteArray);
            KeySpec ks = new PKCS8EncodedKeySpec(encodedBytes);
            String metascopes[] = new String[]{"ent_campaign_sdk"};
            RSAPrivateKey privateKey = (RSAPrivateKey) keyFactory.generatePrivate(ks);
            HashMap<String, Object> jwtClaims = new HashMap<>();
            jwtClaims.put("iss", orgid);
            jwtClaims.put("sub", techact);
            jwtClaims.put("exp", expirationTime);
            jwtClaims.put("aud", "https://" + AUTH_SERVER_FQDN + "/c/" + apikey);
            //jwtClaims.put("https://" + AUTH_SERVER_FQDN + "/s/" + realm, true);
            for (String metascope : metascopes) {
                jwtClaims.put("https://" + AUTH_SERVER_FQDN + "/s/" + metascope,java.lang.Boolean.TRUE);
            }
            
            // Create the final JWT token
            String jwtToken = Jwts.builder().setClaims(jwtClaims).signWith(RS256, privateKey).compact();
            log.debug("#####The jwtToken is  ####"+jwtToken+"#######");
            HttpHost authServer = new HttpHost(AUTH_SERVER_FQDN, 443, "https");
            HttpPost authPostRequest = new HttpPost(AUTH_ENDPOINT);
            authPostRequest.addHeader("Cache-Control", "no-cache");
            List<NameValuePair> params = new ArrayList<NameValuePair>();
            params.add(new BasicNameValuePair("client_id", apikey));
            params.add(new BasicNameValuePair("client_secret", clientsecret));
            params.add(new BasicNameValuePair("jwt_token", jwtToken));
            authPostRequest.setEntity(new UrlEncodedFormEntity(params, Consts.UTF_8));
            HttpResponse response = httpClient.execute(authServer, authPostRequest);
            if (200 != response.getStatusLine().getStatusCode()) {
                HttpEntity ent = response.getEntity();
                String content = EntityUtils.toString(ent);
                log.error("JWT: Server Returned Error\n", response.getStatusLine().getReasonPhrase());
                log.error("ERROR DETAILS: \n", content);
                throw new IOException("Server returned error: " + response.getStatusLine().getReasonPhrase());
            }
            HttpEntity entity = response.getEntity();
            JsonObject jo = new JsonParser().parse(EntityUtils.toString(entity)).getAsJsonObject();
            log.debug("Returning access_token " + jo.get("access_token").getAsString());
            return jo.get("access_token").getAsString();


        }
        catch (Exception e)
        {
         e.printStackTrace();
        }
  return null;
 }
 @Override
 public String createProfile(JsonObject profile) {
  // TODO Auto-generated method stub
  String jwtToken = null;
  try {
   jwtToken = getAccessToken();
  } catch (NoSuchAlgorithmException e2) {
   // TODO Auto-generated catch block
   e2.printStackTrace();
  } catch (InvalidKeySpecException e2) {
   // TODO Auto-generated catch block
   e2.printStackTrace();
  } catch (IOException e2) {
   // TODO Auto-generated catch block
   e2.printStackTrace();
  }
        String tenant = config.getTenant();
        String apikey = config.getApiKey();
        String path = "/" + tenant + CREATE_PROFILE_ENDPOINT;
        log.debug("The API Key is "+apikey);
        log.debug("###The Path is "+path);
        HttpHost server = new HttpHost(SERVER_FQDN, 443, "https");
        HttpPost postReq = new HttpPost(path);
        postReq.addHeader("Cache-Control", "no-cache");
        postReq.addHeader("Content-Type", "application/json");
        postReq.addHeader("X-Api-Key", apikey);
        postReq.addHeader("Authorization", "Bearer " + jwtToken);
        StringEntity se = null;
        log.debug("Creating profile for"+profile.toString());
  try {
   se = new StringEntity(profile.toString());

  } catch (UnsupportedEncodingException e1) {
   // TODO Auto-generated catch block
   e1.printStackTrace();
  }
  postReq.setEntity(se);
  HttpClient httpClient = HttpClientBuilder.create().build();
  HttpResponse result;
   try {
    result = httpClient.execute(server, postReq);
    JsonObject responseJson = new JsonParser().parse(EntityUtils.toString(result.getEntity()))
    .getAsJsonObject();
    log.debug("The response on creating profile is " + responseJson.toString());
    return responseJson.get("PKey").getAsString();

   } catch (ClientProtocolException e) {
    // TODO Auto-generated catch block
    e.printStackTrace();
   } catch (IOException e) {
    // TODO Auto-generated catch block
    e.printStackTrace();
   }

  return null;
    }

 }

```

## Generate Access Token {#generate-access-token}

We then exchange the generated JWT for an Access Token by making a POST call. This Access Token will then be sent as an Authorization key in the HTTP Header for subsequent REST calls
