

output "bucket_artifacts_name" {
    value = aws_s3_bucket.bucket_codepipeline.id 
}

output "bucket_artifacts_arn" {
    value = aws_s3_bucket.bucket_codepipeline.arn
} 
