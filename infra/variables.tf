variable "project" {
  description = "Project name"
}

variable "region" {
  description = "Region of the project"
}

variable "availability_zones" {
  type        = list(any)
  description = "The names of the availability zones to use"
}

variable "private_subnet_cidr" {
  description = "The CIDR block of the subnet"
}

variable "public_subnet_cidr" {
  description = "The CIDR block of the subnet"
}

variable "frontend_image" {
  description = "The image used by frontend instance"
}

variable "backend_image" {
  description = "The image used by backend instance"
}

variable "cos_image" {
  description = "Container compatible image used by both instances"
}