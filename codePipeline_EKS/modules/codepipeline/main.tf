resource "aws_codepipeline" "codepipeline" {
  name     = var.codepipeline_name
  role_arn = var.role_codepipeline_arn
  tags     = var.tags


  artifact_store {
    location = var.bucket_codepipeline_artifacts_name
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
        ProjectName = var.codebuild_project_map_names["build-app"]
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
        ProjectName = var.codebuild_project_map_names["test-app"]
      }
      run_order = 2
    }
  }

  stage {
    name = "Deploy-Stage"

    /*
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
*/
    action {
      name            = "Deploy-App"
      category        = "Build"
      owner           = "AWS"
      provider        = "CodeBuild"
      input_artifacts = ["source_output"]
      version         = "1"

      configuration = {
        ProjectName = var.codebuild_project_map_names["deploy-app-eks"]
      }

      #run_order = 2
    }
  }

}