#!/bin/bash
# Instala e inicializa o servidor Nginx
dnf update -y
dnf install nginx -y
systemctl start nginx
systemctl enable nginx

# Cria a página web exatamente com o conteúdo que você solicitada
cat << 'EOF' > /usr/share/nginx/html/index.html
-------------------------------------

             DEVOPS LAB

     Provisioned with Terraform

Environment: QA

Managed by: Terraform

-------------------------------------
EOF
