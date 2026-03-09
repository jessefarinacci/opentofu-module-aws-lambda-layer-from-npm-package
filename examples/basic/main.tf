# MIT License
#
# Copyright (c) 2026 Jesse Farinacci
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

data "archive_file" "example" {
  output_path = "${path.module}/.terraform/example.zip"
  type        = "zip"

  source {
    content  = "module.exports.handler = async(event) { return event };"
    filename = "index.mjs"
  }
}

module "example" {
  source            = "../"
  lambda-layer-name = "mjml"
  npm-dependencies  = [{ package-name = "mjml", package-version = "^4" }]
}

resource "aws_iam_role" "example" {
  # NOTE: you probably should attach persmissions to this role
  assume_role_policy = jsonencode({
    "Statement" = [{ "Action" = "sts:AssumeRole", "Effect" = "Allow", "Principal" = { "Service" = ["lambda.amazonaws.com"] } }],
    "Version"   = "2012-10-17",
  })
  name = "example"
}

resource "aws_lambda_function" "example" {
  code_sha256   = data.archive_file.example.output_base64sha256
  filename      = data.archive_file.example.output_path
  function_name = "example"
  handler       = "index.handler"
  layers        = [module.example.lambda-layer-arn]
  role          = aws_iam_role.example.arn
  runtime       = "nodejs24.x"
}

output "function-arn" {
  value = aws_lambda_function.example.arn
}
