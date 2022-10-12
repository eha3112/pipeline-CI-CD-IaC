

resource "aws_codebuild_project" "build-app" {
  name          = "build-app" 
  description   = "build application env "
  build_timeout = "300"
  service_role  = var.role_codebuild_arn

  environment {
    compute_type                = "BUILD_GENERAL1_MEDIUM"
    image                       = "aws/codebuild/standard:1.0"
    type                        = "LINUX_CONTAINER"
    image_pull_credentials_type = "CODEBUILD"

  }
  artifacts {
    type = "CODEPIPELINE"
  }

  source {
    type = "CODEPIPELINE"
    buildspec = "build/buildspec_build.yml"
  }

  tags = var.tags
}


resource "aws_codebuild_project" "test-app" {
  name          = "test-app" 
  description   = "test application env "
  build_timeout = "300"
  service_role  = var.role_codebuild_arn

  environment {
    compute_type                = "BUILD_GENERAL1_MEDIUM"
    image                       = "aws/codebuild/standard:1.0"
    type                        = "LINUX_CONTAINER"
    image_pull_credentials_type = "CODEBUILD"

  }
  artifacts {
    type = "CODEPIPELINE"
  }

  source {
    type = "CODEPIPELINE"
    buildspec = "build/buildspec_test.yml"
  }

  tags = var.tags

}


resource "aws_codebuild_project" "deploy-app-eks" {
  name          = "deploy-app-eks" 
  description   = "deploy application env "
  build_timeout = "300"
  service_role  = var.role_codebuild_arn

  environment {
    compute_type                = "BUILD_GENERAL1_MEDIUM"
    image                       = "aws/codebuild/standard:1.0"
    type                        = "LINUX_CONTAINER"
    image_pull_credentials_type = "CODEBUILD"

    environment_variable {
      name  = "AWS_ACCESS_KEY_ID"
      value = var.aws_credentials["AWS_ACCESS_KEY_ID"]
    }
    environment_variable {
      name  = "AWS_SECRET_ACCESS_KEY"
      value = var.aws_credentials["AWS_SECRET_ACCESS_KEY"]
    }
  }

  artifacts {
    type = "CODEPIPELINE"
  }

  source {
    type = "CODEPIPELINE"
    buildspec = "build/buildspec_deploy.yml"
  }

  tags = var.tags
  
}