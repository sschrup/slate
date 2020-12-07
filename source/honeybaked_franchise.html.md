---
title: API Reference

language_tabs: # must be one of https://git.io/vQNgJ
  - http
  - shell

toc_footers:
  - <a href='mailto:support@textiful.com?subject=API Key Request'>Request an API Key</a>

search: false
---

# Introduction

Welcome to the Textiful API for HoneyBaked Hams! The following API endpoints have been designed specifically for the HoneyBaked Hams corporation & franchisees.  

The Textiful API is organized around [REST](https://en.wikipedia.org/wiki/Representational_state_transfer). JSON is returned by all API responses, including errors.

# Authentication

## Basic Auth

> Example of using Basic Auth:

```http
GET https://app.textiful.com/api/v1/hbh/franchise/report HTTP/1.1
Content-Type: application/json; charset=utf-8
Authorization: Basic YXBpQ2xpZW50SWQ6YXBpU2VjcmV0    
```

```shell   
$ curl -X GET \
    --url 'https://app.textiful.com/api/v1/hbh/franchise/report' \
    -u '{apiClientId}:{apiSecret}' \
```

> Make sure to replace `apiClientId` & `apiSecret` with your specific API Client ID & Secret.

Authentication to each endpoint is performed via [HTTP Basic Auth](https://en.wikipedia.org/wiki/Basic_access_authentication). Provide your API Client ID as the basic auth username value and your Api Secret as the password. 

Basic Authorization requires the credential pair to be encoded with [base64](https://en.wikipedia.org/wiki/Base64) as part of the `Authorization` HTTP header.

Your API credentials carry many privileges, so be sure to keep them secret! Do not share your API Client ID or Secret in publicly accessible areas such GitHub, client-side code etc.

<aside class="notice">
All API requests must be made over HTTPS. Calls made over plain HTTP will fail. API requests without the Authorization header will also fail.
</aside>

# Reporting

## Get Franchise Report

Retrieve data of franchise activity within Textiful.

```http
GET https://app.textiful.com/api/v1/hbh/franchise/report HTTP/1.1
Content-Type: application/json; charset=utf-8
Authorization: Basic YXBpQ2xpZW50SWQ6YXBpU2VjcmV0
```

```shell   
$ curl -X GET \
   --url 'https://app.textiful.com/api/v1/hbh/franchise/report' \
   -u '{apiToken}:{apiSecret}' \
   -H 'Content-type: application/json' \
 '
```


> The above command returns JSON structured like this:

```http
HTTP/1.1 202 Accepted
Content-Type: application/json; charset=utf-8
```

```json
[
    {
        "name"            : "HoneyBaked of Fayetteville",
        "storeCode"       : 1524,
        "fblName"         : "Scott Temme",
        "city"            : "Fayetteville",
        "state"           : "GA",
        "textListCount"   : 290,
        "emailsCollected" : 230,
        "broadcastTexts": [
            {
                "message"         : "Stop by HoneyBaked and buy any sandwich. Show this coupon to make it a meal for free! (Includes drink and cookie) Limit one per customer. Offer valid until 8-20",
                "media"           : null,
                "recipientCount"  : 273,
                "sentTimestamp"   : "2020-08-13T09:30:00-05:00",
                "sentUnix"        : 1597329000
            },
            {
                "message"         : "Stop in to HoneyBaked Ham of Fayetteville for our new Sandwich 4-pack. Choose Ham or Turkey Classics and chips for just $25.99! Dinner made easy!",
                "media"           : null,
                "recipientCount"  : 253,
                "sentTimestamp"   : "2020-06-25T15:30:00-05:00",
                "sentUnix"        : 1593117000
            },
            {
                "message"         : "Call us at HoneyBaked to order with curbside service or in store pickup and receive $2 off your lunch combo! Mention this text to receive offer. Exp: 5/17",
                "media"           : null,
                "recipientCount"  : 229,
                "sentTimestamp"   : "2020-05-13T10:00:00-05:00",
                "sentUnix"        : 1589382000
            }
        ]
    },
    {
        "name"            : "HoneyBaked of Stockbridge",
        "storeCode"       : 1517,
        "fblName"         : "Scott Temme",
        "city"            : "Stockbridge",
        "state"           : "GA",
        "textListCount"   : 377,
        "emailsCollected" : 289,
        "broadcastTexts": [
            {
                "message"         : "Stop by HoneyBaked and buy any sandwich. Show this coupon to make it a meal for free! (Includes drink and cookie) Limit one per customer. Offer valid until 8-20",
                "media"           : null,
                "recipientCount"  : 350,
                "sentTimestamp"   : "2020-08-17T09:30:00-05:00",
                "sentUnix"        : 1597674600
            },
            {
                "message"         : "In need of dinner in a hurry? Come to Honey Baked Ham in Stockbridge!\n\nIntroducing the Classic Sandwich 4-pack, Includes 4 of your choice of the Ham or \nTurkey Classic and 4 bags of the Sea Salt Chips for 25.99!\n\nPlace your order over the phone or come in to the store today!",
                "media"           : null,
                "recipientCount"  : 320,
                "sentTimestamp"   : "2020-06-24T14:30:00-05:00",
                "sentUnix"        : 1593027000
            }
        ]
    }
]
```

### HTTP Request

`GET https://app.textiful.com/api/v1/hbh/franchise/report`

### Response Parameters

Parameter | Type | Description
--------- | ---- | -----------
name | `string` | The name of the franchise location.
storeId | `string` | The HoneyBaked Ham store code.
fblName | `string` | The FBL assigned to the franchise location.
city | `string` | City of the franchise location.
state | `string` | State of the franchise location.
textListCount | `integer` | The current count of phone numbers eligible to receive text messages  
emailsCollected | `integer` | The current count of emails collected & synced to Emma
broadcastTexts | `object` | A history of broadcast text messages sent to the location's text list
broadcastTexts.message | `string` | The message sent to the text list
broadcastTexts.media | `string` | A URL of the image that was sent with the text. If no image was sent this will be null.
broadcastTexts.recipientCount | `integer` | Number of individuals that received the message
broadcastTexts.sentTimestamp | `string` | The timestamp of when the message was sent
broadcastTexts.sentUnix | `integer` | The timestamp of when the message was sent in Unix time