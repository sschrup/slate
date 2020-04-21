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
POST https://app.textiful.com/api/v1/hbh/messages HTTP/1.1
Content-Type: application/json; charset=utf-8
Authorization: Basic YXBpQ2xpZW50SWQ6YXBpU2VjcmV0    
```

```shell   
$ curl -X POST \
    --url 'https://app.textiful.com/api/v1/hbh/messages' \
    -u '{apiClientId}:{apiSecret}' \
```

> Make sure to replace `apiClientId` & `apiSecret` with your specific API Client ID & Secret.

Authentication to each endpoint is performed via [HTTP Basic Auth](https://en.wikipedia.org/wiki/Basic_access_authentication). Provide your API Client ID as the basic auth username value and your Api Secret as the password. 

Basic Authorization requires the credential pair to be encoded with [base64](https://en.wikipedia.org/wiki/Base64) as part of the `Authorization` HTTP header.

Your API credentials carry many privileges, so be sure to keep them secret! Do not share your API Client ID or Secret in publicly accessible areas such GitHub, client-side code etc.

<aside class="notice">
All API requests must be made over HTTPS. Calls made over plain HTTP will fail. API requests without the Authorization header will also fail.
</aside>

# Messaging

## Send a Text Message

This endpoint sends a text message to the specified phone number.

```http
POST https://app.textiful.com/api/v1/messages HTTP/1.1
Content-Type: application/json; charset=utf-8
Authorization: Basic YXBpQ2xpZW50SWQ6YXBpU2VjcmV0

{
    "storeId"     : "1638",
    "toNumber"    : "+12345678901",
    "text"        : "Your HoneyBaked Ham order is ready for curbside pickup at the Spartanburg location.",
    "media"       : null,
    "callbackUrl" : "https://developer.honeybaked.com/textiful/message/status"
}
```

```shell   
$ curl -X POST \
      --url 'https://app.textiful.com/api/v1/hbh/messages' \
      -u '{apiToken}:{apiSecret}' \
      -H 'Content-type: application/json' \
      --data-raw '
      {
          "storeId"     : "1638",
          "toNumber"    : "+12345678901",
          "text"        : "Your HoneyBaked Ham order is ready for curbside pickup at the Spartanburg location.",
          "media"       : null,
          "callbackUrl" : "https://developer.honeybaked.com/textiful/message/status"
      }
    '
```

> The above command returns JSON structured like this:

```http
HTTP/1.1 202 Accepted
Content-Type: application/json; charset=utf-8
```

```json
{
    "id": "15872340188292kw2fuqty55yp2b2",
    "status": "sent",
    "time": "2020-04-18T18:20:16Z",
    "storeId": "1638",
    "fromNumber": "+18645854267",
    "toNumber": "+12345678901",
    "text": "Your HoneyBaked Ham order is ready for curbside pickup at the Spartanburg location.",
    "media": null
}
```

### HTTP Request

`POST https://app.textiful.com/api/v1/hbh/messages`

### Query Parameters

Parameter | Required | Type | Description
--------- | ------- | ---- | -----------
storeId | Required | `string` | The HoneyBaked Ham Store ID that will be sending the message.
toNumber | Required | `string` | 10 digit phone number that will be sent the text message.
text | Required | `string` | The message that will be sent to the recipient. Limit of 160 characters.
media | Optional | `string` | A URL to include as media attachments. If this field is included, the message will be sent as MMS. File size limited to 512KB.                  
callbackUrl | Optional | `string` | A URL to receive message callback. Will be triggered if/when the message is confirmed as delivered.
 
### Response Parameters

Parameter | Type | Description
--------- | ---- | -----------
id | `string` | The unique ID of this message.
status | `string` | The current status of the message - sent, delivered, or failed.
time | `string` | Timestamp of when message was created.
storeId | `string` | The HoneyBaked Ham Store ID.
fromNumber | `string` | 10 digit phone number that sent the message.
toNumber | `string` | 10 digit phone number that received the message.
text | `string` | The message that was sent to the recipient.
media | `string` | The URL of the media attachment. Null if none provided.


## Message Callbacks

Message callbacks can be used to receive message delivery & failure notifications. A callback will only be sent if the callbackUrl value is set when sending a message. 

<aside class="notice">
In most instances, you should recieve a "message-delivered" or "message-failed" for each message sent. However, not all carriers provide reliable delivery receipts. If a particular message does not receive a message delivery callback, it does not mean the end user did not receive the message - just that the delivery is unconfirmed.
</aside>

```http
POST /your_callback_url HTTP/1.1
Content-Type: application/json; charset=utf-8

{
    "type"    : "message-delivered",
    "time"    : "2020-04-18T20:20:16Z",
    "message" : {
        "id"         : "15872340188292kw2fuqty55yp2b2",
        "status"     : "delivered",
        "time"       : "2020-04-18T18:20:16Z",
        "storeId"    : "1638",
        "fromNumber" : "+18645854267",
        "toNumber"   : "+12345678901",
        "text"       : "Your HoneyBaked Ham order is ready for curbside pickup at the Spartanburg location.",
        "media"      : null
    }
}
```

### Message Delivered Parameters

Parameter | Type | Description
--------- | ---- | -----------
type | `string` | The Event type: "message-delivered".
time | `string` | The time of the event described in the callback.
message | `object` | An object of message information.
message.id | `string` | The unique ID of this message.
message.status | `string` | The current status of the message - sent, delivered, or failed.
message.time | `string` | Timestamp of when message was created.
message.storeId | `string` | The HoneyBaked Ham Store ID.
message.fromNumber | `string` | 10 digit phone number that sent the message.
message.toNumber | `string` | 10 digit phone number that received the message.
message.text | `string` | The message that was sent to the recipient.
message.media | `string` | The URL of the media attachment. Null if none provided.

```http
POST /your_callback_url HTTP/1.1
Content-Type: application/json; charset=utf-8

{
    "type"        : "message-failed",
    "time"        : "2020-04-18T20:20:16Z",
    "description" : "destination-rejected-message",
    "message"     : {
        "id"         : "15872340188292kw2fuqty55yp2b2",
        "status"     : "delivered",
        "time"       : "2020-04-18T18:20:16Z",
        "storeId"    : "1638",
        "fromNumber" : "+18645854267",
        "toNumber"   : "+12345678901",
        "text"       : "Your HoneyBaked Ham order is ready for curbside pickup at the Spartanburg location.",
        "media"      : null
    }
}
```

### Message Failed Parameters

Parameter | Type | Description
--------- | ---- | -----------
type | `string` | The Event type: "message-failed".
time | `string` | The time of the event described in the callback.
description | `string` | Description of the failed message error.
message | `object` | An object of message information
message.id | `string` | The unique ID of this message.
message.status | `string` | The current status of the message - sent, delivered, or failed.
message.time | `string` | Timestamp of when message was created.
message.storeId | `string` | The HoneyBaked Ham Store ID.
message.fromNumber | `string` | 10 digit phone number that sent the message.
message.toNumber | `string` | 10 digit phone number that received the message.
message.text | `string` | The message that was sent to the recipient.
message.media | `string` | The URL of the media attachment. Null if none provided.

# Members

## Get Member Status

This endpoint will retrieve the current SMS status & eligibility of a particular member & store combination. 

Member status is store specific (e.g. an individual may have opted-out of receiving texts from Store A but is still opted-in to receive texts from Store B)

```http
GET https://app.textiful.com/api/v1/hbh/stores/1638/members/12345678901 HTTP/1.1
Content-Type: application/json; charset=utf-8
Authorization: Basic YXBpQ2xpZW50SWQ6YXBpU2VjcmV0

{
    "storeId"     : "1638",
    "toNumber"    : "+12345678901",
    "text"        : "Your HoneyBaked Ham order is ready for curbside pickup at the Spartanburg location.",
    "media"       : null,
    "callbackUrl" : "https://developer.honeybaked.com/textiful/message/status"
}
```

```shell   
$ curl 'https://app.textiful.com/api/v1/hbh/stores/1638/members/12345678901' \
      -u '{apiToken}:{apiSecret}'
    '
```

> The above command returns JSON structured like this:

```http
HTTP/1.1 200
Content-Type: application/json; charset=utf-8
```

```json
{
    "storeId": "1638",
    "member_id": "687681",
    "member_sms": "+12345678901",
    "member_email": null,
    "is_sms_enabled": true,
    "is_sms_blacklist": false,
    "is_sms_invalid": false
}
```

### HTTP Request

`GET https://app.textiful.com/api/v1/hbh/stores/{store_id}/members/{member_sms}`

### Query Parameters

Parameter | Required | Type | Description
--------- | ------- | ---- | -----------
store_id | Required | `string` | The HoneyBaked Ham Store ID.
member_sms | Required | `string` | 10 digit phone number of the member.

### Response Parameters

Parameter | Type | Description
--------- | ---- | -----------
store_id | `string` | The HoneyBaked Ham Store ID.
member_id | `string` | The unique ID member.
member_sms | `string` | 10 digit phone number of the member.
member_email | `string` | The email address of the member. Returns null if not set.
is_sms_enabled | `boolean` | If texting is enabled for the member + store combination.
is_sms_blacklist | `boolean` | If the member has opted-out of all text messaging from this store. If true, no further text messages will be sent.
is_sms_invalid | `boolean` | If the phone number cannot receive text messages - typically caused by the number being a landline. If true, no further text messages will be sent.