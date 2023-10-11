provider "aws" {
  region = "us-east-1"
  access_key = "AKIAZAIHTZ4OW6OJNIJF"
  secret_key = "g0gGais9VuLJzY+CdPzBIkgnl/iCjonZ+n3ACDTg"
}

resource "aws_instance" "ec2_example" {
  ami = "ami-053b0d53c279acc90"
  instance_type = "t2.micro"
  count = 1

  tags = {
    Name = "Terraform ec2"
  }
}

resource "aws_iam_user" "example" {
  for_each = var.user_names
  name = each.value
}

variable "user_names" {
  description = "IAM usernames"
#   type = list(string) // You can't use for_each loop with list data structure
  type = set(string)
  default = [ "user1", "user2", "user3" ]
}