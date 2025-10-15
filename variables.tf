variable "project_name" {
  description = "Prefix for resource names"
  type        = string
}

variable "aws_region" {
  description = "AWS region"
  type        = string
}

# ===============================================
# RDS - Aurora
# ===============================================
variable "db_username" {
  description = "Database master username"
  type        = string
}

variable "db_password" {
  description = "Database master password"
  type        = string
  sensitive   = true
}

# ===============================================
# VPC
# ===============================================
variable "vpc_id" {
  description = "Existing VPC ID"
  type        = string
}

variable "vpc_subnet_ids" {
  description = "VPC Subnet IDs"
  type        = list(string)
}
