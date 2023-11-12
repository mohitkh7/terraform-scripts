output "lambda_arn" {
  value = aws_lambda_function.test_lambda.arn
}

output "lambda_url" {
  value = aws_lambda_function_url.test_lambda_url.function_url
}

output "base_url" {
  description = "Base URL for API gateway stage."
  value       = aws_apigatewayv2_stage.lambda_gw_stage.invoke_url
}