data "archive_file" "lambda_zip" {
	type = "zip"
	source_dir = "files"
	output_path = "send/ImageResize.zip"
}

resource "aws_lambda_function" "lambda" {
	function_name = "terraform_lambda" #
	role = aws_iam_role.Lambda-S33.arn
	runtime = "nodejs16.x"
	handler = "index.handler"
	filename = "send/ImageResize.zip"
	source_code_hash = data.archive_file.lambda_zip.output_base64sha256
	timeout = 35

	tags = {
		Name = "terraform_lambda"
	}
}

resource "aws_lambda_permission" "lambda_permission" {
	action = "lambda:InvokeFunction"
	function_name = aws_lambda_function.lambda.function_name
	principal = "s3.amazonaws.com"
	source_arn = aws_s3_bucket.ecole-turkey.arn
}

resource "aws_s3_bucket_notification" "bucket_notification" {
	bucket = aws_s3_bucket.ecole-turkey.id

	lambda_function {
		lambda_function_arn = aws_lambda_function.lambda.arn
		events = ["s3:ObjectCreated:*"]
	}	
}

