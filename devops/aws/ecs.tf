################################################################################
# ECS Cluster definition
################################################################################
resource "aws_ecs_cluster" "main" {
  name = "${var.project}-cluster"
}

resource "aws_service_discovery_private_dns_namespace" "segment" {
  name        = "${var.project}.local"
  description = "Service discovery for backends"
  vpc         = aws_vpc.main.id
}

resource "aws_service_discovery_service" "api-service" {
  name = "api-service"

  dns_config {
    namespace_id = aws_service_discovery_private_dns_namespace.segment.id

    dns_records {
      ttl  = 10
      type = "A"
    }

    routing_policy = "MULTIVALUE"
  }
}

resource "aws_service_discovery_service" "fe-service" {
  name = "fe-service"

  dns_config {
    namespace_id = aws_service_discovery_private_dns_namespace.segment.id

    dns_records {
      ttl  = 10
      type = "A"
    }

    routing_policy = "MULTIVALUE"
  }

  health_check_custom_config {
    failure_threshold = 1
  }
}


################################################################################
# API ECS Tasks
################################################################################
data "template_file" "api" {
  template = file("./templates/ecs/api.json.tpl")

  vars = {
    api_image      = var.api_image
    api_port       = var.api_port
    fargate_cpu    = var.fargate_cpu
    fargate_memory = var.fargate_memory
    aws_region     = var.aws_region
  }
}

resource "aws_ecs_task_definition" "api" {
  family                   = "api-task"
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = var.fargate_cpu
  memory                   = var.fargate_memory
  container_definitions    = data.template_file.api.rendered
}

################################################################################
# API ECS Service
################################################################################

resource "aws_ecs_service" "api" {
  name            = "api"
  cluster         = aws_ecs_cluster.main.id
  task_definition = aws_ecs_task_definition.api.arn
  desired_count   = var.api_count
  launch_type     = "FARGATE"

  health_check_grace_period_seconds = 180

  network_configuration {
    security_groups  = [aws_security_group.ecs_tasks.id]
    subnets          = aws_subnet.private.*.id
    assign_public_ip = true
  }

  load_balancer {
    target_group_arn = aws_alb_target_group.api.id
    container_name   = "fapi"
    container_port   = var.api_port
  }

  service_registries {
    registry_arn     = aws_service_discovery_service.api-service.arn
  }

  depends_on = [aws_alb_listener.main, aws_iam_role_policy_attachment.ecs_task_execution_role]
}

################################################################################
# FE ECS Tasks
################################################################################
data "template_file" "fe" {
  template = file("./templates/ecs/fe.json.tpl")

  vars = {
    fe_image       = var.fe_image
    fe_port        = var.fe_port
    fargate_cpu    = var.fargate_cpu
    fargate_memory = var.fargate_memory
    aws_region     = var.aws_region
  }
}

resource "aws_ecs_task_definition" "fe" {
  family                   = "fe-task"
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = var.fargate_cpu
  memory                   = var.fargate_memory
  container_definitions    = data.template_file.fe.rendered
}

################################################################################
# FE ECS Service
################################################################################

resource "aws_ecs_service" "fe" {
  name            = "fe"
  cluster         = aws_ecs_cluster.main.id
  task_definition = aws_ecs_task_definition.fe.arn
  desired_count   = var.fe_count
  launch_type     = "FARGATE"

  health_check_grace_period_seconds = 180

  network_configuration {
    security_groups  = [aws_security_group.ecs_tasks.id]
    subnets          = aws_subnet.private.*.id
    assign_public_ip = true
  }

  load_balancer {
    target_group_arn = aws_alb_target_group.fe.id
    container_name   = "fe"
    container_port   = var.fe_port
  }

  service_registries {
    registry_arn     = aws_service_discovery_service.fe-service.arn
  }

  depends_on = [aws_alb_listener.main, aws_iam_role_policy_attachment.ecs_task_execution_role]
}

