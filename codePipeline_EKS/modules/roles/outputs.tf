

output "role_codepipeline_arn" {
  value = aws_iam_role.codepipeline_role.arn
}

output "role_codebuild_arn" {
  value = aws_iam_role.codebuild_role.arn
}
