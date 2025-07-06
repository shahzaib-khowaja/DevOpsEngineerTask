#!/bin/bash

set -e

NAMESPACE=logging

echo "Creating namespace (if not exists)..."
kubectl get ns $NAMESPACE || kubectl create ns $NAMESPACE

echo "Adding Elastic Helm repo..."
helm repo add elastic https://helm.elastic.co
helm repo update

echo "Installing Elasticsearch..."
helm upgrade --install elasticsearch elastic/elasticsearch \
  --namespace $NAMESPACE \
  -f monitoring/elasticsearch-values.yaml \
  --wait

echo "Elasticsearch installed"

echo "Installing Kibana"
helm upgrade --install kibana elastic/kibana \
  --namespace $NAMESPACE \
  -f monitoring/kibana-values.yaml \
  --wait

echo "Kibana installed"

echo "🔧 Installing APM Server"
helm upgrade --install apm-server elastic/apm-server \
  --namespace $NAMESPACE \
  -f monitoring/apm-server-values.yaml \
  --wait

echo "APM Server installed"

echo "Installing Filebeat"
helm upgrade --install filebeat elastic/filebeat \
  --namespace $NAMESPACE \
  -f monitoring/filebeat-values.yaml \
  --wait

echo "Filebeat installed"

echo "Elastic Stack is fully deployed in namespace '$NAMESPACE'"

