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
  count = length(var.user_names)
  name = var.user_names[count.index]
}

variable "user_names" {
  description = "IAM usernames"
  type = list(string)
  default = [ "user1", "user2", "user3" ]
}

output "print_the_names" {
  value = [for name in var.user_names : name]
}