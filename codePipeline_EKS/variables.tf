variable "region" {
  type    = string
  default = "eu-west-1"
}

variable "aws_credentials" {
  description = "aws credentials"
  type        = map(string)
  default = {
    AWS_ACCESS_KEY_ID     = "your_access_key_id"
    AWS_SECRET_ACCESS_KEY = "your_secret_access_key"
  }
  sensitive = true
}

variable "codepipeline_name" {
  description = "Name of the pipeline"
  type        = string
}


variable "role_codepipeline_name" {
  description = "Name the IAM role of CodePipeline"
  type        = string
}

variable "role_codebuild_name" {
  description = "Name of the role of CodeBuild's resources"
  type        = string
}

variable "source_type" {
  description = "S3 or Github"
  type        = string
}

variable "source_configuration_S3" {
  description = "the configuration of the S3 source bucket"
  type        = map(string)
  default = {
    S3Bucket    = "source-bucket-name"
    S3ObjectKey = "code.zip"
  }
}

variable "source_configuration_github" {
  description = "the configuration of the github repo"
  type        = map(string)
  default = {
    ConnectionArn    = "arn:aws:codestar-connections:eu-west-1:XXXX:connection/XXXXXXX"
    FullRepositoryId = "GIT_ACCOUNT/REPO_NAME"
    BranchName       = "BRANCH_NAME"
  }
}

variable "ecr_repository_name" {
  description = "Name of the registery repository"
  type        = string
}

variable "bucket_artifacts_name" {
  description = "The name of the bucket of codepipeline artifacts"
  type        = string
}

variable "tags" {
  description = "Tags to be applied to the codebuild project"
  type        = map(any)
}
