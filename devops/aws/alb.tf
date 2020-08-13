################################################################################
# ALB Definition
################################################################################
resource "aws_alb" "main" {
  name            = "load-balancer"
  subnets         = aws_subnet.public.*.id
  security_groups = [aws_security_group.lb.id]
}

################################################################################
# API Target Group
################################################################################
resource "aws_alb_target_group" "api" {
  name        = "api-tg"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = aws_vpc.main.id
  target_type = "ip"

  health_check {
    healthy_threshold   = "3"
    interval            = "30"
    protocol            = "HTTP"
    matcher             = "200"
    timeout             = "3"
    path                = var.api_health_check_path
    unhealthy_threshold = "2"
  }
}

resource "aws_alb_listener" "main" {
  load_balancer_arn = aws_alb.main.id
  port              = 80
  protocol          = "HTTP"

  default_action {
    target_group_arn = aws_alb_target_group.api.id
    type             = "forward"
  }
}


################################################################################
# API Listener
################################################################################
# Redirect all traffic from the ALB to the target group
resource "aws_alb_listener_rule" "api" {
  listener_arn = aws_alb_listener.main.arn
  priority     = 1

  action {
    type             = "forward"
    target_group_arn = aws_alb_target_group.api.arn
  }

  condition {
    path_pattern {
      values = ["/api/*"]
    }
  }
}

################################################################################
# FE Target Group
################################################################################
resource "aws_alb_target_group" "fe" {
  name        = "fe-tg"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = aws_vpc.main.id
  target_type = "ip"

  health_check {
    healthy_threshold   = "3"
    interval            = "30"
    protocol            = "HTTP"
    matcher             = "200"
    timeout             = "3"
    path                = var.fe_health_check_path
    unhealthy_threshold = "2"
  }
}

################################################################################
# FE Listeners
################################################################################
resource "aws_alb_listener_rule" "fe" {
  listener_arn = aws_alb_listener.main.arn
  priority     = 2

  action {
    type             = "forward"
    target_group_arn = aws_alb_target_group.fe.arn
  }

  condition {
    path_pattern {
      values = ["/*"]
    }
  }
}