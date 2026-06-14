############################################
# Data Sources
############################################

data "aws_vpc" "default" {
  default = true
}

data "aws_subnets" "default" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}

############################################
# ECR Repository
############################################

resource "aws_ecr_repository" "app" {
  name                 = var.ecr_repository_name
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = {
    Name = var.ecr_repository_name
  }
}

############################################
# ECS Cluster
############################################

resource "aws_ecs_cluster" "main" {
  name = var.ecs_cluster_name

  setting {
    name  = "containerInsights"
    value = "enabled"
  }

  tags = {
    Name = var.ecs_cluster_name
  }
}

############################################
# CloudWatch Log Group
############################################

resource "aws_cloudwatch_log_group" "ecs" {
  name              = var.log_group_name
  retention_in_days = 7

  tags = {
    Name = var.project_name
  }
}

############################################
# IAM Role for ECS Task Execution
############################################

resource "aws_iam_role" "ecs_task_execution_role" {
  name = "${var.project_name}-execution-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"

    Statement = [
      {
        Effect = "Allow"

        Principal = {
          Service = "ecs-tasks.amazonaws.com"
        }

        Action = "sts:AssumeRole"
      }
    ]
  })

  tags = {
    Name = "${var.project_name}-execution-role"
  }
}

############################################
# Attach AWS Managed Policy
############################################

resource "aws_iam_role_policy_attachment" "ecs_execution_role_policy" {

  role = aws_iam_role.ecs_task_execution_role.name

  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"

}

############################################
# Security Group for ECS Service
############################################

resource "aws_security_group" "ecs_sg" {

  name        = "${var.project_name}-sg"
  description = "Security Group for ECS Service"
  vpc_id      = data.aws_vpc.default.id

  ingress {

    description = "HTTP"

    from_port = var.container_port
    to_port   = var.container_port

    protocol = "tcp"

    cidr_blocks = [
      "0.0.0.0/0"
    ]

  }

  egress {

    from_port = 0
    to_port   = 0

    protocol = "-1"

    cidr_blocks = [
      "0.0.0.0/0"
    ]

  }

  tags = {
    Name = "${var.project_name}-security-group"
  }

}

############################################
# ECS Task Definition
############################################

resource "aws_ecs_task_definition" "app" {

  family = var.task_family

  network_mode = "awsvpc"

  requires_compatibilities = ["FARGATE"]

  cpu    = tostring(var.task_cpu)
  memory = tostring(var.task_memory)

  execution_role_arn = aws_iam_role.ecs_task_execution_role.arn

  container_definitions = jsonencode([

    {

      name = var.container_name

      image = "${aws_ecr_repository.app.repository_url}:latest"

      essential = true

      portMappings = [

        {

          containerPort = var.container_port
          hostPort      = var.container_port
          protocol      = "tcp"

        }

      ]

      logConfiguration = {

        logDriver = "awslogs"

        options = {

          awslogs-group         = aws_cloudwatch_log_group.ecs.name
          awslogs-region        = var.aws_region
          awslogs-stream-prefix = "ecs"

        }

      }

    }

  ])

  tags = {
    Name = var.task_family
  }

}

############################################
# ECS Service
############################################

resource "aws_ecs_service" "app" {

  name = var.ecs_service_name

  cluster = aws_ecs_cluster.main.id

  task_definition = aws_ecs_task_definition.app.arn

  desired_count = var.desired_count

  launch_type = "FARGATE"

  network_configuration {

    assign_public_ip = var.assign_public_ip

    security_groups = [
      aws_security_group.ecs_sg.id
    ]

    subnets = data.aws_subnets.default.ids

  }

  depends_on = [

    aws_iam_role_policy_attachment.ecs_execution_role_policy,

    aws_cloudwatch_log_group.ecs

  ]

  tags = {
    Name = var.ecs_service_name
  }

}

