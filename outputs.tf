output "s3_bucket_name" {
  description = "S3 Bucket name"
  value       = aws_s3_bucket.aurora_bucket.id
}

output "aurora_cluster_endpoint" {
  description = "Aurora cluster endpoint"
  value       = aws_rds_cluster.aurora_cluster.endpoint
}

output "aurora_db_port" {
  description = "Aurora cluster port"
  value       = aws_rds_cluster.aurora_cluster.port
}
