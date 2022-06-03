resource "aws_sfn_state_machine" "sfn_state_machine" {
  name     = var.step_function_name
  role_arn = aws_iam_role.step_function_role.arn

  definition = <<EOF
  {
    "Comment": "Invoke AWS Lambda from AWS Step Functions with Terraform",
    "StartAt": "Check File",
    "States": {
      "Check File": {
        "Type": "Task",
        "Resource": "${aws_lambda_function.check_file_lambda.arn}",
        "Catch": [ {
          "ErrorEquals": ["States.ALL"],
          "Next": "Report Error"
        } ],
        "End": true
      },
      "Report Error": {
        "Type": "Task",
        "Resource": "${aws_lambda_function.report_error_lambda.arn}",       
        "Next": "Fail State"
      },
      "Fail State": {
        "Type": "Fail"
      }
    }
  }
  EOF
}

resource "aws_iam_role" "step_function_role" {
  name               = "${var.step_function_name}-role"
  assume_role_policy = <<-EOF
  {
    "Version": "2012-10-17",
    "Statement": [
      {
        "Action": "sts:AssumeRole",
        "Principal": {
          "Service": "states.amazonaws.com"
        },
        "Effect": "Allow",
        "Sid": "StepFunctionAssumeRole"
      }
    ]
  }
  EOF
}

resource "aws_iam_role_policy" "step_function_policy" {
  name = "${var.step_function_name}-policy"
  role = aws_iam_role.step_function_role.id

  policy = <<-EOF
  {
    "Version": "2012-10-17",
    "Statement": [
      {
        "Action": [
          "lambda:InvokeFunction"
        ],
        "Effect": "Allow",
        "Resource": [
          "${aws_lambda_function.check_file_lambda.arn}",
          "${aws_lambda_function.report_error_lambda.arn}"
        ]
      }
    ]
  }
  EOF
}