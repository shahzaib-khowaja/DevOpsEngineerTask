provider "aws" {
  region = "ap-southeast-1"
}

# -----------------------------
# Fetch secret from Secrets Manager
# -----------------------------
data "aws_secretsmanager_secret_version" "docdb_prod" {
  secret_id = "prod/docdb/master"
}

locals {
  docdb_creds = jsondecode(data.aws_secretsmanager_secret_version.docdb_prod.secret_string)
}

# -----------------------------
# VPC Module
# -----------------------------
module "vpc" {
  source              = "../../modules/vpc"
  name                = "production"
  vpc_cidr            = "11.0.0.0/16"
  availability_zones  = ["ap-southeast-1a", "ap-southeast-1b"]
  private_subnets     = ["11.0.1.0/24", "11.0.2.0/24"]
  public_subnets      = ["11.0.101.0/24", "11.0.102.0/24"]
  tags = {
    Environment = "production"
    Project     = "myapp"
  }
}

# -----------------------------
# DocumentDB Module
# -----------------------------
module "docdb_production" {
  source                 = "../../modules/documentdb"
  name                   = "prod-docdb"
  master_username        = local.docdb_creds.username
  master_password        = local.docdb_creds.password
  instance_count         = 2
  instance_class         = "db.r5.large"

  subnet_ids             = module.vpc.private_subnet_ids
  vpc_security_group_ids = ["sg-private-only-subnet-ip-allowed"]

  tags = {
    Environment = "production"
    Project     = "myapp"
  }
}

