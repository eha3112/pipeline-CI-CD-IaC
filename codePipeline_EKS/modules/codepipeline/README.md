## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_codepipeline.terraform_pipeline](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/codepipeline) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
|codepipeline_name | Unique name of the pipeline | `string` | n/a | yes |
|role_codepipeline_arn | ARN of the codepipeline IAM role  | `string` | n/a | yes |
|bucket_codepipeline_artifacts_name | S3 bucket name to be used for storing the artifacts  | `string` | n/a | yes |
|source_type | Source Stage can be either S3 bucket (S3) or Github rep (Github) | `string` | n/a | yes |
|source_configuration_S3 | Metadata of the bucket source code `{S3Bucket = XX   S3ObjectKey = XX}` | `map(string)` | check variables.tf |yes (if source_type = S3) |
|source_configuration_github | Metadata of the github repo `{ConnectionArn = XX FullRepositoryId = XX, BranchName }`| `map(string)` | check variables.tf | yes (if source_type = Github) | 
|codebuild_project_map_names| Map for names of CodeBuild prjects | `map(string)` | n/a | yes |
|tags | Tags to be attached to the CodePipeline |  `map(any)` |  n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| codepipeline_id | Id of the CodePipeline |
| codepipeline_name | Name of the CodePipeline|
| codepipeline_arn | Arn of the CodePipeline |