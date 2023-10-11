provider "aws" {
  region = "us-east-1"
  access_key = "AKIAZAIHTZ4OW6OJNIJF"
  secret_key = "g0gGais9VuLJzY+CdPzBIkgnl/iCjonZ+n3ACDTg"
}

resource "aws_instance" "ec2_example" {
  ami = "ami-053b0d53c279acc90"
  instance_type = var.instance_type
  count = var.instance_count
  associate_public_ip_address = var.enable_public_ip

  tags = var.project_environment
}

resource "aws_iam_user" "example" {
  count = length(var.user_names)
  name = var.user_names[count.index]
}

variable "instance_type" {
  description = "Instance type t2.micro"
  type = string
  default = "t2.micro"
}

variable "instance_count" {
  description = "ec2 instance count"
  type = number
  default = 2
}

variable "enable_public_ip" {
  description = "Enable public ip address"
  type = bool
  default = true
}

variable "user_names" {
  description = "IAM usernames"
  type = list(string)
  default = [ "user1", "user2", "user3" ]
}

variable "project_environment" {
  description = "project name and environment"
  type = map(string)   // type of value in key-value is string
  default = {
    project = "project-alpha"
    environment = "dev"
  }
}
