AWS_ACCESS_KEY_ID="AKIAQE43J2QFNDYCKXM6"
AWS_SECRET_ACCESS_KEY="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"
AWS_REGION="eu-north-1"
AWS_OUTPUT_FORMAT="json"


aws configure set aws_access_key_id $AWS_ACCESS_KEY_ID
aws configure set aws_secret_access_key $AWS_SECRET_ACCESS_KEY
aws configure set region $AWS_REGION
aws configure set output $AWS_OUTPUT_FORMAT

echo "AWS credentials set!"