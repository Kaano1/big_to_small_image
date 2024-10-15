# ECOLE-TURKEY-RESIZED BUCKET

resource "aws_s3_bucket" "ecole-turkey-resized" {
  bucket = "ecole-turkey-resized"

  tags = {
    Name = "ecole-turkey-resized"
  }
}

resource "aws_s3_bucket_public_access_block" "public_access_block_s3" {
  bucket = aws_s3_bucket.ecole-turkey-resized.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false

  depends_on = [aws_s3_bucket.ecole-turkey-resized]
}


resource "aws_s3_object" "image_object" {
	bucket = aws_s3_bucket.ecole-turkey.bucket
	key = "images/"	# we create a folder named images
}

resource "aws_s3_bucket_policy" "public_access" { # we set the policy for the bucket 
	bucket = aws_s3_bucket.ecole-turkey-resized.id
	policy = jsonencode({
		"Version": "2012-10-17",
		"Statement": [
			{
				"Sid": "Stmt202404081128",
				"Effect": "Allow",
				"Principal": "*",
				"Action": "s3:GetObject",
				"Resource": [
					"arn:aws:s3:::ecole-turkey-resized/*",
					"arn:aws:s3:::ecole-turkey-resized"
				]
			}
		]
	})

  depends_on = [aws_s3_bucket.ecole-turkey-resized, aws_s3_bucket_public_access_block.public_access_block_s3]
}


resource "aws_s3_bucket_cors_configuration" "cors" { # we set the CORS configuration for the bucket
  bucket = aws_s3_bucket.ecole-turkey-resized.id

  cors_rule {
    allowed_headers = ["*"]
    allowed_methods = ["GET", "PUT", "POST"]
    allowed_origins = ["*"]
    expose_headers = []
  }
}

# ECOLE-TURKEY BUCKET

resource "aws_s3_bucket" "ecole-turkey" { # we create a bucket for big images
  bucket = "ecole-turkey"

  tags = {
    Name        = "ecole-turkey"
  }
}

resource "aws_s3_bucket_public_access_block" "public_access_block_s3-2" {
  bucket = aws_s3_bucket.ecole-turkey.id

  block_public_acls       = true
  block_public_policy     = false
  ignore_public_acls      = true
  restrict_public_buckets = false 
}

resource "aws_s3_bucket_policy" "public_access-2" {
  bucket = aws_s3_bucket.ecole-turkey.id
  policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
      {
        "Sid": "Stmt202404081128",
        "Effect": "Allow",
        "Principal": "*",
        "Action": "s3:GetObject",
        "Resource": [
          "arn:aws:s3:::ecole-turkey/*",
          "arn:aws:s3:::ecole-turkey"
        ]
      }
    ]
  })

  depends_on = [aws_s3_bucket.ecole-turkey, aws_s3_bucket_public_access_block.public_access_block_s3-2]
}

resource "aws_s3_bucket_cors_configuration" "cors-2" { # we set the CORS configuration for the bucket
  bucket = aws_s3_bucket.ecole-turkey.id

  cors_rule {
    allowed_headers = ["*"]
    allowed_methods = ["GET", "PUT", "POST"]
    allowed_origins = ["*"]
    expose_headers = []
  }
}


