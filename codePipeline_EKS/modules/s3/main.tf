

resource "aws_s3_bucket" "bucket_codepipeline" {
  bucket = var.bucket_artifacts_name
  tags = var.tags
  force_destroy = true
}

resource "aws_s3_bucket_acl" "codepipeline_bucket_acl" {
  bucket = aws_s3_bucket.bucket_codepipeline.id
  acl    = "private"
}