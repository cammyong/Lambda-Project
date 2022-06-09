variable "check_file_lambda_name" {
  description = "The name of the lambda function."
  type        = string
  default     = "check_file_lambda"
}

variable "report_error_lambda_name" {
  description = "The name of the lambda function."
  type        = string
  default     = "report_error_lambda"
}


variable "step_function_name" {
  description = "The name of the step function."
  type        = string
  default     = "test_step_function"
}

variable "env_name" {
  default     = "s3-lambda-copy"
  description = "Terraform environment name"
}

variable "aws_region" {
  default     = "eu-central-1"
  description = "AWS Region to deploy to"
}

variable "bucket_name" {
  description = "name of s3 bucket"
  type        = string
}