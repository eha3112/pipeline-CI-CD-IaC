variable "role_codepipeline_name" {
  description = "Name of the IAM role of CodePipeline"
  type        = string
}

variable "role_codebuild_name" {
  description = "Name of the role of CodeBuild's resources"
  type        = string
}

variable "bucket_artifacts_name" {
  description = "Name of the bucket of codepipeline artifacts"
  type        = string
}

variable "bucket_source_code_name" {
  description = "Name of the bucket of Source code S3 in the codepipeline"
  type        = string
}

variable "tags" {
  description = "Tags to be applied to the codebuild project"
  type        = map(any)
}