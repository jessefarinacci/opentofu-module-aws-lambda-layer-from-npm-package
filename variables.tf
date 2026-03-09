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

locals {
  npm-packages = join(" ", [for d in var.npm-dependencies : join("@", [d.package-name, d.package-version])])
}

variable "lambda-layer-architectures" {
  description = "Example: `[\"arm64\", \"x86_64\"]`"
  default     = ["arm64", "x86_64"]
  type        = list(string)
}

variable "lambda-layer-runtimes" {
  description = "Example: `[\"nodejs\"]`"
  default     = ["nodejs"]
  type        = list(string)
}

variable "lambda-layer-name" {
  description = "Example: `mjml`"
  nullable    = false
  type        = string
}

variable "npm-dependencies" {
  description = "Example: `[{ \"package-name\" = \"mjml\", \"package-version\" = \"^4\" }]`"
  nullable    = false
  type = list(object({
    package-name    = string
    package-version = string
  }))
}
