<!-- BEGINNING TERRAFORM DOCS  -->
## Requirements

No requirements.


## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 3.73 |


## Modules

| Name | path |
|------|---------|
|codebuild| [modules/codebuild](./modules/codebuild)|
|codepipeline|[modules/codepipeline](./modules/codepipeline)|
|ecr|[modules/ecr](./modules/ecr)|
|eks|[modules/eks](./modules/eks)|
|roles|[modules/roles](./modules/roles)|
|s3|[modules/s3](./modules/s3)|


## Resources

No resources


## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
|aws_credentials | aws credentials `{AWS_ACCESS_KEY_ID = XX AWS_SECRET_ACCESS_KEY = }` | `string` | n/a | yes |
|codepipeline_name | Unique name of the pipeline | `string` | n/a | yes |
|role_codepipeline_arn | ARN of the codepipeline IAM role  | `string` | n/a | yes |
|bucket_codepipeline_artifacts_name | S3 bucket name to be used for storing the artifacts  | `string` | n/a | yes |
|source_type | Source Stage can be either S3 bucket (S3) or Github rep (Github) | `string` | n/a | yes |
|source_configuration_S3 | Metadata of the bucket source code `{S3Bucket = XX   S3ObjectKey = XX}` | `map(string)` | check variables.tf |yes (if source_type = S3) |
|source_configuration_github | Metadata of the github repo `{ConnectionArn = XX FullRepositoryId = XX, BranchName }`| `map(string)` | check variables.tf | yes (if source_type = Github) | 
|role_codebuild_arn | CodeBuild IAM role arn | `string` | n/a | yes |
| ecr_repository_name | Name of the ecr registery | `string` | n/a | yes |
| bucket_artifacts_name   | Name of the bucket of codepipeline artifacts     | `string` | n/a | yes |
| role_codepipeline_name    |     | `string` | n/a | yes |
| role_codebuild_name   | Name of the role of CodeBuild's resources  | `string` | n/a | yes |
| bucket_source_code_name   | Name of the bucket of Source code S3 in the codepipeline  | `string` | n/a | yes |
|tags | Tags to be attached to the CodePipeline |  `map(any)` |  n/a | yes |

## outputs


## add steps how to run the code 
commandes Terraform validate , plan, apply, destroy ....

try the trick to privision a resource or not    var.fqfqsf ? 1 : 0
check the github create_newrole 

finish documentation ...



<!-- END TERRAFORM DOCS  -->