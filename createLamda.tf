data "archive_file" "lambda_zip" {
    type          = "zip"
    source_file   = "lamdaFun.py"
    output_path   = "lambda_function.zip"
}

resource "aws_lambda_function" "change_prediction" {
  filename         = "lambda_function.zip"
  function_name    = "cmbot_lambda"
  role             = "${aws_iam_role.iam_for_lambda_cmbot.arn}"
  handler          = "lamdaFun.lambda_handler"
  source_code_hash = "${data.archive_file.lambda_zip.output_base64sha256}"
  runtime          = "python3.7"
  timeout	   = "8"
  tags 		   = local.common_tags
  environment {
    variables = {
      ENDPOINT_NAME = "change-success-predictor"
    }
  }

}
