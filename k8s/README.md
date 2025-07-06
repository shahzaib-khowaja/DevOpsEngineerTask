# Kubernetes Manifests - Multi-Environment Deployment

This repository contains Kubernetes manifests for deploying backend and frontend applications across multiple environments using **GitOps** principles with **ArgoCD**.

## 📁 Directory Structure

```
k8s/
production
│   ├── argocd
│   │   ├── backend
│   │   │   └── application.yaml
│   │   ├── frontend
│   │   │   └── application.yaml
│   │   └── README.md
│   ├── backend
│   │   ├── configmap.yaml
│   │   ├── deployment.yaml
│   │   ├── external-secret.yaml
│   │   ├── hpa.yaml
│   │   ├── ingress.yaml
│   │   ├── secret-store.yaml
│   │   └── service.yaml
│   └── frontend
│       ├── configmap.yaml
│       ├── deployment.yaml
│       ├── hpa.yaml
│       ├── ingress.yaml
│       └── service.yaml
├── README.md
└── staging
    ├── argocd
    │   ├── backend
    │   │   └── application.yaml
    │   ├── frontend
    │   │   └── application.yaml
    │   └── README.md
    ├── backend
    │   ├── configmap.yaml
    │   ├── deployment.yaml
    │   ├── external-secret.yaml
    │   ├── hpa.yaml
    │   ├── ingress.yaml
    │   ├── secret-store.yaml
    │   └── service.yaml
    └── frontend
        ├── configmap.yaml
        ├── deployment.yaml
        ├── hpa.yaml
        ├── ingress.yaml
        └── service.yaml

```

## 🏗️ Architecture Overview

### Environment Strategy
- **`staging/`** - Development and testing environment
- **`production/staging/`** - Production-ready staging environment

### Component Structure
Each environment contains identical structure for consistency:

```
Environment
├── backend/     # API/Backend services
└── frontend/    # Web/Frontend services
```

## 📋 Manifest Descriptions

### Core Components

| File | Purpose | Description |
|------|---------|-------------|
| **`deployment.yaml`** | Application Deployment | Defines pods, containers, replicas, and resources |
| **`service.yaml`** | Service Discovery | Exposes pods internally within cluster |
| **`ingress.yaml`** | Load Balancer | Routes external traffic to services |
| **`configmap.yaml`** | Configuration | Non-sensitive configuration data |
| **`hpa.yaml`** | Auto Scaling | Horizontal Pod Autoscaler configuration |

### Security Components

| File | Purpose | Description |
|------|---------|-------------|
| **`external-secret.yaml`** | Secret Management | Integrates with external secret stores (AWS Secrets Manager) |
| **`secret-store.yaml`** | Secret Store Config | Defines connection to external secret providers |

