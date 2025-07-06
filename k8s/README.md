# Kubernetes Manifests - Multi-Environment Deployment

This repository contains Kubernetes manifests for deploying backend and frontend applications across multiple environments using **GitOps** principles with **ArgoCD**.

## 📁 Directory Structure

```
k8s-manifests/
├── production/
│   └── staging/                    # Production-staging environment
│       ├── backend/
│       │   ├── configmap.yaml      # Backend configuration
│       │   ├── deployment.yaml     # Backend deployment
│       │   ├── external-secret.yaml # External secrets integration
│       │   ├── hpa.yaml            # Horizontal Pod Autoscaler
│       │   ├── ingress.yaml        # Load balancer and routing
│       │   ├── secret-store.yaml   # Secret store configuration
│       │   └── service.yaml        # Backend service
│       └── frontend/
│           ├── configmap.yaml      # Frontend configuration
│           ├── deployment.yaml     # Frontend deployment
│           ├── hpa.yaml            # Horizontal Pod Autoscaler
│           ├── ingress.yaml        # Load balancer and routing
│           └── service.yaml        # Frontend service
└── staging/                        # Development-staging environment
    ├── backend/
    │   ├── configmap.yaml          # Backend configuration
    │   ├── deployment.yaml         # Backend deployment
    │   ├── external-secret.yaml    # External secrets integration
    │   ├── hpa.yaml                # Horizontal Pod Autoscaler
    │   ├── ingress.yaml            # Load balancer and routing
    │   ├── secret-store.yaml       # Secret store configuration
    │   └── service.yaml            # Backend service
    └── frontend/
        ├── configmap.yaml          # Frontend configuration
        ├── deployment.yaml         # Frontend deployment
        ├── hpa.yaml                # Horizontal Pod Autoscaler
        ├── ingress.yaml            # Load balancer and routing
        └── service.yaml            # Frontend service
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

