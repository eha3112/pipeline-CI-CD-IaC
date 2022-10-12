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
| [aws_ecr_repository.registry](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecr_repository) | resource |


## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| ecr_repository_name | Name of the ecr registery | `string` | n/a | yes |
|tags | Tags to be attached to the CodePipeline |  `map(any)` |  n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| ecr_repository_arn | ARN of the ecr registery |
| ecr_repository_name | Name of the ecr registery |