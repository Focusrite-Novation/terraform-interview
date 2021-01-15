resource "aws_db_subnet_group" "rds" {
  name       = "postgres_subnets"
  subnet_ids = [aws_subnet.public_subnet.id]
}

resource "aws_db_instance" "rds" {
  allocated_storage               = 40
  backup_retention_period         = 7
  backup_window                   = "01:00-01:30"
  db_subnet_group_name            = "postgres_subnets"
  deletion_protection             = false
  enabled_cloudwatch_logs_exports = [ "postgresql" ]
  engine                          = "postgres"
  engine_version                  = "10.13"
  final_snapshot_identifier       = "final"
  instance_class                  = "db.m5.24xlarge"
  multi_az                        = false
  name                            = "products"
  password                        = "password123"
  port                            = 5432
  publicly_accessible             = true
  username                        = "postgres"
  vpc_security_group_ids          = [aws_security_group.rds.id]
}


resource "aws_security_group" "rds" {
  name = "rds-sg"

  vpc_id      = aws_vpc.vpc.id

  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
