
variable "aws_region" {
  description = "The AWS region to deploy into"
  type        = string
  default     = "eu-west-1"
}

variable "owner" {
  description = "Owner of the Cluster"
  type        = string
  default     = "paololatella"
}