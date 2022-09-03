variable "name" {
  description = "the name of your rds instance, e.g. \"demo\""
}
variable "db_name" {
  description = "the name of your rds instance, e.g. \"demo\""
}
variable "username" {
  description = "the username of your rds instance, e.g. \"demo\""
}
variable "password" {
  description = "the username of your rds instance, e.g. \"demo\""
}
variable "instance_class" {
  description = "the username of your rds instance, e.g. \"demo\""
}

variable "environment" {
  description = "the name of your environment, e.g. \"prod\""
}

variable "private_subnets" {
  description = "List of private subnets"
}
variable "private_subnets_cidr" {
  description = "List of private subnets"
}
variable "vpc" {
  description = "List of private subnets"
}
