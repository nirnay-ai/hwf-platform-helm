# Channel Configuration - Telegram 

## Callback URL Configuration

Callback URL - https://domain/bot/telegram/{assistant_name}/{token}

## Channel Configuration 

Configuration steps for telegram bot via BotFather

## HWF Configuration

Below are the required fields for configuration of Telegram channel in HWF. 

- Auth Token - Retrieved from bot registration process with BotFather
- Host - Autopopulated with the dns name where application is hosted
- Secret Code - Set a value, and it will be used in callback URL.
- Telegram Reply URL - Callback URl generated based on details provided. This call back URl would be set on teams on startup

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
Regular text messages with formatting. Check [this](https://core.telegram.org/api/entities) doc on how to format text messages 

### Buttons 
For static button contents, Buttons field in responses can be used. For more complex usecase use custom field.

### Images 
Send Images as attachment , Image can be a URL , or a media sent over to telegram. (As of now only URL supported)

### Custom 

Telegram supports two forms of button layouts , inline buttons and keyboards. Inline keyboards are easier to use
as they do not need to be reverted as is needed in case of keyboard. So prefered way of handling buttons is inline method.
If in case keyboard buttons are to be used , resetting the keyboard layout is not yet supported. 

Please refer docs [here](https://core.telegram.org/bots#keyboards)
