# Source s3 bucket and destination
resource "aws_s3_bucket" "source_bucket" {
   bucket = "${var.env_name}-src-bucket"
   force_destroy = true
}

resource "aws_s3_bucket" "destination_bucket" {
   bucket = "${var.env_name}-dst-bucket"
   force_destroy = true
}




# To enable lambda function copy files between s3 buckets
resource "aws_iam_policy" "lambda_policy" {
  name        = "${var.env_name}_lambda_policy"
  description = "${var.env_name}_lambda_policy"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "s3:ListBucket",
        "s3:GetObject",
        "s3:CopyObject",
        "s3:HeadObject"
      ],
      "Effect": "Allow",
      "Resource": [
        "arn:aws:s3:::${var.env_name}-src-bucket",
        "arn:aws:s3:::${var.env_name}-src-bucket/*"
      ]
    },
    {
      "Action": [
        "s3:ListBucket",
        "s3:PutObject",
        "s3:PutObjectAcl",
        "s3:CopyObject",
        "s3:HeadObject"
      ],
      "Effect": "Allow",
      "Resource": [
        "arn:aws:s3:::${var.env_name}-dst-bucket",
        "arn:aws:s3:::${var.env_name}-dst-bucket/*"
      ]
    },
    {
      "Action": [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF
}    

# Lambda function to grant s3 permission
resource "aws_iam_role_policy_attachment" "terraform_lambda_iam_policy_basic_execution" {
 role = "${aws_iam_role.step_function_role.id}"
 policy_arn = "${aws_iam_policy.lambda_policy.arn}"
}

# Permission for s3 bucket to trigger lambda function
resource "aws_lambda_permission" "allow_terraform_bucket" {
   statement_id = "AllowExecutionFromS3Bucket"
   action = "lambda:InvokeFunction"
   function_name = var.check_file_lambda_name
   principal = "s3.amazonaws.com"
   source_arn = "${aws_s3_bucket.source_bucket.arn}"
}

resource "aws_lambda_function" "s3_copy_function" {
   filename = data.archive_file.check_file_lambda_zip_file.output_path
   source_code_hash = data.archive_file.check_file_lambda_zip_file.output_base64sha256
   function_name = "${var.env_name}_s3_copy_lambda"
   role = aws_iam_role.lambda_assume_role.arn
   handler = "index.handler"
   runtime = "python3.8"

   environment {
       variables = {
           DST_BUCKET = "${var.env_name}-dst-bucket",
           REGION = "${var.aws_region}"
       }
   }
}

# resource "aws_s3_bucket_notification" "bucket_terraform_notification" {
#    bucket = "${aws_s3_bucket.source_bucket.id}"
#    lambda_function {
#        lambda_function_arn = "${aws_lambda_function.s3_copy_function.arn}"
#        events = ["s3:ObjectCreated:*"]
#    }

#    depends_on = [ aws_lambda_permission.allow_terraform_bucket ]
# }