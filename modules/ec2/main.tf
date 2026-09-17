resource "aws_security_group" "instance" {
  name        = "${var.name_prefix}-sg"
  description = "Security group para a instancia EC2"
  vpc_id      = var.vpc_id

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description     = "HTTP via ALB"
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [var.alb_security_group_id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.name_prefix}-sg"
  }
}

resource "aws_instance" "web_server" {
  count                  = 2
  ami                    = data.aws_ami.amazon_linux.id
  instance_type          = var.instance_type
  subnet_id              = element(var.subnet_ids, count.index)
  vpc_security_group_ids = [aws_security_group.instance.id]

  user_data = templatefile("${path.module}/Nginx.sh.tpl", {
    instance_number = count.index + 1
  })

  tags = {
    Name = "${var.name_prefix}-instance-${count.index + 1}"
  }
}

resource "aws_lb_target_group_attachment" "app" {
  count            = 2
  target_group_arn = var.target_group_arn
  target_id        = aws_instance.web_server[count.index].id
  port             = 80
}
