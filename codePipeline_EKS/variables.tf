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


variable codeStart_github_connection_Arn {
  description = "the arn of CodeStart connection with the application in Github"
  type = string
  default = "arn:aws:codestar-connections:eu-west-1:484123018117:connection/XXXXXXXXX"

  sensitive = true
}
