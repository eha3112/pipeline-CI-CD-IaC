
provider "aws" {
  region     = "eu-west-1"
  access_key = var.aws_credentials["AWS_ACCESS_KEY_ID"]
  secret_key = var.aws_credentials["AWS_SECRET_ACCESS_KEY"]
}


################################################################################
# EKS Cluster ###
################################################################################

/*
module "eks" {
  source = "./modules/eks"

  vpc_cidr                 = "192.0.0.0/16"
  subnet_cidr_bits         = 8
  availability_zones_count = 2

  tags = {
    "Project"     = "Terraform"
    "Environment" = "dev"
  "Owner" = "eha" }
}

*/



################################################################################
# Pipeline CI-CD 
################################################################################


module "codepipeline" {
  source = "./modules/codepipeline"

  codepipeline_name = var.codepipeline_name
  
  role_codepipeline_arn = module.roles.role_codepipeline_arn

  bucket_codepipeline_artifacts_name = module.s3.bucket_artifacts_name

  source_type = var.source_type 

  source_configuration_S3 = var.source_configuration_S3
  
  source_configuration_github = var.source_configuration_github

  codebuild_project_map_names = {
    build-app      = module.codebuild.project_build-app_name
    test-app       = module.codebuild.project_test-app_name
    deploy-app-eks = module.codebuild.project_deploy-app-eks_name
  }

  tags = var.tags

}

module "codebuild" {
  source = "./modules/codebuild"

  aws_credentials    = var.aws_credentials
  role_codebuild_arn = module.roles.role_codebuild_arn

  tags = var.tags

}

module "ecr" {

  source = "./modules/ecr"

  ecr_repository_name = var.ecr_repository_name

  tags = var.tags

}


module "s3" {
  source = "./modules/s3"

  bucket_artifacts_name = var.bucket_artifacts_name 
  tags = var.tags
}


module "roles" {
  source = "./modules/roles"

  role_codepipeline_name =  var.role_codepipeline_name 
  role_codebuild_name =  var.role_codebuild_name  
  bucket_source_code_name = var.source_configuration_S3["S3Bucket"]
  bucket_artifacts_name   = module.s3.bucket_artifacts_name

  tags = var.tags

}