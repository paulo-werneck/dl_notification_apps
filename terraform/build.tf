# Get hash from lambda source code
#
data "external" "hash" {
  program = ["${path.module}/hash.sh", "../app/"]
}


# Zip files lambda code
#
resource "null_resource" "build" {
  triggers = {
    hash = lookup(data.external.hash.result, "hash")
  }

  provisioner "local-exec" {
    command = "sh ${path.module}/build.sh ${local.lambda_zip_name}"
  }
}


# Upload zip to s3 bucket
#
resource "null_resource" "upload_file" {
  triggers = {
    hash = lookup(data.external.hash.result, "hash")
  }
  
  provisioner "local-exec" {
    command = "aws s3 cp ../${local.lambda_zip_name} s3://${var.bucket_assets_id}/${local.lambda_s3_path} --profile ${var.aws_profile}"
  }

  depends_on = [null_resource.build]
}