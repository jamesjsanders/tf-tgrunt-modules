provider "aws" {
  profile = "${var.aws_profile}"
  region  = "${var.aws_region}"
  version = "~> 2.32.0"
}

terraform {
  # backend filled in by Terragrunt
  backend "s3" {}

  # Requires Terraform 0.12.0 or above.
  required_version = ">= 0.12.0"
  required_providers {
    aws   = "~> 2.32.0"
    local = "~> 1.2"
    null  = "~> 2.0"
  }
}
