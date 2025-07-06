provider "aws" {
  region = "ap-southeast-1"
}

data "aws_secretsmanager_secret_version" "docdb_prod" {
  secret_id = "prod/docdb/master"
}

locals {
  docdb_creds = jsondecode(data.aws_secretsmanager_secret_version.docdb_prod.secret_string)
}

module "docdb_production" {
  source                 = "../../modules/documentdb"
  name                   = "prod-docdb"
  master_username        = local.docdb_creds.username
  master_password        = local.docdb_creds.password
  instance_count         = 2
  instance_class         = "db.r5.large"
  subnet_ids             = ["subnet-private-1a", "subnet-private-1b"]
  vpc_security_group_ids = ["sg-private-only-subnet-ip-allowed"]
  tags = {
    Environment = "production"
    Project     = "myapp"
  }
}

