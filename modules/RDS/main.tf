resource "random_string" "secure_string" {
  length           = 16
  special          = true
  min_upper        = 1
  override_special = "!$%^"
}

resource "aws_ssm_parameter" "secret" {
  name        = "/${var.environment}/${var.db_name}_database/password/master"
  description = "${var.db_name} RDS password"
  type        = "SecureString"
  value       = random_string.secure_string.result
}

resource "aws_db_subnet_group" "db_subnets" {
  name        = "${var.db_name}_db_subnets"
  description = "${var.db_name} RDS Subnet Group"
  subnets_ids = var.target_subnets
}

resource "aws_security_group" "db_sg" {
  name        = "${var.db_name}_db_sg"
  description = "${var.db_name} RDS Security Group"
  egress {
    cidr_blocks = [var.cidr_block_target_vpc]
    from_port   = 443
    protocol    = "tcp"
    to_port     = 443
  }
  ingress {
    cidr_blocks = [var.cidr_block_target_vpc]
    from_port   = var.db_port
    protocol    = "tcp"
    to_port     = var.db_port
  }
  vpc_id = var.target_vpc
}

resource "aws_db_instance" "db_instance" {
  allocated_storage         = var.allocated_storage
  backup_retention_period   = var.backup_retention_days
  backup_window             = var.backup_window
  copy_tags_to_snapshot     = true
  db_subnet_group_name      = aws_db_subnet_group.db_subnets.name
  engine                    = var.engine
  engine_version            = var.engine_version
  final_snapshot_identifier = "${var.db_name}-final-snapshot"
  instance_class            = var.instance_class
  identifier                = var.identifier
  kms_key_id                = var.kms_key_id
  max_allocated_storage     = var.max_allocated_storage
  multi_az                  = var.multi_az_enabled
  name                      = var.db_name
  password                  = aws_ssm_parameter.secret.value
  storage_encrypted         = var.encrypted_enabled
  username                  = var.db_username
  vpc_security_group_ids    = [aws_security_group.db_sg.id]

  tags = merge(
    {
      environment = var.environment
      name        = var.db_name
    },
    var.tags
  )
}