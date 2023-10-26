#Basado en https://www.udemy.com/course/terraform-indepth-with-7-realtime-casestudies/learn/lecture/11117926#questions

resource "aws_s3_bucket" "terraform-s3" {
  bucket = "terraform-s3-testing"
  versioning {
    enabled = true #con versionado guardaremos los state files antiguos
  }
  lifecycle {
    prevent_destroy = true
  }
  tags {
    Name = "S3 Remote store"
  }
}


#Create Dynamodb table for remote state locking :
resource "aws_dynamodb_table" "tflocktable" {
  name = "tflocktable"
  hash_key = "LockID"
  read_capacity = 5
  write_capacity = 5
  attribute {
    name = "LockID"
    type = "S"
  }
}


#Configure to use remote backend :
terraform {
  backend "s3" {
    encrypt = true
    bucket = "terraform-s3-testing"
    dynamodb_table = "tflocktable"
    key = "test.tfstate"
  }
}
