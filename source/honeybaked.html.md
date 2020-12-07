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
POST https://app.textiful.com/api/v1/hbh/curbside/transactions HTTP/1.1
Content-Type: application/json; charset=utf-8
Authorization: Basic YXBpQ2xpZW50SWQ6YXBpU2VjcmV0    
```

```shell   
$ curl -X POST \
    --url 'https://app.textiful.com/api/v1/hbh/curbside/transactions' \
    -u '{apiClientId}:{apiSecret}' \
```

> Make sure to replace `apiClientId` & `apiSecret` with your specific API Client ID & Secret.

Authentication to each endpoint is performed via [HTTP Basic Auth](https://en.wikipedia.org/wiki/Basic_access_authentication). Provide your API Client ID as the basic auth username value and your Api Secret as the password. 

Basic Authorization requires the credential pair to be encoded with [base64](https://en.wikipedia.org/wiki/Base64) as part of the `Authorization` HTTP header.

Your API credentials carry many privileges, so be sure to keep them secret! Do not share your API Client ID or Secret in publicly accessible areas such GitHub, client-side code etc.

<aside class="notice">
All API requests must be made over HTTPS. Calls made over plain HTTP will fail. API requests without the Authorization header will also fail.
</aside>

# Curbside Transactions

## Add/Update Transactions
Add upcoming curbside transactions records to Textiful. Transactions can be sent in a batch. If a transaction orderId does not yet exist, the record will be created. If it already exists, the record will be updated.

```http
POST https://app.textiful.com/api/v1/hbh/curbside/transactions HTTP/1.1
Content-Type: application/json; charset=utf-8
Authorization: Basic YXBpQ2xpZW50SWQ6YXBpU2VjcmV0

[
    {
        "orderId"            : "555444333221",
        "storeId"            : "1638",
        "status"             : "complete",
        "pickupDate"         : "2019-12-23",
        "pickupTime"         : "09:30",
        "toNumber"           : "16784567891",
        "pickupName"         : "Lucille Bluth",
        "customerFname"      : "Lucille",
        "customerLname"      : "Bluth",
        "customerPhone"      : "6784567891",
        "customerEmail"      : "lucille.bluth@example.com",
        "carMake"            : "Honda",
        "carModel"           : "CRV",
        "carColor"           : "Grey",
        "qrCodeUrl"          : "https%3A%2F%2Fprepaid.honeybaked.com%2Fbarcodegenerator%2Fcreate.ashx%3Fdata%3DE9B03A2B-06E5-4226-A2C8-8BFBD26750CA"
        "initiatePickupFlow" : false
    },
    {
        "orderId"            : "555444333222",
        "storeId"            : "1638",
        "status"             : "scheduled",
        "pickupDate"         : "2019-12-23",
        "pickupTime"         : "14:00",
        "toNumber"           : "16784567892",
        "pickupName"         : "Barry Zuckerkorn",
        "customerFname"      : "Steve",
        "customerLname"      : "Holt",
        "customerPhone"      : "6784567893",
        "customerEmail"      : "steve.holt@example.com",
        "carMake"            : "Ford",
        "carModel"           : "Pickup",
        "carColor"           : "Blue",
        "qrCodeUrl"          : "https%3A%2F%2Fprepaid.honeybaked.com%2Fbarcodegenerator%2Fcreate.ashx%3Fdata%3DE9B03A2B-06E5-4226-A2C8-8BFBD26750CA"
        "initiatePickupFlow" : true
    }
]
```

```shell   
$ curl -X POST \
   --url 'https://app.textiful.com/api/v1/hbh/curbside/transactions' \
   -u '{apiToken}:{apiSecret}' \
   -H 'Content-type: application/json' \
   --data-raw '
   [
       {
           "orderId"            : "555444333221",
           "storeId"            : "1638",
           "status"             : "complete",
           "pickupDate"         : "2019-12-23",
           "pickupTime"         : "09:30",
           "toNumber"           : "16784567891",
           "pickupName"         : "Lucille Bluth",
           "customerFname"      : "Lucille",
           "customerLname"      : "Bluth",
           "customerPhone"      : "6784567891",
           "customerEmail"      : "lucille.bluth@example.com",
           "carMake"            : "Honda",
           "carModel"           : "CRV",
           "carColor"           : "Grey",
           "qrCodeUrl"          : "https%3A%2F%2Fprepaid.honeybaked.com%2Fbarcodegenerator%2Fcreate.ashx%3Fdata%3DE9B03A2B-06E5-4226-A2C8-8BFBD26750CA"
           "initiatePickupFlow" : false
       },
       {
           "orderId"            : "555444333222",
           "storeId"            : "1638",
           "status"             : "scheduled",
           "pickupDate"         : "2019-12-23",
           "pickupTime"         : "14:00",
           "toNumber"           : "16784567892",
           "pickupName"         : "Barry Zuckerkorn",
           "customerFname"      : "Steve",
           "customerLname"      : "Holt",
           "customerPhone"      : "6784567893",
           "customerEmail"      : "steve.holt@example.com",
           "carMake"            : "Ford",
           "carModel"           : "Pickup",
           "carColor"           : "Blue",
           "qrCodeUrl"          : "https%3A%2F%2Fprepaid.honeybaked.com%2Fbarcodegenerator%2Fcreate.ashx%3Fdata%3DE9B03A2B-06E5-4226-A2C8-8BFBD26750CA"
           "initiatePickupFlow" : true
       } 
   ]
 '
```

> The above command returns JSON structured like this:

```http
HTTP/1.1 202 Accepted
Content-Type: application/json; charset=utf-8
```

```json
{
    "successCount" : 1,
    "errorCount"   : 1,
    "successResults" : [
        {
            "orderId"         : "555444333221",
            "storeId"         : "1638",
            "status"          : "complete",
            "toNumber"        : "16784567891",
            "toNumberStatus"  : "opted_out",
            "fromNumber"      : "18885554444",
            "createTime"      : "2020-12-18T14:45:16Z",
            "lastUpdateTime"  : "2020-12-20T18:20:16Z"
        }
    ],
    "errorsResults": [
        {
            "orderId"         : "555444333222",
            "error"           : "invalid_format_toNumber",
            "errorMsg"        : "The toNumber parameter must be 11 digits and start with '1'. For example, 12223334444."
        }
    ]
}
```

### HTTP Request

`POST https://app.textiful.com/api/v1/hbh/curbside/transactions`

### Query Parameters

Parameter | Required | Type | Description
--------- | ------- | ---- | -----------
orderId | Required | `string` | The Order ID of the curbside transaction.
storeId | Required | `string` | The HoneyBaked Ham Store ID that will be sending the message.
status | Required | `string` | The current status of the transaction. Valid values are 'scheduled', 'notified', 'arrived', 'confirmed', 'complete', & 'cancelled'
pickupDate | Required | `string` | The date the order is scheduled for pickup (for display purposes only). Format: yyyy-mm-dd
pickupTime | Required | `string` | The time the order is scheduled for pickup (for display purposes only). Format: hh:mm (24 hour)
toNumber | Required | `string` | 11-digit phone number of the pickup person that will be sent the notification text message.
pickupName | Required | `string` | The name of the authorized pickup person.
customerFname | Optional | `string` | The first name of the customer.
customerLname | Optional | `string` | The last name of the customer.
customerEmail | Optional | `string` | The email address of the customer.
customerPhone | Optional | `string` | 11-digit phone number of the customer.
carMake | Optional | `string` | The make of the pickup car.
carModel | Optional | `string` | The model of the pickup car.
carColor | Optional | `string` | The color of the pickup car.
qrCodeUrl | Optional | `string` | URL of the QR code generated for this order. URL should be url encoded. For example: https%3A%2F%2Fprepaid.honeybaked.com%2Fbarcodegenerator%2Fcreate.ashx%3Fdata%3DE9B03A2B-06E5-4226-A2C8-8BFBD26750CA
initiatePickupFlow | Optional | `boolean` | If set to `true`, Textiful will initiate the curbside pickup flow and send the notification message to the customer. If there is a pickup flow already in progress for this order, it will be restarted and the notification message will be sent again.

### Success Response Parameters

Parameter | Type | Description
--------- | ---- | -----------
orderId | `string` | The Order ID of the curbside transaction.
storeId | `string` | The HoneyBaked Ham Store ID that will be sending the message.
status | `string` | The current status of the transaction. Valid values are 'scheduled', 'notified', 'arrived', 'confirmed' & 'complete'
toNumber | `string` | 11-digit phone number of the pickup person that will be sent the notification text message.
toNumberStatus | `string` | Will indicate if the recipient can receive text messages or if they have opted-out: 'eligible' or 'opted-out'
fromNumber | `string` | 11-digit phone number that will send the notification text message.
createTime | `string` | Timestamp of when the record was created in Textiful.
lastUpdateTime | `string` | Timestamp of when the record was last updated in Textiful.

### Error Response Parameters

Parameter | Type | Description
--------- | ---- | -----------
orderId | `string` | The Order ID of the curbside transaction.
storeId | `string` | The HoneyBaked Ham Store ID that will be sending the message.
toNumber | `string` | 11-digit phone number of the pickup person that will be sent the notification text message.
fromNumber | `string` | 11-digit phone number that will send the notification text message.
error | `string` | Error code identifier.
errorMsg | `string` | Description of the error encountered for the Order ID.

### Error Codes
Parameter | Description
--------- | -----------
missing_parameter_[AttributeName] | A required parameter is missing. Example: missing_parameter_status 
invalid_format_toNumber | The toNumber formatting is not valid. Should be 11-digits with a leading '1'
invalid_format_pickupDate | The pickupDate formatting is not valid. Should be yyyy-mm-dd. 
invalid_format_pickupTime | The pickupTime formatting is not valid. should be hh:mm (24 hour)
textiful_business_not_found | The passed StoreId does not match any location records within Textiful
textiful_business_missing_number | The passed StoreId does not have an associated dedicated phone number.


## Get Single Transaction Record

Retrieve a transaction record by the orderId.

```http
GET https://app.textiful.com/api/v1/curbside/transactions/555444333221 HTTP/1.1
Content-Type: application/json; charset=utf-8
Authorization: Basic YXBpQ2xpZW50SWQ6YXBpU2VjcmV0
```

```shell   
$ curl -X GET \
   --url 'https://app.textiful.com/api/v1/hbh/curbside/transactions/555444333221' \
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
{
   "orderId"         : "555444333221",
   "storeId"         : "1638",
   "status"          : "complete",
   "pickupDate"      : "2019-12-23",
   "pickupTime"      : "16:00",
   "toNumber"        : "16784567891",
   "toNumberStatus"  : "eligible",
   "fromNumber"      : "18885554444",
   "pickupName"      : "Lucille Bluth",
   "customerFname"   : "Lucille",
   "customerLname"   : "Bluth",
   "customerPhone"   : "16784567891",
   "customerEmail"   : "lucille.bluth@example.com",
   "carMake"         : "Honda",
   "carModel"        : "CRV",
   "carColor"        : "Grey",
   "carDescription"  : "Grey Honda CRV",
   "createTime"      : "2020-12-20T18:20:16Z",
   "lastUpdateTime"  : "2020-12-20T18:20:16Z"
}
```


### HTTP Request

`GET https://app.textiful.com/api/v1/hbh/curbside/transactions/{orderId}`

### Response Parameters

Parameter | Type | Description
--------- | ---- | -----------
orderId | `string` | The Order ID of the curbside transaction.
storeId | `string` | The HoneyBaked Ham Store ID that will be sending the message.
status | `string` | The current status of the transaction. Valid values are 'scheduled', 'notified', 'arrived', 'confirmed' & 'complete'  
pickupDate | `string` | The date the order is scheduled for pickup (for display purposes only). Format: yyyy-mm-dd
pickupTime | `string` | The time the order is scheduled for pickup (for display purposes only). Format: hh:mm (24 hour)
toNumber | `string` | 11-digit phone number of the pickup person that will be sent the notification text message.
toNumberStatus | `string` | Will indicate if the recipient can receive text messages or if they have opted-out: 'eligible' or 'opted-out'.
fromNumber | `string` | 11-digit phone number that will send the notification text message.
pickupName | `string` | The name of the authorized pickup person.
customerFname | `string` | The first name of the customer.
customerLname | `string` | The last name of the customer.
customerEmail | `string` | The email address of the customer.
customerPhone | `string` | 11-digit phone number of the customer.
carMake | `string` | The make of the pickup car.
carModel | `string` | The model of the pickup car.
carColor | `string` | The color of the pickup car.
carDescription | `string` | The full description of the pickup car. This can be updated during the pickup process.
createTime | `string` | Timestamp of when the record was created in Textiful.
lastUpdateTime | `string` | Timestamp of when the record was last updated in Textiful.


# Curbside Batches

## Batch Add/Update Transactions
Add upcoming curbside transactions records to Textiful in batch. Processing of the records is handled asynchronously. Results can be pulled using the returned batchId. 

```http
POST https://app.textiful.com/api/v1/hbh/curbside/transactions/batch HTTP/1.1
Content-Type: application/json; charset=utf-8
Authorization: Basic YXBpQ2xpZW50SWQ6YXBpU2VjcmV0

[
    {
        "orderId"            : "555444333221",
        "storeId"            : "1638",
        "status"             : "complete",
        "pickupDate"         : "2019-12-23",
        "pickupTime"         : "09:30",
        "toNumber"           : "16784567891",
        "pickupName"         : "Lucille Bluth",
        "customerFname"      : "Lucille",
        "customerLname"      : "Bluth",
        "customerPhone"      : "6784567891",
        "customerEmail"      : "lucille.bluth@example.com",
        "carMake"            : "Honda",
        "carModel"           : "CRV",
        "carColor"           : "Grey",
        "qrCodeUrl"          : "https%3A%2F%2Fprepaid.honeybaked.com%2Fbarcodegenerator%2Fcreate.ashx%3Fdata%3DE9B03A2B-06E5-4226-A2C8-8BFBD26750CA"
        "initiatePickupFlow" : false
    },
    {
        "orderId"            : "555444333222",
        "storeId"            : "1638",
        "status"             : "scheduled",
        "pickupDate"         : "2019-12-23",
        "pickupTime"         : "14:00",
        "toNumber"           : "16784567892",
        "pickupName"         : "Barry Zuckerkorn",
        "customerFname"      : "Steve",
        "customerLname"      : "Holt",
        "customerPhone"      : "6784567893",
        "customerEmail"      : "steve.holt@example.com",
        "carMake"            : "Ford",
        "carModel"           : "Pickup",
        "carColor"           : "Blue",
        "qrCodeUrl"          : "https%3A%2F%2Fprepaid.honeybaked.com%2Fbarcodegenerator%2Fcreate.ashx%3Fdata%3DE9B03A2B-06E5-4226-A2C8-8BFBD26750CA"
        "initiatePickupFlow" : true
    }
]
```

```shell   
$ curl -X POST \
   --url 'https://app.textiful.com/api/v1/hbh/curbside/transactions' \
   -u '{apiToken}:{apiSecret}' \
   -H 'Content-type: application/json' \
   --data-raw '
   [
       {
           "orderId"            : "555444333221",
           "storeId"            : "1638",
           "status"             : "complete",
           "pickupDate"         : "2019-12-23",
           "pickupTime"         : "09:30",
           "toNumber"           : "16784567891",
           "pickupName"         : "Lucille Bluth",
           "customerFname"      : "Lucille",
           "customerLname"      : "Bluth",
           "customerPhone"      : "6784567891",
           "customerEmail"      : "lucille.bluth@example.com",
           "carMake"            : "Honda",
           "carModel"           : "CRV",
           "carColor"           : "Grey",
           "qrCodeUrl"          : "https%3A%2F%2Fprepaid.honeybaked.com%2Fbarcodegenerator%2Fcreate.ashx%3Fdata%3DE9B03A2B-06E5-4226-A2C8-8BFBD26750CA"
           "initiatePickupFlow" : false
       },
       {
           "orderId"            : "555444333222",
           "storeId"            : "1638",
           "status"             : "scheduled",
           "pickupDate"         : "2019-12-23",
           "pickupTime"         : "14:00",
           "toNumber"           : "16784567892",
           "pickupName"         : "Barry Zuckerkorn",
           "customerFname"      : "Steve",
           "customerLname"      : "Holt",
           "customerPhone"      : "6784567893",
           "customerEmail"      : "steve.holt@example.com",
           "carMake"            : "Ford",
           "carModel"           : "Pickup",
           "carColor"           : "Blue",
           "qrCodeUrl"          : "https%3A%2F%2Fprepaid.honeybaked.com%2Fbarcodegenerator%2Fcreate.ashx%3Fdata%3DE9B03A2B-06E5-4226-A2C8-8BFBD26750CA"
           "initiatePickupFlow" : true
       } 
   ]
 '
```

> The above command returns JSON structured like this:

```http
HTTP/1.1 202 Accepted
Content-Type: application/json; charset=utf-8
```

```json
{
    "batchId": "5fca6ad89b61ae69f14bcba9",
    "transactionCount": 1258,
    "successCount" : 0,
    "errorCount"   : 0,
    "successResults" : [],
    "errorsResults": []
}
```

## Get Batch Results

Retrieve the status & results from a specific batch.

```http
GET https://app.textiful.com/api/v1/curbside/transactions/batch/5fca6ad89b61ae69f14bcba9 HTTP/1.1
Content-Type: application/json; charset=utf-8
Authorization: Basic YXBpQ2xpZW50SWQ6YXBpU2VjcmV0
```

```shell   
$ curl -X GET \
   --url 'https://app.textiful.com/api/v1/hbh/curbside/transactions/batch/5fca6ad89b61ae69f14bcba9' \
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
{
    "batchId": "5fca6ad89b61ae69f14bcba9",
    "status": "complete",
    "successCount" : 1257,
    "errorCount"   : 1,
    "successResults" : [
        {
            "orderId"         : "555444333221",
            "storeId"         : "1638",
            "status"          : "complete",
            "toNumber"        : "16784567891",
            "toNumberStatus"  : "opted_out",
            "fromNumber"      : "18885554444",
            "createTime"      : "2020-12-18T14:45:16Z",
            "lastUpdateTime"  : "2020-12-20T18:20:16Z"
        },
        { ... },
        { ... },
        { ... }
    ],
    "errorsResults": [
        {
            "orderId"         : "555444333222",
            "error"           : "invalid_format_toNumber",
            "errorMsg"        : "The toNumber parameter must be 11 digits and start with '1'. For example, 12223334444."
        }
    ]
}
```


## Delete All Transactions

Delete all transactions from the curbside system

```http
POST https://app.textiful.com/api/v1/curbside/transactions/purge HTTP/1.1
Content-Type: application/json; charset=utf-8
Authorization: Basic YXBpQ2xpZW50SWQ6YXBpU2VjcmV0
```

```shell   
$ curl -X POST \
   --url 'https://app.textiful.com/api/v1/hbh/curbside/transactions/purge' \
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
{
   "recordsDeleted" : 278
}
```

### HTTP Request

`POST https://app.textiful.com/api/v1/hbh/curbside/transactions/purge`

### Response Parameters

Parameter | Type | Description
--------- | ---- | -----------
recordsDeleted | `int` | A count of records that have been deleted from the system.


## Notification Message Callbacks [Docs Only]

Notification message callbacks can be used to receive message delivery & failure notifications of the initial notification message. 


```http
POST /your_callback_url HTTP/1.1
Content-Type: application/json; charset=utf-8

{
    "type"    : "notification-message",
    "time"    : "2020-12-23T20:20:16Z",
    "orderId" : "555444333221",
    "storeId" : "1638",
    "message" : {
        "id"         : "5ea9f8ee9a57a27746124bd2",
        "status"     : "delivered",
        "fromNumber" : "67845854267",
        "toNumber"   : "67845678901",
        "time"       : "2020-12-23T18:20:16Z"
    }
}
```

### Notification Message Parameters

Parameter | Type | Description
--------- | ---- | -----------
type | `string` | The Event type: "initial-notification", "customer-arrived", "vehicle-confirmed".
time | `string` | The time of the event described in the callback.
orderId | `string` | The Order ID of the curbside transaction.
storeId | `string` | The HoneyBaked Ham Store ID.
message | `object` | An object of message information.
message.id | `string` | The unique ID of this message.
message.status | `string` | The current status of the message - sent or delivered.
message.fromNumber | `string` | 11-digit phone number that sent the message.
message.toNumber | `string` | 11-digit phone number that received the message.
message.time | `string` | Timestamp of when message was created.