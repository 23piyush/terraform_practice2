provider "aws" {
   region     = "us-east-1"
   access_key = "AKIAZAIHTZ4OW6OJNIJF"
   secret_key = "g0gGais9VuLJzY+CdPzBIkgnl/iCjonZ+n3ACDTg"
   
}

resource "aws_instance" "ec2_example" {

    ami = "ami-053b0d53c279acc90"  
    instance_type = "t2.micro" 
    key_name= "aws_key"
    vpc_security_group_ids = [aws_security_group.main.id]

  provisioner "remote-exec" {
    inline = [ 
        "touch hello.txt",
        "echo helloworld remote provisioner >> hello.txt"
     ]
  }
  connection {
      type        = "ssh"
      host        = self.public_ip
      user        = "ubuntu"
      private_key = file("/home/piyush/keys/aws/aws_key") // This key is generated in cmd using ssh-keygen -t rsa -b 2048
      timeout     = "4m"
   }
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
 ingress                = [
   {
     cidr_blocks      = [ "0.0.0.0/0", ]
     description      = ""
     from_port        = 22
     ipv6_cidr_blocks = []
     prefix_list_ids  = []
     protocol         = "tcp"
     security_groups  = []
     self             = false
     to_port          = 22
  }
  ]
}

resource "aws_key_pair" "deployer" {
  key_name   = "aws_key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDVaTKh+8tSJSJKMbIqmRXahhLapIkUlrNM2up08itG2yWpC9tXtBm7HcLI5mNCbeDPzovKHVy9BXvzB/trJxMJFMRKlLZCaTa8aXzEbrpz+7z+m95wikT1K0+tPAnX12xdHsNz581nKFBfbccit9wD8R79lqU5sn7SPJh8jlVjdO/Nf+eBjzzICk+5e8lBP8jUe+YbewpviD4oMFlGUVQVuIBnhwAHdvp7mLGuU/7sbptDvgi6UAp0LJHZ8r86AiNJSPOUW+AKy/JYdmSNYOxaQugM/IaWJbluwWJDBn9+NeusfocvUZM2e9cOTvy+aNDy+WsJ7ZbUU4IypdqInQ+X piyush@piyush-IdeaPad-3-14ITL6"
}

# After applying terraform apply, ssh to ec2 and do "ls" to check if the file is copied or not.check "name" 

# How ssh works?
 
#  In general
# using  >> ssh-keygen -t rsa -b 2048, we generate public private key 
# Then, we copy the public key to server using ssh-copy-id 
# Now, we can login using private key 

# Here
# We provided the public key to aws using aws_key_pair
# Then use ssh -i "private key" machine_name@private-ip-address-of-ec2