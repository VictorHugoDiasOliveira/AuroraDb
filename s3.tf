# ===============================================
# Amazon S3 Bucket
# ===============================================

resource "aws_s3_bucket" "aurora_bucket" {
  bucket = "${var.project_name}-bucket-s3-aurora-db"

  tags = {
    Name = "${var.project_name}-bucket-s3-aurora-db"
  }
}

resource "aws_s3_bucket_public_access_block" "block_public_access" {
  bucket                  = aws_s3_bucket.aurora_bucket.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}
