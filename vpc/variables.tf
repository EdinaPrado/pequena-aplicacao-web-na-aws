variable "name_prefix" {
  description = "Prefixo usado para nomear os recursos"
  type        = string
}

variable "vpc_cidr" {
  description = "Bloco CIDR para a VPC"
  type        = string
  default     = "10.18.0.0/16"
}

variable "public_subnet_cidr" {
  description = "CIDR da subnet pública"
  type        = string
}

variable "availability_zone" {
  description = "Zona de disponibilidade onde a subnet será criada"
  type        = string
}