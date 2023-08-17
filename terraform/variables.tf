variable "region" {
  description = "AWS Region"
  default     = "us-west-1"
}

variable "instance_type" {
  description = "EC2 instance type"
  default     = "t2.micro"
}

variable "key_name" {
  description = "Key pair name"
  default     = "my-key-pair"  # Adjust this to your actual key pair name
}