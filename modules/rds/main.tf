resource "aws_db_instance" "main" {
  allocated_storage    = 10
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = var.instance_class
  name                 = var.db_name
  username             = var.username
  password             = var.password
  parameter_group_name = "default.mysql5.7"
  skip_final_snapshot  = true

  tags = {
    Name        = "${var.name}-rds-instance-${var.environment}"
    Environment = var.environment
  }
}

resource "aws_db_subnet_group" "default" {
  name       = "${var.name}-db-subnet-group-${var.environment}"
  subnet_ids = var.private_subnets

  tags = {
    Name        = "${var.name}-db-subnet-grp-${var.environment}"
    Environment = var.environment
  }
}