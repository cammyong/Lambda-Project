variable "check_file_lambda_name" {
  description = "The name of the lambda function."
  type = string
  default = "check_file_lambda"
}

variable "report_error_lambda_name" {
  description = "The name of the lambda function."
  type = string
  default = "report_error_lambda"
}


variable "step_function_name" {
  description = "The name of the step function."
  type = string
  default = "test_step_function"
}