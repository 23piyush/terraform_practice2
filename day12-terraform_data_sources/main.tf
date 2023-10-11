provider "aws" {
   region     = "us-east-1"
   access_key = "AKIAZAIHTZ4OW6OJNIJF"
   secret_key = "g0gGais9VuLJzY+CdPzBIkgnl/iCjonZ+n3ACDTg"
   
}

resource "aws_instance" "ec2_example" {
  ami = "ami-053b0d53c279acc90"
  instance_type = "t2.micro"
  tags = {
    Name = "Terraform ec2"
  }
}

data "aws_instance" "myawsinstance" {
  filter {
    name = "tag:Name"
    values = ["Terraform ec2"]
  }

  depends_on = [ 
    "aws_instance.ec2_example"
     ]
}

output "fetched_info_from_aws" {
  value = data.aws_instance.myawsinstance.public_ip 
}

# To see the difference, run init, plan and apply without data and output cidr_blocks
# Then, include these and run apply only. You will see details on console.
