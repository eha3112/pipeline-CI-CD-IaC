terraform {
  backend "s3" {
    bucket = "bucket-statefile-terraform-mate-preprod"
    key    = "tfstate-file/terraform.tfstate"
    region = "eu-west-1"
  }
}