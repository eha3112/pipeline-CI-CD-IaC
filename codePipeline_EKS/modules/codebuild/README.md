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
| [aws_codebuild_project.build-app](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/codebuild_project) | resource |
| [aws_codebuild_project.test-app](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/codebuild_project) | resource |
| [aws_codebuild_project.deploy-app-eks](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/codebuild_project) | resource |


## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
|role_codebuild_arn | CodeBuild IAM role arn | `string` | n/a | yes |
|aws_credentials | aws credentials `{AWS_ACCESS_KEY_ID = XX AWS_SECRET_ACCESS_KEY = }` | `string` | n/a | yes |
|tags | Tags to be attached to the CodePipeline |  `map(any)` |  n/a | yes |


## Outputs

| Name | Description |
|------|-------------|
| project_build-app_name | Name of the CodeBuild project "build" |
| project_test-app_name | Name of the CodeBuild project "test" |
| project_deploy-app-eks_name | Name of the CodeBuild project "deploy-eks"  |
| project_build-app_arn | ARN of the CodeBuild project "build" |
| project_test-app_arn | ARN of the CodeBuild project "test" |
| project_deploy-app-eks_arn | ARN of the CodeBuild project "deploy-eks"  |

