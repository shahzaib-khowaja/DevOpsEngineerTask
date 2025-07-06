variable "name" {
  type        = string
  description = "Name prefix for the cluster"
}

variable "master_username" {
  type        = string
  description = "Master username"
}

variable "master_password" {
  type        = string
  description = "Master password"
  sensitive   = true
}

variable "instance_count" {
  type        = number
  default     = 1
}

variable "instance_class" {
  type        = string
  default     = "db.t3.medium"
}

variable "subnet_ids" {
  type        = list(string)
  description = "List of subnet IDs"
}

variable "vpc_security_group_ids" {
  type        = list(string)
  description = "List of VPC security group IDs"
}

variable "tags" {
  type        = map(string)
  default     = {}
}

