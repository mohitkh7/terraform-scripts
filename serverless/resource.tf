data "aws_iam_policy_document" "assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "iam_for_lambda" {
  name               = "iam_for_lambda"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

data "archive_file" "lambda" {
  type        = "zip"
  source_file = "main.py"
  output_path = "lambda_function_payload.zip"
}

# creates lambda function
resource "aws_lambda_function" "test_lambda" {
  filename         = "lambda_function_payload.zip"
  function_name    = "${var.PROJECT}-lambda"
  description      = "Lambda deployed via terraform"
  role             = aws_iam_role.iam_for_lambda.arn
  source_code_hash = data.archive_file.lambda.output_base64sha256
  runtime          = "python3.11"
  handler          = "main.handler"

  environment {
    variables = {
      foo = "bar"
    }
  }

  tags = {
    Name        = "Terraform Deployed Lambda"
    Description = "Lambda deployed via terraform"
  }
}

# gives public accessible url to lambda function
resource "aws_lambda_function_url" "test_lambda_url" {
  function_name      = aws_lambda_function.test_lambda.function_name
  authorization_type = "NONE"
}

# defines a name for the API Gateway and sets its protocol to HTTP.
resource "aws_apigatewayv2_api" "lambda_gw" {
  name          = "${var.PROJECT}-gw"
  protocol_type = "HTTP"
}

# sets up application stages for the API Gateway - such as "Test", "Staging", and "Production". The example configuration defines a single stage
resource "aws_apigatewayv2_stage" "lambda_gw_stage" {
  api_id      = aws_apigatewayv2_api.lambda_gw.id
  name        = "${var.PROJECT}-stage"
  auto_deploy = true
}

# configures the API Gateway to use your Lambda function.
resource "aws_apigatewayv2_integration" "lambda_gw_integration" {
  api_id = aws_apigatewayv2_api.lambda_gw.id

  integration_uri        = aws_lambda_function.test_lambda.invoke_arn
  integration_type       = "AWS_PROXY"
  integration_method     = "POST"
  payload_format_version = "2.0"
}

# maps an HTTP request to a target, in this case your Lambda function
resource "aws_apigatewayv2_route" "lambda_gw_route" {
  api_id = aws_apigatewayv2_api.lambda_gw.id

  route_key = "GET /hello"
  target    = "integrations/${aws_apigatewayv2_integration.lambda_gw_integration.id}"
}

# gives API Gateway permission to invoke Lambda function.
resource "aws_lambda_permission" "lambda_gw_permission" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.test_lambda.function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_apigatewayv2_api.lambda_gw.execution_arn}/*/*"
}