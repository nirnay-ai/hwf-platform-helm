# HWF Chatbot 

Welcome to HWF Chatbot Platform, 

1. [Pre requisites](#pre-requisites) 
2. [Installation via Helm charts](#install-hwf-chatbot-platform) 
3. [TLS / SSL](#tls--ssl)
4. [Customizing Ingress](#customizing-ingress)
5. [Documentation](#documentation) 

## Pre Requisites 

This application has been built using Openfaas serverless framework and uses Minio object storage. Follow below instructions to prepare your environment

### - Installing OpenFaas

Follow below instructions to install OpenFaas

    helm repo add openfaas https://openfaas.github.io/faas-netes/
    
    helm repo update
    
    kubectl apply -f https://raw.githubusercontent.com/openfaas/faas-netes/master/namespaces.yml
    
    helm install openfaas openfaas/openfaas --namespace openfaas \
		--set functionNamespace=openfaas-fn \
		--set operator.create=true \
		--set generateBasicAuth=true \
		--set gateway.upstreamTimeout=14m \
		--set gateway.writeTimeout=15m \
		--set gateway.readTimeout=15m \
		--set faasnetes.writeTimeout=15m \
		--set faasnetes.readTimeout=15m \
		--set exposeServices=false \
		--set ingressOperator.create=true \
		--set queueWorker.ackWait=15m \
		--set clusterRole=true \
		--set rbac=true \
		--set openfaasPRO=false 

To retrieve OpenFaas admin password 

    kubectl -n openfaas get secret basic-auth -o jsonpath="{.data.basic-auth-password}" | base64 --decode


### - Installing MinIo

Follow below instructions to install Minio

    helm repo add bitnami https://charts.bitnami.com/bitnami

    helm install bitnami/minio  \
    --namespace minio \
    --create-namespace \
    --set fullnameOverride=minio \
    --generate-name

Get Access key and secret key 

    kubectl get secret --namespace minio minio -o jsonpath="{.data.access-key}" | base64 --decode
    
    kubectl get secret --namespace minio minio -o jsonpath="{.data.secret-key}" | base64 --decode


## Install HWF Chatbot platform

Create hwf-chatbot namespace 

    kubectl apply -f https://navigateconsulting.github.io/hwf-platform-helm/namespace.yaml

Install helm chart 

    helm repo add hwf-platform https://navigateconsulting.github.io/hwf-platform-helm/
    helm repo update
    helm install hwf-chatbot hwf-platform/hwf-chatbot --namespace hwf-chatbot

### - Setup Docker registry credentials as image pull secrets
** TODO Move these in Helm 

Create the image pull secret

    kubectl create secret docker-registry hwfregistrykey \
    --docker-server=https://index.docker.io/v1/ \
    --docker-username=<username> \
    --docker-password=<password> \
    --docker-email=<email>  \
	-n <namespace>

Patch the service account 

    kubectl patch serviceaccount default -p '{"imagePullSecrets": [{"name": "hwfregistrykey"}]}' -n <namespace> 


### - Helm Configuration options 

Additional hwf chatbot options in `values.yaml`.

| Parameter               | Description                           | Default                                                    |
| ----------------------- | ----------------------------------    | ---------------------------------------------------------- |
| `hwfplatform.registry` | Registry name to pull images | `localhost:32000` |
| `hwfplatform.tag` | Version of the application to be installed | `latest` |


## TLS / SSL
TBA

## Customizing Ingress
TBA

## Documentation 

Documentation links below.

### Channels
HWF Chatbot platform supports multiple input channels by default, below are the details. 
  - [REST](./docs/channel-rest.md)
  - [Teams](./docs/channel-teams.md)
  - [Telegram](./docs/channel-telegram.md)
  - [WhatsApp](./docs/channel-whatsapp.md)

### External Events
There may be a case when we need to notify user of an event which has occoured externally. 
For example if there is any workflow which needs to be approved by the user, we might need to inform the user asynchronously
about the pending workflow approval. External events can be used in such cases.

Any application can send a message back to the user with an event. Chatbot would process the message and 
send the response back to user. All the calling application needs to do is inform the intent and fill in the required slots
and chatbot would take care of communicating it to the user. 

Below would be the request format. 

Method: POST

URL: http://{domain_name}/external/{project_name}/{secret_token}/{conversation_id}

Body: {"name": "EXTERNAL_dry_plant", "entities": {"plant": "Orchid"}}
