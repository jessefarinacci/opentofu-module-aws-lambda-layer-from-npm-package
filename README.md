# Description
This OpenTofu/Terraform module produces an AWS Lambda Layer from an NPM package.

## Examples
Check the [examples/](./examples/) folder.

## Requirements

The following requirements are needed by this module:

- terraform (>= 1.11.0)

- archive (>= 2.0.0)

- aws (>= 6.0.0)

- null (>= 3.0.0)

## Providers

The following providers are used by this module:

- archive (2.7.1)

- aws (6.35.1)

- null (3.2.4)

## Modules

No modules.

## Resources

The following resources are used by this module:

- [aws_lambda_layer_version.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_layer_version) (resource)
- [null_resource.default](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) (resource)
- [archive_file.default](https://registry.terraform.io/providers/hashicorp/archive/latest/docs/data-sources/file) (data source)

## Required Inputs

The following input variables are required:

### lambda-layer-name

Description: Example: `mjml`

Type: `string`

### npm-dependencies

Description: Example: `[{ "package-name" = "mjml", "package-version" = "^4" }]`

Type:

```hcl
list(object({
    package-name    = string
    package-version = string
  }))
```

## Optional Inputs

The following input variables are optional (have default values):

### lambda-layer-architectures

Description: Example: `["arm64", "x86_64"]`

Type: `list(string)`

Default:

```json
[
  "arm64",
  "x86_64"
]
```

### lambda-layer-runtimes

Description: Example: `["nodejs"]`

Type: `list(string)`

Default:

```json
[
  "nodejs"
]
```

## Outputs

The following outputs are exported:

### lambda-layer-arn

Description: The ARN of the created Lambda Layer