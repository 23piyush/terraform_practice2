provider "aws" {
  region = "us-east-1"
  access_key = "AKIAZAIHTZ4OW6OJNIJF"
  secret_key = "g0gGais9VuLJzY+CdPzBIkgnl/iCjonZ+n3ACDTg"
}

resource "aws_instance" "ec2_example" {
  ami = "ami-053b0d53c279acc90"
  instance_type = "t2.micro"

  tags = {
    Name = "Terraform ec2"
  }

  provisioner "local-exec" {
    command = "touch new-file.txt"
  }
}

