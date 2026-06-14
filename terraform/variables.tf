#############################
# AWS Configuration
#############################

variable "aws_region" {
  description = "AWS region for deployment"
  type        = string
  default     = "us-east-1"
}

#############################
# Project Configuration
#############################

variable "project_name" {
  description = "Project name"
  type        = string
  default     = "ecs-demo-app"
}

variable "environment" {
  description = "Deployment environment"
  type        = string
  default     = "dev"
}

#############################
# ECR Configuration
#############################

variable "ecr_repository_name" {
  description = "Amazon ECR repository name"
  type        = string
  default     = "ecs-demo-repo"
}

#############################
# ECS Configuration
#############################

variable "ecs_cluster_name" {
  description = "Amazon ECS Cluster name"
  type        = string
  default     = "ecs-demo-cluster"
}

variable "ecs_service_name" {
  description = "Amazon ECS Service name"
  type        = string
  default     = "ecs-demo-service"
}

variable "task_family" {
  description = "ECS Task Definition family"
  type        = string
  default     = "ecs-demo-task"
}

#############################
# Container Configuration
#############################

variable "container_name" {
  description = "Container name"
  type        = string
  default     = "ecs-demo-container"
}

variable "container_port" {
  description = "Application container port"
  type        = number
  default     = 80
}

#############################
# Task Resources
#############################

variable "task_cpu" {
  description = "CPU units for ECS Task"
  type        = number
  default     = 256
}

variable "task_memory" {
  description = "Memory for ECS Task (MB)"
  type        = number
  default     = 512
}

#############################
# Service Configuration
#############################

variable "desired_count" {
  description = "Number of running ECS tasks"
  type        = number
  default     = 1
}

#############################
# CloudWatch Logs
#############################

variable "log_group_name" {
  description = "CloudWatch Log Group name"
  type        = string
  default     = "/ecs/ecs-demo-app"
}

#############################
# Network Configuration
#############################

variable "assign_public_ip" {
  description = "Assign public IP to ECS task"
  type        = bool
  default     = true
}