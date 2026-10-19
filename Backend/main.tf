provider "aws" {
  region = "us-west-2"
}

resource "aws_s3_bucket" "example" {
  bucket = "terraform-eks-state-mohan-20261018-1355-847291"

  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_dynamodb_table" "basic-dynamodb-table" {
  name         = "terraform-eks-state-locks"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockId"

  attribute {
    name = "LockId"
    type = "S"
  }
}