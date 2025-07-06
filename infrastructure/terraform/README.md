# Terraform AWS DocumentDB with Secrets Manager

This repository contains infrastructure-as-code for provisioning **Amazon DocumentDB (MongoDB-compatible)** clusters using **Terraform**, with support for both **staging** and **production** environments. Credentials (username and password) are securely managed through **AWS Secrets Manager**.

---

## 📁 Directory Structure

terraform/
├── environments/
│ ├── staging/
│ │ └── main.tf
│ └── production/
│ └── main.tf
└── modules/
└── documentdb/
├── main.tf
├── variables.tf
└── outputs.tf
---

## 🔐 Secure Credential Management

Credentials for the DocumentDB cluster are **not hardcoded**. Instead, they are stored in **AWS Secrets Manager** and retrieved using Terraform’s data source:

```hcl
data "aws_secretsmanager_secret_version" "docdb" {
  secret_id = "staging/docdb/master"  # or "prod/docdb/master"
}

---

## 🔐 Secure Credential Management

Credentials for the DocumentDB cluster are **not hardcoded**. Instead, they are stored in **AWS Secrets Manager** and retrieved using Terraform’s data source:

```hcl
data "aws_secretsmanager_secret_version" "docdb" {
  secret_id = "staging/docdb/master"  # or "prod/docdb/master"
}

🛠 Prerequisites
Terraform v1.3 or higher

AWS CLI configured (aws configure)

Access to:

Secrets Manager

DocumentDB

🚀 How to Use
1. Clone the Repository
bash
Copy
Edit
git clone https://github.com/your-org/terraform-docdb.git
cd terraform-docdb/terraform/environments/staging
2. Create Secrets in AWS Secrets Manager
Staging
bash
Copy
Edit
aws secretsmanager create-secret \
  --name staging/docdb/master \
  --secret-string '{"username":"stagingadmin","password":"stagingPassword123!"}'
Production
bash
Copy
Edit
aws secretsmanager create-secret \
  --name prod/docdb/master \
  --secret-string '{"username":"prodadmin","password":"prodPassword123!"}'
3. Initialize Terraform
bash
Copy
Edit
terraform init
4. Apply the Configuration
bash
Copy
Edit
terraform apply
Type yes when prompted to approve resource creation.

🧹 Destroying Infrastructure
To destroy resources created by Terraform:

bash
Copy
Edit
terraform destroy
📦 Module Inputs
Variable	Description	Type	Required
name	Prefix for cluster and resources	string	✅
master_username	Username from Secrets Manager	string	✅
master_password	Password from Secrets Manager	string	✅
instance_count	Number of cluster instances	number	✅
instance_class	Instance type (db.t3.medium, etc.)	string	✅
subnet_ids	List of subnet IDs	list(string)	✅
vpc_security_group_ids	List of security group IDs	list(string)	✅
tags	Tags to apply	map(string)	❌


