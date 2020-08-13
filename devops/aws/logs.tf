# Set up CloudWatch group and log stream and retain logs for 30 days
resource "aws_cloudwatch_log_group" "api_log_group" {
  name              = "/ecs/api"
  retention_in_days = 30

  tags = {
    Name = "api-log-group"
  }
}

resource "aws_cloudwatch_log_stream" "api_log_stream" {
  name           = "api-log-stream"
  log_group_name = aws_cloudwatch_log_group.api_log_group.name
}

# Set up CloudWatch group and log stream and retain logs for 30 days
resource "aws_cloudwatch_log_group" "fe_log_group" {
  name              = "/ecs/fe"
  retention_in_days = 30

  tags = {
    Name = "fe-log-group"
  }
}

resource "aws_cloudwatch_log_stream" "fe_log_stream" {
  name           = "fe-log-stream"
  log_group_name = aws_cloudwatch_log_group.fe_log_group.name
}

