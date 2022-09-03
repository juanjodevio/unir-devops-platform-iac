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
  multi_az = false
  # availability_zone = var.availability_zones
  db_subnet_group_name = aws_db_subnet_group.default.id
  vpc_security_group_ids = [aws_security_group.rdssg.id]
  tags = {
    Name        = "${var.name}-rds-instance-${var.environment}"
    Environment = var.environment
  }
}

resource "aws_subnet" "rds" {
  vpc_id            = var.vpc
  cidr_block        = element(var.private_subnets, count.index)
  availability_zone = element(var.availability_zones, count.index)
  count             = length(var.private_subnets)

  tags = {
    Name        = "${var.name}-private-rds-subnet-${var.environment}-${format("%03d", count.index+1)}"
    Environment = var.environment
  }
}

resource "aws_db_subnet_group" "default" {
  name       = "${var.name}-db-subnet-group-${var.environment}"
  subnet_ids = aws_subnet.rds.*.id

  tags = {
    Name        = "${var.name}-db-subnet-grp-${var.environment}"
    Environment = var.environment
  }
}


resource "aws_security_group" "rdssg" {
    name =  "${var.name}-db-security-group-${var.environment}"
    vpc_id =  var.vpc

    ingress {
        from_port = 3306
        to_port = 3306
        protocol = "tcp"
        cidr_blocks = var.app_subnets_cidr

    }

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = var.app_subnets_cidr

    }
}