provider "aws" {
  region = "ap-southeast-1"
}

# -----------------------------
# Fetch secret from Secrets Manager
# -----------------------------
data "aws_secretsmanager_secret_version" "docdb_staging" {
  secret_id = "staging/docdb/master"
}

locals {
  docdb_creds = jsondecode(data.aws_secretsmanager_secret_version.docdb_staging.secret_string)
}

# -----------------------------
# VPC Module
# -----------------------------
module "vpc" {
  source              = "../../modules/vpc"
  name                = "staging"
  vpc_cidr            = "10.0.0.0/16"
  availability_zones  = ["ap-southeast-1a", "ap-southeast-1b"]
  private_subnets     = ["10.0.1.0/24", "10.0.2.0/24"]
  public_subnets      = ["10.0.101.0/24", "10.0.102.0/24"]
  tags = {
    Environment = "staging"
    Project     = "myapp"
  }
}

# -----------------------------
# DocumentDB Module
# -----------------------------
module "docdb_staging" {
  source                 = "../../modules/documentdb"
  name                   = "staging-docdb"
  master_username        = local.docdb_creds.username
  master_password        = local.docdb_creds.password
  instance_count         = 1
  instance_class         = "db.t3.medium"

  subnet_ids             = module.vpc.private_subnet_ids
  vpc_security_group_ids = ["sg-private-only-subnet-ip-allowed"] # replace this with dynamic SG if needed

  tags = {
    Environment = "staging"
    Project     = "myapp"
  }
}

