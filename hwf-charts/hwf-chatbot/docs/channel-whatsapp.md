# Channel Configuration - WhatsApp 

## Callback URL Configuration

Callback URL - https://domain/bot/whatsapp/{assistant_name}/{token}

## Channel Configuration 

Connection to whatsapp can be established only from Whatsapp's Business Service Providers. Currently there exists 2 types of service providers 
-  SMS Providers + Whatsapp for Business providers

This group has custom libraries / endpoints to integrate with whatsapp, and support for these BSP's would be added in HWF as per demand.

- CRM / Pure play Whatsapp Business providers 

This group generally provides API's which are similar to Whatsapp's [documented](https://developers.facebook.com/docs/whatsapp) API's, and we have a generic API implementation in the platform. 
Hence, these BSP's are easier to integrate and with minor configurations these can be added to the plaform. 


### BSP's Currently supported 

- [WATI](https://www.wati.io/) 

## HWF Configuration

Below are the required fields for configuration of WhatsApp channel in HWF. 

- Host  - Domain name / dns of the server where the application is installed.
- Token - Set a value and use it in callback URL.
- API Endpoint - Endpoint provided by the gateway provider
- Username - Username provided by the gateway provider
- Password - Password provided by the gateway provider

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

### Text 
Regular text messages with formatting. Check [this](https://developers.facebook.com/docs/whatsapp/api/messages#formatting) doc on how to format Whatsapp Text messages 

### Buttons 
buttons not directly supported for whatsapp. Can be considered infuture. use templates for sending buttons 

### Images 
Send Images as attachment , Image can be a URL , or a media sent over to whatsapp. (As of now only URL supported)

### Custom 
Whatsapp supports messages with buttons and quick replies, but these messages are considered as templates and these needs to be 
approved before-hand by facebook to be used as response. Ref documentation [here](https://developers.facebook.com/docs/whatsapp/api/messages/message-templates/interactive-message-templates/)  
Once the template is approved , the template content can be passed in response's section in custom field.
