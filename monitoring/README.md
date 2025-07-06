# Elastic Stack Setup

This folder installs:
- Elasticsearch
- Kibana
- APM Server
- Filebeat

## 📊 Elastic Stack Monitoring Setup

This directory contains the complete setup to deploy a production-ready Elastic Stack (ELK + APM) for centralized logging and performance monitoring in your Kubernetes cluster.

## ✅ What's Included

The following components are deployed using Helm in the `logging` namespace:

Component         | Purpose
------------------|-----------------------------------------
Elasticsearch     | Central log and metrics storage
Kibana            | Visualization and dashboard interface
APM Server        | Application performance monitoring
Filebeat          | Log collector from Kubernetes pods

## 🚀 How to Deploy

From the root of the repo or inside `monitoring/`, run:

chmod +x install-elastic-stack.sh
./install-elastic-stack.sh

Make sure Helm is installed and your cluster is configured (e.g., EKS or Minikube).

## 🔍 Application Monitoring with APM

This setup enables Elastic APM for monitoring your application performance, transactions, and errors.

### 🧪 Example: Node.js APM Integration

Install the APM agent in your application:

npm install elastic-apm-node --save

In your main entry file (index.js or app.js), add this at the very top:

require('elastic-apm-node').start({
  serviceName: 'naqdi-backend',
  serverUrl: 'http://apm-server-logging.logging.svc.cluster.local:8200',
  environment: 'staging',
  secretToken: '', // Optional, if set in apm-server config
});

After deployment, traces and transactions will be visible in Kibana → APM tab.

## 📄 Logs with Filebeat

Filebeat is deployed as a DaemonSet and automatically collects logs from all containers in your cluster. It forwards them to Elasticsearch, where they can be queried and visualized in Kibana under the Discover tab.

## 📈 Want to Add System Metrics?

You can extend the stack by installing Metricbeat:

helm upgrade --install metricbeat elastic/metricbeat \
  --namespace logging \
  --set output.elasticsearch.hosts[0]=http://elasticsearch-master:9200

This will collect:

- Node CPU/memory usage
- Pod and container metrics
- Kubelet stats
- Disk/Network stats

All of which can be visualized in Kibana.

## 🌐 Ingress Access

Ensure these domains are routed to your AWS ALB:

Service         | Domain
----------------|-------------------------------
Kibana          | kibana-staging.abc.com
APM Server      | apm-staging.abc.com
Elasticsearch   | elasticsearch-staging.abc.com

Check your Ingress YAML in `infra/ingress.yaml` or wherever you manage ALB routes.

## 📂 Files Overview

monitoring/
├── install-elastic-stack.sh          # Script to install all components
├── elasticsearch-values.yaml         # Helm values for Elasticsearch
├── kibana-values.yaml                # Helm values for Kibana
├── apm-server-values.yaml            # Helm values for APM
├── filebeat-values.yaml              # Helm values for Filebeat
└── README.md                         # This guide

