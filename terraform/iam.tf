data "aws_caller_identity" "aws_account" {}


resource "aws_iam_policy" "policy" {
  name = "${local.lambda_name}-policy"

  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Sid" : "PermissionToCreateLogGroup",
        "Effect" : "Allow",
        "Action" : "logs:CreateLogGroup",
        "Resource" : "arn:aws:logs:${var.aws_region}:${data.aws_caller_identity.aws_account.account_id}:*"
      },
      {
        "Sid" : "PermissionToPutLogs",
        "Effect" : "Allow",
        "Action" : [
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ],
        "Resource" : [
          "arn:aws:logs:${var.aws_region}:${data.aws_caller_identity.aws_account.account_id}:log-group:/aws/lambda/${local.lambda_name}:*"
        ]
      }
    ]
  })

  tags = {
    Name    = "${local.lambda_name}-policy"
    project = var.project_prefix
    source  = "terraform"
  }
}


resource "aws_iam_role" "role" {
  name = "${local.lambda_name}-role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF

  tags = {
    Name    = "${local.lambda_name}-role"
    project = var.project_prefix
    source  = "terraform"
  }
}

resource "aws_iam_role_policy_attachment" "lambda_logs" {
  role       = aws_iam_role.role.name
  policy_arn = aws_iam_policy.policy.arn
}


# Lambda SNS subscription permission
#
resource "aws_lambda_permission" "sns_permission" {
  statement_id  = "AllowExecutionFromSNS"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.main.function_name
  principal     = "sns.amazonaws.com"
  source_arn    = var.sns_topic_arn
}