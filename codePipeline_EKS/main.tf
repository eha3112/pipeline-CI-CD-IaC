
provider "aws" {
  region     = "eu-west-1"
  access_key = var.aws_credentials["AWS_ACCESS_KEY_ID"]
  secret_key = var.aws_credentials["AWS_SECRET_ACCESS_KEY"]
}

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
module "codepipeline" {
  
  source = "./modules/codepipeline"

  codepipeline_name = "pipeline-MATE"

  bucket_codepipeline_artifacts_name = "artifacts-bucket-mate"


  source_type = "Github"  # S3/Github

  source_configuration_S3 = {
    S3Bucket = "source-bucket-eha"
    S3ObjectKey = "code.zip"
  }
  
  source_configuration_github = {
    ConnectionArn    = var.codeStart_github_connection_Arn
    FullRepositoryId = "ehchabane/deploiment-mate"  
    BranchName       = "tester-buildspecs"     # "main"
  }
      
}


module "ecr" {

  source = "./modules/ecr"

  ecr_repository_name = "mate-image-registery"

}