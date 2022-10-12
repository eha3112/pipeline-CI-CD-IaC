


variable "aws_credentials" {
  description = "aws credentials. It is used as en env variable to connect to eks"
  type        = map(string)
  default = {
    AWS_ACCESS_KEY_ID     = "your_access_key_id"
    AWS_SECRET_ACCESS_KEY = "your_secret_access_key"
  }
  sensitive = true
}


variable "role_codebuild_arn" {
  description = "arn role for CodeBuild"
  type = string
}

variable "tags" {
  description = "Tags to be applied to the codebuild project"
  type        = map(any)
}