
variable "codepipeline_name" {
  description = "Name of the pipeline."
  type        = string
  default     = "pipeline-MATE"
}

variable "bucket_codepipeline_artifacts_name" {
  description = "The name of the bucket of codepipeline artifacts"
  type        = string
  default     = "artifacts-bucket-MATE"
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


########################
### SOURCE VARIABLES ###
########################


variable "bucket_source_codepipeline_name" {
  description = "The Name of the bucket of Source S3 in the codepipeline"
  type        = string
  default     = "source-bucket-eha"

}

variable "objectKey_source_codepipeline_name" {
  description = "The Name of the bucket of Source S3 in the codepipeline"
  type        = string
  default     = "code.zip"

}


variable "source_type" {
  description = "S3 or Github"
  type        = string
  default     = "S3"
}


variable "source_configuration_S3" {
  description = "the configuration of the S3 source bucket"
  type        = map(string)
  default = {
    S3Bucket    = "BUKCET_NAME"
    S3ObjectKey = "NAME_SOURCE_CODE_IN_BUCKET"
  }
}

variable "source_configuration_github" {
  description = "the configuration of the github"
  type        = map(string)
  default = {
    ConnectionArn    = "arn:aws:codestar-connections:eu-west-1:484123018117:connection/2f8952ae-7835-4703-92f6-5b933b8088e5"
    FullRepositoryId = "eha3112/pipeline-CI-CD"
    BranchName       = "main"
  }
}
