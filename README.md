# Helm Charts for HWF Platform

This Repo contains helm chart for below applications 
- HWF Chatbot 

## Quick Installer

Download the sh and run to automate deployment 

## Release steps 

1. To release new chart version , commit to main with new version in corresponding charts.yaml

## Development environment setup.

Installing k8s distribution 

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
    helm install hwf-chatbot hwf-platform/hwf-chatbot --namespace hwf-chatbot


# Application Install Instructions.

## Install Openfaas 


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
		--set rbac=false \
		--set openfaasPRO=false 
        
To retrive admin password 


    kubectl -n openfaas get secret basic-auth -o jsonpath="{.data.basic-auth-password}" | base64 --decode

## Install Minio


    helm repo add bitnami https://charts.bitnami.com/bitnami
    helm install bitnami/minio  --namespace minio --create-namespace --set fullnameOverride=minio --generate-name

Get Access key and secret key 

    kubectl get secret --namespace minio minio -o jsonpath="{.data.access-key}" | base64 --decode
    kubectl get secret --namespace minio minio -o jsonpath="{.data.secret-key}" | base64 --decode

## Prerequisites for installing hwf-chatbot 

    kubectl apply -f https://navigateconsulting.github.io/hwf-platform-helm/namespace.yaml

