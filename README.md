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

    kubectl apply -f namespace.yaml
    kubectl apply -f minio-secret.yaml

Manual creation of Secrets and namespaces 
kubectl create namespace hwf-chatbot
kubectl annotate namespace/hwf-chatbot openfaas="1"
kubectl create secret generic minio-access --from-literal minio-access="{\"accessKey\":\"5uRFbSoFO9\",\"secretKey\":\"FdBw9vOIWZNvDRkBDouijJRZwcV7ATwGwecJNQ8L\"}" --namespace hwf-chatbot 
