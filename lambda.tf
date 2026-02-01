#lambda
resource "aws_lambda_function" "portfolio-lambda" {
  function_name = "portfolio-lambda"
  runtime       = "python3.12"
  handler       = "lambda_function.lambda_handler"
  role          = aws_iam_role.lambda_role.arn

  filename         = "lambda.zip"
  source_code_hash = filebase64sha256("lambda.zip")
}