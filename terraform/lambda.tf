# # Upload zip to s3 bucket
# #
# resource "aws_s3_bucket_object" "upload_file" {
#   bucket = var.bucket_assets_id
#   key    = local.lambda_s3_path
#   source = "../${local.lambda_zip_name}"

#   depends_on = [null_resource.build]
#   lifecycle {
#     create_before_destroy = false
#   }
# }


#Create lambda resource
#
resource "aws_lambda_function" "main" {
  function_name = local.lambda_name
  role          = aws_iam_role.role.arn
  handler       = "lambda_function.lambda_handler"

  s3_bucket = var.bucket_assets_id
  s3_key    = local.lambda_s3_path

  runtime = "python3.9"

  environment {
    variables = var.client_message_config
  }

  tags = {
    Name    = local.lambda_name
    project = var.project_prefix
    source  = "terraform"
  }

  depends_on = [null_resource.upload_file]
}
