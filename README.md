# Pequena Aplicação Web na AWS

Infraestrutura como código (Terraform) para provisionar uma aplicação web simples na AWS, com alta disponibilidade via **Application Load Balancer (ALB)** distribuindo tráfego entre **2 instâncias EC2** em zonas de disponibilidade diferentes, servindo uma página estática via **Nginx**.

## Arquitetura

```
                        Internet
                            │
                            ▼
                   ┌─────────────────┐
                   │   ALB (público)  │
                   │  porta 80 (HTTP) │
                   └────────┬─────────┘
                            │
              ┌─────────────┴─────────────┐
              ▼                           ▼
     ┌─────────────────┐         ┌─────────────────┐
     │  EC2 Instância 1 │         │  EC2 Instância 2 │
     │  Subnet A (AZ-a) │         │  Subnet B (AZ-b) │
     │  Nginx + Amazon  │         │  Nginx + Amazon  │
     │      Linux 2023  │         │      Linux 2023  │
     └─────────────────┘         └─────────────────┘
              │                           │
              └─────────────┬─────────────┘
                             ▼
                   ┌──────────────────┐
                   │   VPC (10.18.0.0/16) │
                   │  2 subnets públicas  │
                   │  Internet Gateway    │
                   │  Route Table pública │
                   └──────────────────┘
```

## Estrutura do repositório

```
pequena-aplicacao-web-na-aws/
├── vpc/                          # Módulo de rede (VPC, subnets, IGW, rotas)
│   ├── main.tf
│   ├── variables.tf
│   ├── outputs.tf
│   ├── terraform.tfvars          # (não versionado — ver .gitignore)
│   ├── terraform.tfvars.example
│   └── EC2/                      # Módulo de aplicação (instâncias EC2)
│       ├── main.tf
│       ├── variables.tf
│       ├── outputs.tf
│       ├── data.tf               # Data source da AMI Amazon Linux 2023
│       ├── Nginx.sh.tpl          # Template do user_data (nginx + página)
│       ├── terraform.tfvars      # (não versionado)
│       ├── terraform.tfvars.example
│       └── ALB/                  # Módulo do Load Balancer
│           ├── main.tf
│           ├── variables.tf
│           ├── outputs.tf
│           ├── terraform.tfvars  # (não versionado)
│           └── terraform.tfvars.example
└── README.md
```

> Os três diretórios (`vpc/`, `EC2/`, `EC2/ALB/`) são **estados Terraform independentes**. Cada um precisa do seu próprio `terraform init`, `plan` e `apply`, executados na ordem descrita abaixo.

## Pré-requisitos

- [Terraform](https://developer.hashicorp.com/terraform/downloads) instalado
- Credenciais AWS configuradas (`aws configure` ou variáveis de ambiente)
- Conta AWS com permissão para criar VPC, EC2, Security Groups e Load Balancers

## Ordem de execução

A infraestrutura tem dependências entre módulos, então a ordem importa:

```
1. vpc/       → cria a rede (VPC + 2 subnets em AZs diferentes)
2. EC2/ALB/   → cria o Load Balancer (depende dos subnet_ids da VPC)
3. EC2/       → cria as instâncias (depende do vpc_id da VPC e do target_group/SG do ALB)
```

### 1. Provisionar a VPC

```bash
cd vpc
cp terraform.tfvars.example terraform.tfvars   # edite com seus valores
terraform init
terraform plan -var-file="terraform.tfvars"
terraform apply -var-file="terraform.tfvars"
```

Anote os outputs `vpc_id`, `public_subnet_id` e `public_subnet_id_b` — eles serão usados nos próximos módulos.

```bash
terraform output
```

### 2. Provisionar o Load Balancer

```bash
cd EC2/ALB
cp terraform.tfvars.example terraform.tfvars   # preencha com vpc_id e os 2 subnet_ids do passo anterior
terraform init
terraform plan -var-file="terraform.tfvars"
terraform apply -var-file="terraform.tfvars"
```

Anote os outputs `alb_dns_name`, `alb_security_group_id` e `target_group_arn`.

```bash
terraform output
```

### 3. Provisionar as instâncias EC2

```bash
cd ../  # volta para EC2/
cp terraform.tfvars.example terraform.tfvars   # preencha com vpc_id, subnet_ids e os outputs do ALB
terraform init
terraform plan -var-file="terraform.tfvars"
terraform apply -var-file="terraform.tfvars"
```

### 4. Testar

Aguarde 1-2 minutos para as instâncias passarem no health check do target group, depois acesse o DNS do ALB:

```bash
curl http://<alb_dns_name>
```

Atualize algumas vezes — a resposta deve alternar entre `Instância: 1` e `Instância: 2`, confirmando o balanceamento de carga.

Para conferir a saúde dos targets diretamente:
```bash
aws elbv2 describe-target-health --target-group-arn "<target_group_arn>"
```

## Detalhes de cada módulo

### `vpc/`
Cria a VPC (CIDR configurável via `vpc_cidr`, default `10.18.0.0/16`), duas subnets públicas em zonas de disponibilidade diferentes (requisito do ALB), um Internet Gateway e uma Route Table pública associada às duas subnets.

**Variáveis principais:** `name_prefix`, `vpc_cidr`, `public_subnet_cidr` / `public_subnet_cidr_b`, `availability_zone` / `availability_zone_b`.

### `EC2/ALB/`
Cria o Application Load Balancer, seu próprio Security Group (libera porta 80 do mundo), um Target Group (health check em `/`) e um Listener HTTP na porta 80 encaminhando para o Target Group.

**Variáveis principais:** `name_prefix`, `vpc_id`, `public_subnet_ids` (lista com as 2 subnets).

### `EC2/`
Cria 2 instâncias EC2 (Amazon Linux 2023, via `data.aws_ami`), distribuídas uma em cada subnet (`element(var.subnet_ids, count.index)`), com um Security Group que libera SSH (22) para qualquer origem e HTTP (80) **apenas** a partir do Security Group do ALB. Cada instância é registrada no Target Group via `aws_lb_target_group_attachment`.

O `user_data` usa `templatefile()` sobre `Nginx.sh.tpl`, injetando o número da instância (`instance_number = count.index + 1`) para diferenciar visualmente qual instância respondeu à requisição — útil para validar o balanceamento de carga.

**Variáveis principais:** `name_prefix`, `instance_type`, `vpc_id`, `subnet_ids` (lista), `alb_security_group_id`, `target_group_arn`.

⚠️ O `user_data` só roda no **primeiro boot** da instância. Alterações no `Nginx.sh.tpl` exigem recriar a instância (`terraform apply -replace="aws_instance.web_server[N]"`) para terem efeito — uma simples atualização in-place não reexecuta o script.

## Segurança e boas práticas aplicadas

- Instâncias EC2 não aceitam tráfego HTTP diretamente da internet — só do Security Group do ALB.
- Nenhum arquivo `terraform.tfstate` ou `terraform.tfvars` (com dados reais da conta) é versionado — ver `.gitignore`.
- Cada módulo usa `*.tfvars.example` como referência de preenchimento, sem expor IDs reais de VPC/subnet/conta.
- Duas AZs distintas garantem tolerância a falha de uma zona de disponibilidade.

## Destruindo a infraestrutura

A destruição segue a **ordem inversa** da criação, para respeitar as dependências entre módulos:

```bash
# 1. Instâncias primeiro
cd EC2
terraform destroy -var-file="terraform.tfvars"

# 2. Depois o Load Balancer
cd ALB
terraform destroy -var-file="terraform.tfvars"

# 3. Por último, a VPC
cd ../..
terraform destroy -var-file="terraform.tfvars"
```

⚠️ Destruir a VPC antes do ALB/EC2 falha, pois ainda existem recursos dependentes (subnets em uso, ENIs do ALB, etc).

## Ambiente de teste local (WSL) — nota

O script `Nginx.sh.tpl` usa `dnf`, gerenciador de pacotes do **Amazon Linux** — não funciona em ambientes Ubuntu/Debian (que usam `apt`). Isso é esperado: o script é feito para rodar como `user_data` na instância EC2 real (Amazon Linux 2023), não para teste local no WSL.


