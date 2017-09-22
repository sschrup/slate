---
title: API Reference

language_tabs: # must be one of https://git.io/vQNgJ
  - shell
  - php

toc_footers:
  - <a href='mailto:support@textiful.com?subject=Developer Key Request'>Request a Developer Key</a>

includes:
  - errors

search: true
---

# Introduction

Welcome to the Textiful API! You can use this API to trigger messages to the members that have joined one of your keywords.

The Stripe API is organized around [REST](https://en.wikipedia.org/wiki/Representational_state_transfer). JSON is returned by all API responses, including errors.

# Authentication

> To authorize, use this code:

```shell
$ curl https://textiful.com/api/v1/messages \
    -u API_KEY_ID:API_KEY_SECRET
   
# curl uses the -u flag to pass basic auth credentials
```

```php
$response = Httpful\Request::get('https://textiful.com/api/v1/messages')
    ->authenticateWith(API_KEY_ID, API_KEY_SECRET)
    ->send();    
```

> Make sure to replace `API_KEY_ID` & `API_KEY_SECRET` with your API Key Id & API Key Secret pair.

> PHP examples use [Httpful](https://github.com/nategood/httpful) as an HTTP client.
> Other HTTP clients - like [Guzzle](http://docs.guzzlephp.org/en/stable/) or [Requests](http://docs.python-requests.org/en/master/) - can be used but are not required.

Authenticate your account when using the API by including your secret API key in the request. You can manage your API keys in the [API interface](https://textiful.com/api_keys) on your account. Your API keys carry many privileges, so be sure to keep them secret! Do not share your secret API keys in publicly accessible areas such GitHub, client-side code, and so forth.

Authentication to the API is performed via [HTTP Basic Auth](https://en.wikipedia.org/wiki/Basic_access_authentication). Provide your API Key Id as the basic auth username value and your Api Key Secret as the password.

<aside class="notice">
All API requests must be made over HTTPS. Calls made over plain HTTP will fail. API requests without authentication will also fail.
</aside>


# Messages

## Send Text Message

```shell
$ curl https://textiful.com/api/v1/message \
    -u API_KEY_ID:API_KEY_SECRET
    -d mobileNum=1555555555 \
    -d shortcode=345345 \
    -d keyword=BOBLAW \
    -d message="There is a new post on the Bob Loblaw Law Blog!" \    
```

```php
$data = array(
    "mobileNum" => "1555555555",
    "shortcode" => "345345",
    "keyword" => "BOBLAW",
    "message" => "There is a new post on the Bob Loblaw Law Blog!"
);

$response = Httpful\Request::post('https://textiful.com/api/v1/message')
    ->authenticateWith(API_KEY_ID, API_KEY_SECRET)
    ->body($data)
    ->sends('form')
    ->expects('json')
    ->send();
```

> The above command returns JSON structured like this:

```json
{
    "status": "Message Queued",
    "data": {
        "mobileNum": "1555555555",
        "shortcode": "345345",
        "keyword": "BOBLAW",
        "message": "There is a new post on the Bob Loblaw Law Blog!"
    }
}
```

This endpoint sends a text message to the specified phone number. The number must be previously opted-in to the passed keyword otherwise the request will be rejected.

### HTTP Request

`POST http://textiful.com/api/v1/message`

### Query Parameters

Parameter | Description | Details
--------- | ------- | -----------
mobileNum | 10 digit phone number to sent the text message to | Numeric characters only
keyword | The keyword the user is subscribed to
shortcode | The shortcode of the keyword | "345345" or "444999"
message | The text message to send to the mobileNum

