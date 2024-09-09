variable "cidr_block" {
  type        = string
  description = "CIDR block for the VPC"
}

variable "public_subnet_cidr" {
  type        = string
  description = "CIDR block for the public subnet"
}

variable "private_subnet_cidr" {
  type        = string
  description = "CIDR block for the private subnet"
}

variable "vpc_name" {
  type        = string
  description = "Name for the VPC"
}

variable "availability_zone" {
  type        = string
  description = "Availability zone for subnets"
}

variable "enable_s3_endpoint" {
  type        = bool
  description = "Whether to enable S3 VPC Endpoint"
  default     = false
}

variable "region" {
  type        = string
  description = "AWS Region"
}
