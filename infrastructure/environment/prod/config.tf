terraform {
  required_version = "~>1.5"
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~>5.0"
    }
  }
/*
Make sure that s3 and dynamoDB are created in advance before setting up backend
one good way of setting up backend is using cloudformation to deploy s3 and dynamoDB
*/
 
  backend "s3" {
    bucket = "rksh-terraform-state-ap-southeast-2"
    key = "opendata-prod"
    region = "ap-southeast-2"
    dynamodb_table = "rksh-terraform-lock-ap-southeast-2"
  }
}

aws {
  region = "ap-southeast-2"
}