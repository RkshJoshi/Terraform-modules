locals {
  commonTags = {
    Environment = var.envName
    AppName = "OpenData"
  }  
}

data "aws_caller_identity" "current" {}

data "aws_iam_policy_document" "kms_policy_doc"{
  statement {
    sid = "AllowAccesstoIAM"
    actions = [
      "kms:*"
    ]
    resources = ["*"]
    effect = "Allow"
    principals {
      identifiers = ["arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"]
      type = "AWS"
    }
  }
  statement {
    sid = "AllowAccesstoKMS"
    actions = [
      "kms:GenerateDataKey"
    ]
    effect = "Allow"
    resources = ["*"]
    principals {
      identifiers = ["pullthroughcache.ecr.amazonaws.com",
      "replication.ecr.amazonaws.com"]
      type = "Service"
    }
  }
  } 

data "aws_vpc" "vpc" {
  id = var.vpcId
}

data "aws_subnets" "privateSubnets"{
  
}

resource "aws_kms_key" "ckan_kms_key"{
  description = "KMS key for CKAN"
  deletion_window_in_days = 7
  is_enabled = true
  key_usage = "ENCRYPT_DECRYPT"
  policy = data.aws_iam_policy_document.kms_policy_doc.json
  tags = local.commonTags
}

resource "aws_ecr_repository" "ecr_repo" {
  for_each = var.repoName
  name = "${each.key}-${var.envName}-repo"
  image_tag_mutability = "IMMUTABLE"
  image_scanning_configuration {
    scan_on_push = true
  }
  force_delete = true
  encryption_configuration {
    encryption_type = "KMS"
    kms_key = aws_kms_key.ckan_kms_key.arn
  }
  tags = local.commonTags
}

resource "aws_db_subnet_group" "ckanDBSubnetGroup" {
  name = "ckan-db-subnetgroup-${var.envName}"
  subnet_ids = var.privateSubnets // can also restrieve subnetIds from data sources
  tags = local.commonTags
}

resource "aws_security_group" "rds_sg"{
  description = "Security group of DB Instance"
  name ="ckan_db_sg"
  vpc_id = data.aws_vpc.vpc.id
  ingress {
    description = "Allow inbound access from VPC"
    from_port = "5432"
    to_port = "5432"
    protocol = "tcp"
    cidr_blocks = [data.aws_vpc.vpc.cidr_block]
  }
  tags = local.commonTags
  lifecycle {
    create_before_destroy = true
  }

}

resource "aws_db_instance" "ckan_db"{
  allocated_storage = var.allocatedStorage
  allow_major_version_upgrade = var.autoMajorVersionUpgrade
  apply_immediately = true
  auto_minor_version_upgrade = var.autoMajorVersionUpgrade
  backup_retention_period = var.backupRetentionPeriod
  backup_window = var.backupWindow
  copy_tags_to_snapshot = true
  db_subnet_group_name = aws_db_subnet_group.ckanDBSubnetGroup.name
  delete_automated_backups = true
  deletion_protection = false
  engine = var.dbEngine
  engine_version = var.dbEngineVersion
  kms_key_id = aws_kms_key.ckan_kms_key.arn
  instance_class = "db.t3.micro"
  maintenance_window = "Mon:00:00-Mon:03:00"
  manage_master_user_password = true
  master_user_secret_kms_key_id = aws_kms_key.ckan_kms_key.arn
  multi_az = true
  storage_encrypted = true
  vpc_security_group_ids = [aws_db_subnet_group.ckanDBSubnetGroup.id]
  lifecycle {
    create_before_destroy = true
  }
}