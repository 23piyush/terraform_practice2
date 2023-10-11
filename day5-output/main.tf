provider "aws" {
  region = "us-east-1"
  access_key = "AKIAZAIHTZ4OW6OJNIJF"
  secret_key = "g0gGais9VuLJzY+CdPzBIkgnl/iCjonZ+n3ACDTg"
}

resource "aws_instance" "ec2_example" {
  ami = "ami-053b0d53c279acc90"
  instance_type = "t2.micro"
  tags = {
    Name = "Terraform EC2" // name of ec2
  }
}

output "my_console_output" {
#   value = "Hello this is output"
value = aws_instance.ec2_example.public_ip // public ip of ec2 launched
sensitive = true  // won't print the value on console, use this to avoid printing sensitive values on console
}