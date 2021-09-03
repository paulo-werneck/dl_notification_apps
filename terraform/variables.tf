variable "project_prefix" {
  type        = string
  description = "Project prefix (The same of datalake project prefix)"
}

variable "aws_profile" {
  type        = string
  default     = ""
  description = "description"
}

variable "aws_region" {
  type        = string
  default     = ""
  description = "description"
}

variable "aws_lambda_name" {
  type        = string
  default     = "lambda-notifications"
  description = "The name of aws lambda"
}

variable "client_message_config" {
  type        = map(any)
  description = "Map with configurations to client message (slack, teams..). e.g. {'url': url_endpoint}"
}

variable "bucket_assets_id" {
  type        = string
  description = ""
}

variable "sns_topic_arn" {
  type        = string
  description = "Datalake SNS topic arn"
}


locals {
  lambda_name     = "${var.project_prefix}-${var.aws_lambda_name}"
  lambda_zip_name = "${local.lambda_name}-code.zip"
  lambda_s3_path  = "lambda/${local.lambda_name}/${local.lambda_name}-code.zip"
}
