variable "role_codepipeline_name" {
  description = "Name ..."
  type        = string
  default     = "role-codepipeline-mate"
}

variable "policy_codepipeline_name" {
  description = "Name ..."
  type        = string
  default     = "policy-codepipeline-mate"
}

variable "role_codebuild_name" {
  description = "Name ..."
  type        = string
  default     = "role-codebuild-mate"
}

variable "policy_codebuild_name" {
  description = "Name ..."
  type        = string
  default     = "policy-codebuild-mate"
}

variable "bucket_codepipeline_artifacts_name" {
  description = "The name of the bucket of codepipeline artifacts"
  type        = string
  default     = "artifacts-bucket-mate"
}

variable "bucket_source_codepipeline_name" {
  description = "The Name of the bucket of Source S3 in the codepipeline"
  type        = string
  default     = "source-bucket-eha"

}