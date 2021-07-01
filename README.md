# hwf-chatbot-helm
Helm Chat for HWF Chatbot 

## Test chats by running lint 

    helm lint hwf-charts/*

## Create Helm package

    helm package hwf-charts/* -d ./packages

## Create the index file

    helm repo index --url https://github.com/navigateconsulting/hwf-chatbot-helm .