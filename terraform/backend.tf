terraform {
  backend "s3" {
    bucket         = "ecs-terraform-state-2026"
    key            = "ecs-deployment/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-lock-table"
    encrypt        = true
  }
}