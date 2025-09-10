## flow-logs iams
resource "aws_iam_role" "flow_logs_role" {
  count = var.flow_logs.enable ? 1 : 0

  name = "${var.common_attr.name}-${var.common_attr.env}-flow-logs-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_policy" "flow_logs_policy" {
  name = "${var.common_attr.name}-${var.common_attr.env}-flow-logs-policy"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        "Effect" : "Allow",
        "Action" : [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents",
          "logs:DescribeLogGroups",
          "logs:DescribeLogStreams"
        ],
        "Resource" : [
          aws_cloudwatch_log_group.flow_logs_log_group.arn
        ]
      }
    ]
  })
}

## flow-logs cloudwatch log groups
resource "aws_cloudwatch_log_group" "flow_logs_log_group" {
  name = "vpc-flow/${var.common_attr.name}/${var.common_attr.env}"
  retention_in_days = var.flow_logs.retention_in_days
  log_group_class = "INFREQUENT_ACCESS"

  tags = {
    Name = "${var.common_attr.name}-${var.common_attr.env}-flow-logs-log-group"
  }
}

resource "aws_flow_log" "flow_logs" {
  iam_role_arn = var.flow_logs.iam_role_arn
  log_destination = var.flow_logs.cloudwatch_log_destination
  traffic_type = var.flow_logs.traffic_type
  vpc_id = var.vpc_id
  
  tags = {
    Name = "${var.common_attr.name}-${var.common_attr.env}-flow-logs"
  }
}
