resource "aws_sns_topic" "ivolve_topic" {
  name = "SNS_topic"
}

resource "aws_sns_topic_subscription" "name" {
  topic_arn = aws_sns_topic.ivolve_topic.arn
  protocol  = "email"
  endpoint  = "ahmedmohamedooo77@gmail.com"
}