

output "ecr_repository_arn" {
    value = aws_ecr_repository.registry.arn 
}

output "ecr_repository_name" {
    value = aws_ecr_repository.registry.name 
}