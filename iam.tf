# assume_role_policy mean that the role can be assumed by the lambda function
# policy mean that the role can do the actions in the policy

resource "aws_iam_role" "Lambda-S33" {
  name = "Lambda-S33"

  assume_role_policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
      {
        "Effect": "Allow",
        "Principal": {
          "Service": "lambda.amazonaws.com"
        },
        "Action": "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_policy" "Lambda_S33_Policy" {
  name = "Lambda_S33_Policy"
  
  policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
      {
        "Effect": "Allow",
        "Action": [
          "logs:*"
        ],
        "Resource": "arn:aws:logs:*:*:*"
      },
      {
        "Effect": "Allow",
        "Action": [
          "s3:GetObject",
          "s3:PutObject"
        ],
        "Resource": "arn:aws:s3:::*"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "Lambda_S33_Attach" {
  role       = aws_iam_role.Lambda-S33.name
  policy_arn = aws_iam_policy.Lambda_S33_Policy.arn
}


resource "aws_iam_role" "Ec2-S33" {
  name = "Ec2-S33"
  
  assume_role_policy = jsonencode({
      "Version": "2012-10-17",
      "Statement": [
          {
              "Effect": "Allow",
              "Principal": {
                  "Service": "ec2.amazonaws.com"
              },
              "Action": "sts:AssumeRole"
          }
      ]
  })
}

resource "aws_iam_role_policy" "Ec2_S3_Policy" {
  name   = "Ec2_S3_Policy"
  role   = aws_iam_role.Ec2-S33.id
  
  policy = jsonencode({
      "Version": "2012-10-17",
      "Statement": [
          {
              "Effect": "Allow",
              "Action": [
                  "s3:*",
                  "s3-object-lambda:*"
              ],
              "Resource": "*"
          }
      ]
  })
}
