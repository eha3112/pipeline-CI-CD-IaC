
 

output "project_build-app_name" {
    value =  aws_codebuild_project.build-app.name
} 

output "project_test-app_name" {
    value =  aws_codebuild_project.test-app.name
} 

output "project_deploy-app-eks_name" {
    value =  aws_codebuild_project.deploy-app-eks.name
} 


output "project_build-app_arn" {
    value =  aws_codebuild_project.build-app.arn
} 

output "project_test-app_arn" {
    value =  aws_codebuild_project.test-app.arn
} 

output "project_deploy-app-eks_arn" {
    value =  aws_codebuild_project.deploy-app-eks.arn
} 