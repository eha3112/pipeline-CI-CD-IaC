
variable "codepipeline_name" {
  description = "Name of the pipeline"
  type        = string
}

variable "role_codepipeline_arn" {
  description = "ARN of the codepipeline IAM role"
  type        = string
}


variable "bucket_codepipeline_artifacts_name" {
  description = "The name of the bucket of codepipeline artifacts"
  type        = string
}

variable "source_type" {
  description = "S3 or Github"
  type        = string
}

########################
### SOURCE VARIABLES ###
########################

variable "source_configuration_S3" {
  description = "the configuration of the S3 source bucket"
  type        = map(string)
  default = {
    S3Bucket    = "BUKCET_NAME"
    S3ObjectKey = "NAME_SOURCE_CODE_IN_BUCKET"
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

variable "codebuild_project_map_names" {
  description = ""
  type        = map(string)
  default = {
    build-app      = "build-app_name"
    test-app       = "test-app_name"
    deploy-app-eks = "deploy-app-eks_name"
  }
}

variable "tags" {
  description = "Tags to be applied to the codebuild project"
  type        = map(any)
}