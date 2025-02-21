provider "aws" {
  region     = "ap-south-1"

}
module "ec2_instance" { 

  source        = "./modules/ec2_instance_module"
  ami_id        = "ami-00bb6a80f01f03502"
  instance_type = "t2.nano"
  key_name      = "Ashok"
}
