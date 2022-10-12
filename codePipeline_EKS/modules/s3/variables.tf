
variable "bucket_artifacts_name" {
  description = "The name of the bucket of codepipeline artifacts"
  type        = string
}

variable "tags" {
  description = "Tags to be applied to the codebuild project"
  type        = map(any)
}