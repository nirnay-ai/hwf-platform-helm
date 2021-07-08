# Channel Configuration - REST API 

## Callback URL Configuration

Callback URL - https://domain/bot/rest/{assistant_name}/{token}

## Channel Configuration 

REST Channel is useful for any custom chat interface. Set up a secret key which will be used to 
call the API. this channel buffers the messages from chatbot till the chat interface fetches updates 
via the get messages API. 

Two API's are in use for this channel.

### Inbound API  (POST /bot/rest/agent/token)
Inbound Body format  

    {"user_id": "<unique id of the user>", -- Mandatory
     "user_name": "<name of the user>", -- Mandatory
     "text": "<in case a text message is sent>", -- Optional
     "image": "<URL of the Image >",  -- Optional
     "document": "<URL of the document>",  -- Optional
     "caption": "Caption for the image"  -- Optional }

  This API will pass the contents over to chatbot backend and save the responses in a redis queue.

### Outbound (POST /bot/rest_get/agent/token/user_id)
Outbound Body format  

    {"user_id": "<unique id of the user>",  -- Mandatory
     "user_name": "<name of the user>",  -- Optional
     "text": "<in case a text message is sent>", -- Optional
     "buttons": <in case buttons are sent>", -- Optional
     "image": "<URL of the Image >", -- Optional
     "custom": "Custom data format to be implemented by the chat application" -- Optional
     }

  This API will retrieve the messages' bot has sent to a specific user. 
  All messages once retrieved are cleared from redis cache


## HWF Configuration

Below are the required fields for configuration of REST channel in HWF. 

- Secret Code - Set a value, and it will be used in callback URL.

## Inbound Message formats 

### Text
Regular text messages set to bot are supported. 

### Image with caption 
An image sent as attachment to bot with text caption, here the text caption is passed to chatbot as intent
and the image is passed on as attachment to chatbot. 
Image attachment would contain the URL to download the image in attachment secton of the tracker, and can be used in skill / custom action 
to download and process the image.

### Attachment with caption

An attachment sent to bot can be processed in custom actions / skills. Attachment URL and other details are stored in attchment
section of the inbound tracker. Also caption needs to be passed along with the attachment so that appropriate intent is triggered. 

## Outbound Message formats 

By default platform will support sending below responses, but the format would depend on the platform invoking the REST API. 

### Text 
Regular text messages with HTML formatting. 

### Buttons 
For static button contents, Buttons field in responses can be used.

### Images 
Send Images as attachment , Image can be a URL.

### Custom 

As supported by the platform using this REST API.