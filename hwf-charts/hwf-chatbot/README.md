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

### - Helm Configuration options 

Additional hwf chatbot options in `values.yaml`.

| Parameter               | Description                           | Default                                                    |
| ----------------------- | ----------------------------------    | ---------------------------------------------------------- |
| `hwfplatform.registry` | Registry name to pull images | `localhost:32000` |
| `hwfplatform.tag` | Version of the application to be installed | `latest` |
|

## TLS / SSL
TBA

## Customizing Ingress
TBA

## Documentation 

Documentation links below.

- [Channels](./docs/channels.md)

