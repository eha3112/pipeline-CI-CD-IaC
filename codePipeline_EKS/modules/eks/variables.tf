

variable "project" {
  description = "Name of the project deployment."
  type        = string
  default     = "eks-mate"
}


variable "vpc_cidr" {
  description = "The CIDR block for the VPC. Default value is a valid CIDR, but not acceptable by AWS and should be overridden"
  type        = string
  default     = "10.0.0.0/16"
}

variable "subnet_cidr_bits" {
  description = "The number of bits per a subnet"
  type        = string
  default     = 8
}

variable "availability_zones_count" {
  description = "The number of availibility Zone"
  type        = number
  default     = 2
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default = {
    "Project"     = "TerraformEKSWorkshop"
    "Environment" = "Development"
    "Owner"       = "eha"
  }
}