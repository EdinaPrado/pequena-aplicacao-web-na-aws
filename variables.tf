variable "name_prefix" {
  type = string
}

variable "vpc_cidr" {
  type    = string
  default = "10.18.0.0/16"
}

variable "public_subnet_cidr" {
  type = string
}

variable "availability_zone" {
  type = string
}

variable "availability_zone_b" {
  type = string
}

variable "public_subnet_cidr_b" {
  type = string
}

variable "instance_type" {
  type = string
}