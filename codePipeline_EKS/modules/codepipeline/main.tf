
module "roles" {
  source = "../roles"

  bucket_source_codepipeline_name    = var.bucket_source_codepipeline_name
  bucket_codepipeline_artifacts_name = var.bucket_codepipeline_artifacts_name
}


####################
### CodePipeline ###
####################

resource "aws_codepipeline" "codepipeline" {
  name     = var.codepipeline_name
  role_arn = module.roles.role_codepipeline_arn

  artifact_store {
    location = aws_s3_bucket.bucket_codepipeline.bucket
    type     = "S3"
  }


  stage {
    name = "Source"

    action {
      name             = "Source-${var.source_type}"
      category         = "Source"
      owner            = "AWS"
      provider         = var.source_type == "S3" ? "S3" : (var.source_type == "Github" ? "CodeStarSourceConnection" : "source_type input error")
      version          = "1"
      output_artifacts = ["source_output"]

      configuration = var.source_type == "S3" ? var.source_configuration_S3 : (var.source_type == "Github" ? var.source_configuration_github : tomap({ "message" = "source_type input error" }))
    }

  }

  stage {
    name = "Build-Test"

  
    action {
      name             = "Build-App"
      category         = "Build"
      owner            = "AWS"
      provider         = "CodeBuild"
      input_artifacts  = ["source_output"]
      output_artifacts = ["build_output"]
      version          = "1"

      configuration = {
        ProjectName = "build-app-CodeBuild_project"
      }
      run_order = 1
    }

    action {
      name             = "Test-App"
      category         = "Test"
      owner            = "AWS"
      provider         = "CodeBuild"
      input_artifacts  = ["source_output"]
      output_artifacts = ["test_output"]
      version          = "1"

      configuration = {
        ProjectName = "test-app-CodeBuild_project"
      }

      run_order = 2
    }
  }




  stage {
    name = "Deploy-Stage"


    action {
      name     = "Manual-Approval"
      category = "Approval"
      owner    = "AWS"
      provider = "Manual"
      version  = "1"

      configuration = {
        # NotificationArn = ""
        CustomData = "Comments on the manual approval"
        # ExternalEntityLink = ""
      }

      run_order = 1
    }

    action {
      name             = "Deploy-App"
      category         = "Build"
      owner            = "AWS"
      provider         = "CodeBuild"
      input_artifacts  = ["test_output"]
      version          = "1"

      configuration = {
        ProjectName = "deploy-app-CodeBuild_project"
      }

      run_order = 2
    }
  }

}


### S3 Bucket for artifacts ###

resource "aws_s3_bucket" "bucket_codepipeline" {
  bucket = var.bucket_codepipeline_artifacts_name
  force_destroy = true
}

resource "aws_s3_bucket_acl" "codepipeline_bucket_acl" {
  bucket = aws_s3_bucket.bucket_codepipeline.id
  acl    = "private"
}


#################
### CodeBuild ###
#################


## BUILD
resource "aws_codebuild_project" "build-app" {
  name          = "build-app-CodeBuild_project" 
  description   = "build application env "
  build_timeout = "300"
  service_role  = module.roles.role_codebuild_arn

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
}


## TEST
resource "aws_codebuild_project" "test-app" {
  name          = "test-app-CodeBuild_project" 
  description   = "test application env "
  build_timeout = "300"
  service_role  = module.roles.role_codebuild_arn

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

}

## DEPLOY
resource "aws_codebuild_project" "deploy-app" {
  name          = "deploy-app-CodeBuild_project" 
  description   = "deploy application env "
  build_timeout = "300"
  service_role  = module.roles.role_codebuild_arn

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
}