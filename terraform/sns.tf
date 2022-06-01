locals {
  emails = ["abc@def.com"]
}

resource "aws_sns_topic" "topic" {
  name            = "s3-Data-check-topic"
  delivery_policy = jsonencode({
    "http" : {
      "defaultHealthyRetryPolicy" : {
        "minDelayTarget" : 20,
        "maxDelayTarget" : 20,
        "numRetries" : 3,
        "numMaxDelayRetries" : 0,
        "numNoDelayRetries" : 0,
        "numMinDelayRetries" : 0,
        "backoffFunction" : "linear"
      },
      "disableSubscriptionOverrides" : false,
      "defaultThrottlePolicy" : {
        "maxReceivesPerSecond" : 1
      }
    }
  })
}

resource "aws_sns_topic_subscription" "topic_email_subscription" {
  count     = length(local.emails)
  topic_arn = aws_sns_topic.topic.arn
  protocol  = "email"
  endpoint  = local.emails[count.index]
}

# resource "aws_lambda_permission" "with_sns" {
#     statement_id = "AllowExecutionFromSNS"
#     action = "lambda:InvokeFunction"
#     function_name = "${aws_lambda_function.check_file_lambda.arn}"
#     principal = "sns.amazonaws.com"
#     source_arn = "${aws_sns_topic.topic.arn}"
# }

