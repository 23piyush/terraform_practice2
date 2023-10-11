provider "aws" {
  region = "us-east-1"
  access_key = "AKIAZAIHTZ4OW6OJNIJF"
  secret_key = "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"
}

locals {
  staging_env = "staging" // Changing here will change at all places
}

resource "aws_vpc" "staging-vpc" {
  cidr_block = "10.5.0.0/16"

  tags = {
    Name = "${local.staging_env}-vpc-tag" // name of vpc
  }
}

resource "aws_subnet" "staging-subnet" {
  vpc_id = aws_vpc.staging-vpc.id
  cidr_block = "10.5.0.0/16"

  tags = {
    Name = "${local.staging_env}-subnet-tag" // name of subnet
  }
}

resource "aws_instance" "ec2_example" {
  ami = "ami-053b0d53c279acc90"
  instance_type = "t2.micro"
  subnet_id = aws_subnet.staging-subnet.id

  tags = {
    Name = "${local.staging_env}-Terraform EC2" // name of ec2
  }
}