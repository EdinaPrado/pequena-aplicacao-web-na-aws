variable "name_prefix" {
  description = "Prefixo usado para nomear os recursos"
  type        = string
}

variable "instance_type" {
  description = "Tipo da instância EC2"
  type        = string
}

variable "vpc_id" {
  description = "ID da VPC onde os recursos serão criados"
  type        = string
}

variable "subnet_ids" {
  description = "Lista de subnets para distribuir as instâncias"
  type        = list(string)
}

variable "alb_security_group_id" {
  description = "ID do security group do ALB"
  type        = string
}

variable "target_group_arn" {
  description = "ARN do target group do ALB"
  type        = string
}