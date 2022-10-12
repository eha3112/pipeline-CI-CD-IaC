

region = "eu-west-1"

aws_credentials = {
  AWS_ACCESS_KEY_ID     = "AWS_ACCESS_KEY_ID"
  AWS_SECRET_ACCESS_KEY = "AWS_SECRET_ACCESS_KEY"
}

codepipeline_name = "eha_CI-CD"

role_codepipeline_name = "codepipeline-app"

role_codebuild_name = "codebuild-app"

source_type = "Github"

source_configuration_S3 = { S3Bucket = "source-bucket-eha"
                            S3ObjectKey = "code.zip" }

source_configuration_github = {
  ConnectionArn    = "arn:aws:codestar-connections:eu-west-1:484123018117:connection/769e4ea0-2f7e-4fe5-9167-b177ce3be93e"
  FullRepositoryId = "ehchabane/deploiment-mate"
  BranchName       = "main" 
  }

ecr_repository_name  = "eha-image-registery"

bucket_artifacts_name = "artifacts-bucket-eha"

tags = { createdBy = "terraform"
         project = "eha"
         env = "pre-prod"}