# hwf-chatbot-helm
Helm Chat for HWF Chatbot 

## Test chats by running lint 

    helm lint hwf-charts/*

## Create Helm package

    helm package hwf-charts/* -d ./packages

## Create the index file

    helm repo index --url https://github.com/navigateconsulting/hwf-platform-helm .

## Regenerate index file when new chart is added 

    helm repo index --url https://navigateconsulting.github.io/hwf-platform-helm/ --merge index.yaml .

## Add the repo and use it.

    helm repo add hwf-platform https://navigateconsulting.github.io/hwf-platform-helm/
    helm repo update
    helm install hwf-platform/hwf-chatbot --namespace hwf-chatbot --generate-name

d
