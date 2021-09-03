# Lambda SNS subscription
#
resource "aws_sns_topic_subscription" "lambda_sns_subscription" {
  topic_arn = var.sns_topic_arn
  protocol  = "lambda"
  endpoint  = aws_lambda_function.main.arn
}