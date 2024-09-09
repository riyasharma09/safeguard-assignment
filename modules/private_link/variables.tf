variable "allowed_principals" {
  type        = list(string)
  description = "List of allowed principals for the PrivateLink service"
}

variable "lb_name" {
  type        = string
  description = "Name of the Network Load Balancer"
}

variable "subnet_ids" {
  type        = list(string)
  description = "List of subnet IDs where NLB will be created"
}
