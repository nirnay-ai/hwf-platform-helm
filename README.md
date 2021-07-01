# hwf-chatbot-helm
Helm Chat for HWF Chatbot 

## Test chats by running lint 

    helm lint hwf-charts/*

## Create Helm package

    helm package hwf-charts/* -d ./packages

## Create the index file

    helm repo index --url https://github.com/navigateconsulting/hwf-chatbot-helm .

## Add the repo 

    helm repo add hwf-platform https://navigateconsulting.github.io/hwf-chatbot-helm/

## Regenerate index file when new chart is added 

    helm repo index --url https://navigateconsulting.github.io/hwf-chatbot-helm/ --merge index.yaml .