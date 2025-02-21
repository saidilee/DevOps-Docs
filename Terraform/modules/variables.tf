variable "instance_type" {
  description = "Type of EC2 instance"
  default     = "t2.micro"
}

variable "ami_id" {
  description = "Amazon Machine Image ID"
  type        = string
}

variable "key_name" {
  description = "AWS Key Pair name"
  type        = string
}
