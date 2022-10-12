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
| [aws_iam_role.codepipeline_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role.codebuild_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role.codepipeline_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [aws_iam_role.codebuild_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| role_codepipeline_name    |     | `string` | n/a | yes |
| role_codebuild_name   | Name of the role of CodeBuild's resources  | `string` | n/a | yes |
| bucket_artifacts_name   | Name of the bucket of codepipeline artifacts     | `string` | n/a | yes |
| bucket_source_code_name   | Name of the bucket of Source code S3 in the codepipeline  | `string` | n/a | yes |
|tags | Tags to be attached to the CodePipeline |  `map(any)` |  n/a | yes |


## Outputs

| Name | Description |
|------|-------------|
| role_codepipeline_arn | ARN of the IAM Role of CodePipeline |
| role_codebuild_arn | ARN of the IAM Role of CodeBuild  |
| role_codepipeline_name| Name of the IAM Role of CodePipeline| 
| role_codebuild_name | Name of the IAM Role of CodeBuild |