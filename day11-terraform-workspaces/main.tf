# Create a terraform workspace and then start an ec2 insatnce using two workspaces - dev workspace and test workspace
provider "aws" {
   region     = "us-east-1"
   access_key = "AKIAZAIHTZ4OW6OJNIJF"
   secret_key = "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"
   
}

locals {
  instance_name = "${terraform.workspace}-instance"
#   ${terraform.workspace} is the name of active workspace
}

resource "aws_instance" "ec2_example" {
  ami = "ami-053b0d53c279acc90"
  instance_type = var.instance_type
  tags = {
    Name = local.instance_name
  }
}


# >> terraform workspace list => to list the available workspace
# o/p : * default
# By default, you will see default workspace
# * indicates active workspace
# >> terraform workspace new dev
#  Created and switched to workpsace "dev"!!
# >> terraform workspace list 
# default
# * dev
# >> terraform workspace new test
# >> terraform workspace show => to show only the active workspace 

# Now let's create two ec2 instances using same .tf script in two different workspaces
# >> terraform workspace select dev => to switch to a particular workspace 
# >> terraform plan -var-file="dev.tfvars"
# >> terraform apply -var-file="dev.tfvars"
# >> terraform workspace switch test
# >> terraform plan -var-file="test.tfvars"
# >> terraform apply -var-file="test.tfvars"

# >> terraform destroy => run this command in all workspaces individually to destroy all resources Created