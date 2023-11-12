locals {
  iam_role_name      = "ecsTaskExecutionRole"
  subnet_id          = "subnet-e8720cc9"
  security_group_id  = "sg-6830966a"
  desired_task_count = 0
  docker_image       = "docker.io/mohitkh7/dev-challenges:latest"
}

data "aws_iam_role" "ecs_exec" {
  name = local.iam_role_name
}

data "aws_subnet" "az_1a" {
  id = local.subnet_id
}

data "aws_security_group" "default" {
  id = local.security_group_id
}

resource "aws_ecs_cluster" "container" {
  name = "${var.PROJECT}-cluster"
}

resource "aws_ecs_cluster_capacity_providers" "container" {
  cluster_name       = aws_ecs_cluster.container.name
  capacity_providers = ["FARGATE"]
}

resource "aws_ecs_service" "container" {
  name                    = "${var.PROJECT}-service"
  cluster                 = aws_ecs_cluster.container.id
  task_definition         = aws_ecs_task_definition.container.id
  launch_type             = "FARGATE"
  desired_count           = local.desired_task_count
  enable_ecs_managed_tags = true
  wait_for_steady_state   = true
  network_configuration {
    subnets          = [data.aws_subnet.az_1a.id]
    security_groups  = [data.aws_security_group.default.id]
    assign_public_ip = true
  }
}

resource "aws_ecs_task_definition" "container" {
  family                   = var.PROJECT
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = "256"
  memory                   = "512"
  container_definitions = jsonencode([
    {
      "name" : "app",
      "image" : local.docker_image,
      "cpu" : 0,
      "portMappings" : [
        {
          "name" : "app-5000-tcp",
          "containerPort" : 5000,
          "hostPort" : 5000,
          "protocol" : "tcp",
          "appProtocol" : "http"
        }
      ],
      "essential" : true,
      "environment" : [],
      "environmentFiles" : [],
      "mountPoints" : [],
      "volumesFrom" : [],
      "ulimits" : [],
    }
  ])
  runtime_platform {
    operating_system_family = "LINUX"
    cpu_architecture        = "X86_64"
  }
  execution_role_arn = data.aws_iam_role.ecs_exec.arn
}
