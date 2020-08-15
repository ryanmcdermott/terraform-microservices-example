################################################################################
# General AWS Configuration
################################################################################
variable "aws_region" {
  description = "The AWS region things are created in"
  default     = "us-west-2"
}
variable "docker_repo" {}

################################################################################
# Project metadata
################################################################################
variable "project" {
  description = "Project name"
  default     = "project"
}

################################################################################
# ECS Configuration
################################################################################
variable "ecs_task_execution_role_name" {
  description = "ECS task execution role name"
  default     = "myEcsTaskExecutionRole"
}

variable "az_count" {
  description = "Number of AZs to cover in a given region"
  default     = "2"
}

variable "fargate_cpu" {
  description = "Fargate instance CPU units to provision (1 vCPU = 1024 CPU units)"
  default     = "512"
}

variable "fargate_memory" {
  description = "Fargate instance memory to provision (in MiB)"
  default     = "1024"
}

################################################################################
# API Service Configuration
################################################################################
variable "api_port" {
  description = "Port exposed by the API image"
  default     = 8080
}

variable "api_count" {
  description = "Number of API docker containers to run"
  default     = 1
}

variable "api_health_check_path" {
  default = "/api/"
}

################################################################################
# Frontend Service Configuration
################################################################################
variable "fe_port" {
  description = "Port exposed by the frontend image"
  default     = 3000
}

variable "fe_count" {
  description = "Number of frontend docker containers to run"
  default     = 1
}

variable "fe_health_check_path" {
  default = "/"
}
