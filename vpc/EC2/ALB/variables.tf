variable "name_prefix" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "public_subnet_ids" {
  description = "Lista com as duas subnets públicas (AZs diferentes)"
  type        = list(string)
}