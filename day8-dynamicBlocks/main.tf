provider "aws" {
   region     = "us-east-1"
#    access_key = "AKIAZAIHTZ4OW6OJNIJF"
#    secret_key = "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"
   
}

locals {
  ingress_rules = [{
    port = 443
    description = "Ingress rule for port 443"
  },
  {
    port = 22
    description = "Ingress rule for port 22"
  }]
}

resource "aws_instance" "ec2_example" {

    ami = "ami-053b0d53c279acc90"  
    instance_type = "t2.micro" 
    key_name= "aws_key"
    vpc_security_group_ids = [aws_security_group.main.id]

}

resource "aws_security_group" "main" {
  egress = [
    {
      cidr_blocks      = [ "0.0.0.0/0", ]
      description      = ""
      from_port        = 0
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "-1"
      security_groups  = []
      self             = false
      to_port          = 0
    }
  ]
 dynamic "ingress" {
   for_each = local.ingress_rules

   content {
     description = ingress.value.description
     from_port = ingress.value.port
     to_port = ingress.value.port
     protocol = "tcp"
     cidr_blocks = ["0.0.0.0/0"]
   }
 }
}

resource "aws_key_pair" "deployer" {
  key_name   = "aws_key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDVaTKh+8tSJSJKMbIqmRXahhLapIkUlrNM2up08itG2yWpC9tXtBm7HcLI5mNCbeDPzovKHVy9BXvzB/trJxMJFMRKlLZCaTa8aXzEbrpz+7z+m95wikT1K0+tPAnX12xdHsNz581nKFBfbccit9wD8R79lqU5sn7SPJh8jlVjdO/Nf+eBjzzICk+5e8lBP8jUe+YbewpviD4oMFlGUVQVuIBnhwAHdvp7mLGuU/7sbptDvgi6UAp0LJHZ8r86AiNJSPOUW+AKy/JYdmSNYOxaQugM/IaWJbluwWJDBn9+NeusfocvUZM2e9cOTvy+aNDy+WsJ7ZbUU4IypdqInQ+X piyush@piyush-IdeaPad-3-14ITL6"
}


# This .tf file will open port 22 and 443 on ec2 instance by adding "inbound rules" to ec2 instance under security group.
# Since i have commented "access_key" and "secret_key", to provide aws credentials use "aws configure" and then run this terraform
# init, plan and apply commands

# Best practices
# 1. Don't overuse it 
# 2. Keep it clean and simple so that it can be reused, i.e., Don't do nesting of dynamic blocks
