

output "bucket_codepipeline_arn" {
  value = aws_s3_bucket.bucket_codepipeline.arn
}

output "role_codebuild_arn" {
  value = module.roles.role_codebuild_arn
}