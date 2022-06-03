// Lambda function
resource "aws_lambda_function" "check_file_lambda" {
  function_name    = var.check_file_lambda_name
  filename         = data.archive_file.check_file_lambda_zip_file.output_path
  source_code_hash = data.archive_file.check_file_lambda_zip_file.output_base64sha256
  handler          = "check_file_lambda.handler"
  role             = aws_iam_role.lambda_assume_role.arn
  runtime          = "python3.8"

  lifecycle {
    create_before_destroy = true
  }
}

// Zip of lambda handler
data "archive_file" "check_file_lambda_zip_file" {
  output_path = "${path.module}/lambda_zip/check_file_lambda.zip"
  source_dir  = "${path.module}/../lambda"
  excludes    = ["__init__.py", "*.pyc"]
  type        = "zip"
}

// Lambda IAM assume role
resource "aws_iam_role" "lambda_assume_role" {
  name               = "lambda-assume-role"
  assume_role_policy = data.aws_iam_policy_document.lambda_assume_role_policy_document.json

  lifecycle {
    create_before_destroy = true
  }
}

// Lambda function
resource "aws_lambda_function" "report_error_lambda" {
  function_name    = var.report_error_lambda_name
  filename         = data.archive_file.report_error_lambda_zip_file.output_path
  source_code_hash = data.archive_file.report_error_lambda_zip_file.output_base64sha256
  handler          = "report_error_lambda.handler"
  role             = aws_iam_role.lambda_assume_role.arn
  runtime          = "python3.8"

  environment {
    variables = {
      sns_arn = aws_sns_topic.topic.arn
    }
  }

  lifecycle {
    create_before_destroy = true
  }
}

// Zip of lambda handler
data "archive_file" "report_error_lambda_zip_file" {
  output_path = "${path.module}/lambda_zip/report_error_lambda.zip"
  source_dir  = "${path.module}/../lambda"
  excludes    = ["__init__.py", "*.pyc"]
  type        = "zip"
}


// IAM policy document for lambda assume role
data "aws_iam_policy_document" "lambda_assume_role_policy_document" {
  version = "2012-10-17"

  statement {
    sid     = "LambdaAssumeRole"
    effect  = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      identifiers = ["lambda.amazonaws.com"]
      type        = "Service"
    }
  }
}

resource "aws_iam_role_policy" "lambda_policy" {
  name   = "lambda-policy"
  role   = aws_iam_role.lambda_assume_role.id
  policy = data.aws_iam_policy_document.lambda_policy_document.json

  lifecycle {
    create_before_destroy = true
  }
}

data "aws_iam_policy_document" "lambda_policy_document" {
  version = "2012-10-17"

  statement {
    sid    = "LambdaPrivileges"
    effect = "Allow"
    actions = [
      "sns:*",
      "s3:ListBucket",
      "s3:GetObject",
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents"
    ]
    resources = ["*"]
  }
}



