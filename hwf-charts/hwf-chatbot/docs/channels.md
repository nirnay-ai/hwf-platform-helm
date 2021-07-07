# Channels and Message Formats.

Below are the channels supported in HWF Chatbot platform. And there limitations, usages etc 

## Microsoft Teams 

### Configuration 

Configuring Microsoft Teams Bot Framework account. 


### Media Types supported 

#### Output 

##### Text

HTML Text responses are supported by Teams, for formatting etc please check this [link](https://docs.microsoft.com/en-us/azure/bot-service/rest-api/bot-framework-rest-connector-create-messages?view=azure-bot-service-4.0) 

#### Image 

Images can be sent as an HTML content. For better formatting and sizing options Custom type can be used.

#### Buttons 

For static button contents, Buttons field in responses can be used. For more complex usecase use custom field.

#### Custom / Templates / Cards etc

Teams supports wide range of message types as documented [here](https://docs.microsoft.com/en-us/azure/bot-service/rest-api/bot-framework-rest-connector-add-rich-cards?view=azure-bot-service-4.0). All these custom message types can be used in Custom section of responses.

##### Proactive Messages 
TBD

#### Input

- Text 
- Image 
    - Images sent should contain caption , the text is sent to chatbot for NLP, and the image is passed on as attachment metadata to chatbot 

## Whatsapp 

### Configuration 

Connection to whatsapp can be established only from Whatsapp's Business Service Providers. Currently there exists 2 types of service providers 
-  SMS Providers + Whatsapp for Business providers

This group has custom libraries / endpoints to integrate with whatsapp, and support for these BSP's would be added in HWF as per demand.

- CRM / Pure play Whatsapp Business providers 

This group generally provides API's which are similar to Whatsapp's [documented](https://developers.facebook.com/docs/whatsapp) API's, and we have a generic API implementation in the platform. 
Hence, these BSP's are easier to integrate and with minor configurations these can be added to the plaform. 


#### BSP's Currently supported 

- [WATI](https://www.wati.io/) 

### Media Types supported.

#### Output

##### Text 

Regular text messages with formatting. Check [this](https://developers.facebook.com/docs/whatsapp/api/messages#formatting) doc on how to format Whatsapp Text messages 

##### Images (URL Only)

Send Images as attachment , Image can be a URL , or a media sent over to whatsapp. (As of now only URL supported)

#### Buttons 

buttons not directly supported for whatsapp. Can be considered infuture. use templates for sending buttons 

##### Custom / Templates  

Whatsapp supports messages with buttons and quick replies, but these messages are considered as templates and these needs to be 
approved before-hand by facebook to be used as response. Ref documentation [here](https://developers.facebook.com/docs/whatsapp/api/messages/message-templates/interactive-message-templates/)  
Once the template is approved , the template content can be passed in response's section in custom field.

##### Proactive Messages 
TBD

#### Input

- Text 
- Image 
    - Images sent should contain caption , the text is sent to chatbot for NLP, and the image is passed on as attachment metadata to chatbot 


## Telegram 

### Configuration 

To create a bot in telegram follow the link. Essentially its about talking to BotFather and getting access tokens.
Once the token is obtained same can be used in the application directly to configure the bot.

### Media Types supported.

#### Output 
##### Text 

Regular text messages with formatting. Check [this](https://core.telegram.org/api/entities) doc on how to format text messages 

##### Images (URL Only)

Send Images as attachment , Image can be a URL , or a media sent over to whatsapp. (As of now only URL supported)

#### Buttons 

For static button contents, Buttons field in responses can be used. For more complex usecase use custom field.

##### Custom / Forms 

Telegram supports two forms of button layouts , inline buttons and keyboards. Inline keyboards are easier to use
as they do not need to be reverted as is needed in case of keyboard. So prefered way of handling buttons is inline method.
If in case keyboard buttons are to be used , resetting the keyboard layout is not yet supported. 

Please refer docs [here](https://core.telegram.org/bots#keyboards)

##### Proactive Messages 
TBD

#### Input

- Text 
- Image 
    - Images sent should contain caption , the text is sent to chatbot for NLP, and the image is passed on as attachment metadata to chatbot 

## REST API

### Configuration 

REST Channel is useful for any custom chat interface. Set up a secret key which will be used to 
call the API. this channel buffers the messages from chatbot till the chat interface fetches updates 
via the get messages API. 

Two API's are in use for this channel.
- Inbound API  (/bot/rest/agent/token)
  This API will pass the contents over to chatbot backend and save the responses in a redis queue.

- Outbound (/bot/rest/get/agent/token/user_id)
  This API will retrieve the messages' bot has sent to a specific user. 
  All messages once retrieved are cleared from redis cache

### Media Types supported.

#### Output 
##### Text 

Regular text messages with HTML formatting. 

##### Images (URL Only)

Send Images as attachment , Image can be a URL , or a media. (As of now only URL supported)

#### Buttons 

For static button contents, Buttons field in responses can be used. For more complex usecase use custom field.

##### Custom / Forms 

Format for buttons forms etc is dependent on the chat platform in use. Use custom response template and pass on 
any content from hwf responses to the chat UI interface. 

##### Proactive Messages 
TBD

#### Input

- Text 
- Image 
    - Images sent should contain caption , the text is sent to chatbot for NLP, and the image is passed on as attachment metadata to chatbot 
