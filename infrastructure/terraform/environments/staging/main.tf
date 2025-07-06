provider "aws" {
  region = "ap-southeast-1"
}

# Fetch secret from AWS Secrets Manager
data "aws_secretsmanager_secret_version" "docdb_staging" {
  secret_id = "staging/docdb/master"
}

locals {
  docdb_creds = jsondecode(data.aws_secretsmanager_secret_version.docdb_staging.secret_string)
}

module "docdb_staging" {
  source                 = "../../modules/documentdb"
  name                   = "staging-docdb"
  master_username        = local.docdb_creds.username
  master_password        = local.docdb_creds.password
  instance_count         = 1
  instance_class         = "db.t3.medium"
  subnet_ids             = ["subnet-private-1a", "subnet-private-1b"]
  vpc_security_group_ids = ["sg-private-only-subnet-ip-allowed"]
  tags = {
    Environment = "staging"
    Project     = "myapp"
  }
}

