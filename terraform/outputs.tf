############################################
# ECR Repository URL
############################################

output "ecr_repository_url" {
  description = "Amazon ECR Repository URL"
  value       = aws_ecr_repository.app.repository_url
}

############################################
# ECR Repository Name
############################################

output "ecr_repository_name" {
  description = "Amazon ECR Repository Name"
  value       = aws_ecr_repository.app.name
}

############################################
# ECS Cluster Name
############################################

output "ecs_cluster_name" {
  description = "Amazon ECS Cluster Name"
  value       = aws_ecs_cluster.main.name
}

############################################
# ECS Cluster ARN
############################################

output "ecs_cluster_arn" {
  description = "Amazon ECS Cluster ARN"
  value       = aws_ecs_cluster.main.arn
}

############################################
# ECS Service Name
############################################

output "ecs_service_name" {
  description = "Amazon ECS Service Name"
  value       = aws_ecs_service.app.name
}

############################################
# ECS Service ID
############################################

output "ecs_service_id" {
  description = "Amazon ECS Service ID"
  value       = aws_ecs_service.app.id
}

############################################
# ECS Task Definition ARN
############################################

output "ecs_task_definition_arn" {
  description = "ECS Task Definition ARN"
  value       = aws_ecs_task_definition.app.arn
}

############################################
# CloudWatch Log Group
############################################

output "cloudwatch_log_group" {
  description = "CloudWatch Log Group Name"
  value       = aws_cloudwatch_log_group.ecs.name
}

############################################
# IAM Execution Role ARN
############################################

output "ecs_execution_role_arn" {
  description = "IAM Role used by ECS Tasks"
  value       = aws_iam_role.ecs_task_execution_role.arn
}

############################################
# Security Group ID
############################################

output "security_group_id" {
  description = "Security Group ID"
  value       = aws_security_group.ecs_sg.id
}

############################################
# VPC ID
############################################

output "vpc_id" {
  description = "Default VPC ID"
  value       = data.aws_vpc.default.id
}

############################################
# Subnet IDs
############################################

output "subnet_ids" {
  description = "Default Subnet IDs"
  value       = data.aws_subnets.default.ids
}