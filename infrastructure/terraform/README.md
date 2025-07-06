# Terraform AWS DocumentDB with Secrets Manager

This repository contains infrastructure-as-code for provisioning **Amazon DocumentDB (MongoDB-compatible)** clusters using **Terraform**, with support for both **staging** and **production** environments. Credentials (username and password) are securely managed through **AWS Secrets Manager**.

## 📁 Directory Structure

```
infrastructure/terraform/
├── environments/
│   ├── staging/
│   │   └── main.tf
│   └── production/
│       └── main.tf
└── modules/
    └── documentdb/
        ├── main.tf
        ├── variables.tf
        └── outputs.tf
```

## 🔐 Secure Credential Management

Credentials for the DocumentDB cluster are **not hardcoded**. Instead, they are stored in **AWS Secrets Manager** and retrieved using Terraform's data source:

```hcl
data "aws_secretsmanager_secret_version" "docdb" {
  secret_id = "staging/docdb/master"  # or "prod/docdb/master"
}
```

### Example Secret Format

```json
{
  "username": "adminuser",
  "password": "yourStrongPassword123"
}
```

## 🛠 Prerequisites

Before getting started, ensure you have:

- **Terraform** v1.3 or higher
- **AWS CLI** configured (`aws configure`)
- Access to:
  - AWS Secrets Manager
  - Amazon DocumentDB
  - Subnets and Security Groups in your VPC

## 🚀 Quick Start

### 1. Clone the Repository

```bash
git clone https://github.com/your-org/your-repo.git
cd your-repo/infra/terraform/environments/staging
```

### 2. Create Secrets in AWS Secrets Manager

**For Staging:**
```bash
aws secretsmanager create-secret \
  --name staging/docdb/master \
  --secret-string '{"username":"stagingadmin","password":"stagingPassword123!"}'
```

**For Production:**
```bash
aws secretsmanager create-secret \
  --name prod/docdb/master \
  --secret-string '{"username":"prodadmin","password":"prodPassword123!"}'
```

### 3. Initialize Terraform

```bash
terraform init
```

### 4. Deploy Infrastructure

```bash
terraform plan   # Review changes
terraform apply  # Deploy resources
```

Type `yes` when prompted to confirm the deployment.

## 📦 Module Configuration

### Input Variables

| Variable | Description | Type | Required | Default |
|----------|-------------|------|----------|---------|
| `name` | Prefix for cluster and resources | `string` | ✅ | - |
| `master_username` | Username from Secrets Manager | `string` | ✅ | - |
| `master_password` | Password from Secrets Manager | `string` | ✅ | - |
| `instance_count` | Number of cluster instances | `number` | ✅ | - |
| `instance_class` | Instance type (db.t3.medium, etc.) | `string` | ✅ | - |
| `subnet_ids` | List of subnet IDs | `list(string)` | ✅ | - |
| `vpc_security_group_ids` | List of security group IDs | `list(string)` | ✅ | - |
| `tags` | Tags to apply to resources | `map(string)` | ❌ | `{}` |

### Output Values

| Output | Description |
|--------|-------------|
| `cluster_endpoint` | DocumentDB cluster endpoint |
| `cluster_port` | DocumentDB cluster port |
| `cluster_identifier` | DocumentDB cluster identifier |

## 🏗️ Architecture Overview

```
┌─────────────────────────────────────────────────────────────────┐
│                          AWS Account                            │
├─────────────────────────────────────────────────────────────────┤
│  ┌─────────────────┐    ┌─────────────────┐                    │
│  │ Secrets Manager │    │   DocumentDB    │                    │
│  │                 │    │                 │                    │
│  │ staging/docdb/  │◄───┤   Cluster       │                    │
│  │ master          │    │                 │                    │
│  │                 │    │ ┌─────────────┐ │                    │
│  │ {               │    │ │ Instance 1  │ │                    │
│  │   "username":   │    │ │ Instance 2  │ │                    │
│  │   "password":   │    │ │ Instance N  │ │                    │
│  │ }               │    │ └─────────────┘ │                    │
│  └─────────────────┘    └─────────────────┘                    │
│                                │                                │
│                                ▼                                │
│  ┌─────────────────────────────────────────────────────────────┐│
│  │                         VPC                                 ││
│  │  ┌─────────────┐  ┌─────────────┐  ┌─────────────┐        ││
│  │  │   Subnet    │  │   Subnet    │  │   Subnet    │        ││
│  │  │     AZ-A    │  │     AZ-B    │  │     AZ-C    │        ││
│  │  └─────────────┘  └─────────────┘  └─────────────┘        ││
│  └─────────────────────────────────────────────────────────────┘│
└─────────────────────────────────────────────────────────────────┘
```

