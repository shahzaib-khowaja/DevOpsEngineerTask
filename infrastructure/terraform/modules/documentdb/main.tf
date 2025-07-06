resource "aws_docdb_subnet_group" "this" {
  name       = "${var.name}-subnet-group"
  subnet_ids = var.subnet_ids
}

resource "aws_docdb_cluster" "this" {
  cluster_identifier      = "${var.name}-cluster"
  master_username         = var.master_username
  master_password         = var.master_password
  engine                  = "docdb"
  backup_retention_period = 7
  preferred_backup_window = "07:00-09:00"
  db_subnet_group_name    = aws_docdb_subnet_group.this.name
  vpc_security_group_ids  = var.vpc_security_group_ids
  storage_encrypted       = true
  tags                    = var.tags
}

resource "aws_docdb_cluster_instance" "this" {
  count              = var.instance_count
  identifier         = "${var.name}-instance-${count.index + 1}"
  cluster_identifier = aws_docdb_cluster.this.id
  instance_class     = var.instance_class
  tags               = var.tags
}

