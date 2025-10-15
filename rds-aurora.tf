# ===============================================
# Amazon Aurora PostgreSQL Serverless v2
# ===============================================

# 2.1. Security Group
resource "aws_security_group" "db_sg" {
  name        = "${var.project_name}-db-sg"
  description = "Allow inbound traffic to Aurora PostgreSQL"
  vpc_id      = var.vpc_id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.project_name}-db-sg"
  }
}

# 2.2. Subnet Group for Cluster DB
resource "aws_db_subnet_group" "db_subnet_group" {
  name       = "${var.project_name}-db-subnet-group"
  subnet_ids = var.vpc_subnet_ids

  tags = {
    Name = "${var.project_name}-db-subnet-group"
  }
}

# 2.3. Cluster Aurora (Aurora Serverless v2)
resource "aws_rds_cluster" "aurora_cluster" {
  cluster_identifier     = "${var.project_name}-aurora-pg"
  engine                 = "aurora-postgresql"
  engine_version         = "14.8"
  database_name          = "appdb"
  master_username        = var.db_username
  master_password        = var.db_password
  db_subnet_group_name   = aws_db_subnet_group.db_subnet_group.name
  vpc_security_group_ids = [aws_security_group.db_sg.id]
  skip_final_snapshot    = true # For dev/test environment

  serverlessv2_scaling_configuration {
    min_capacity = 0.5
    max_capacity = 2.0
  }

  tags = {
    Name = "${var.project_name}-aurora-cluster"
  }
}

# 2.4. Cluster instance
resource "aws_rds_cluster_instance" "cluster_instance_writer" {
  identifier          = "${var.project_name}-instance-writer"
  cluster_identifier  = aws_rds_cluster.aurora_cluster.id
  instance_class      = "db.serverless"
  engine              = aws_rds_cluster.aurora_cluster.engine
  engine_version      = aws_rds_cluster.aurora_cluster.engine_version
  publicly_accessible = false

  tags = {
    Name = "${var.project_name}-instance-writer"
  }
}
