# ☁️ Pequena Aplicação Web na AWS

Uma infraestrutura como código (IaC) leve, modular e automatizada utilizando **Terraform** para provisionar recursos na **Amazon Web Services (AWS)** com servidor web **Nginx**.

---

## 📋 Descrição do Projeto

Este projeto automatiza a criação de um ambiente seguro e escalável na AWS para hospedar uma aplicação web utilizando o Nginx. A infraestrutura adota uma **abordagem modular**, dividindo as responsabilidades de rede e computação em subdiretórios próprios. 

Embora vários arquivos compartilhem o mesmo nome (`main.tf`, `variables.tf`, `outputs.tf`), eles possuem **configurações e escopos totalmente diferentes** para garantir o isolamento e a reusabilidade do código.

---

## 🛠️ Tecnologias Utilizadas

*   **Terraform** (v1.0.0+) - Ferramenta de Infraestrutura como Código (IaC).
*   **AWS Cloud** - Provedor de nuvem para hospedagem dos recursos.
*   **Nginx** - Servidor web de alto desempenho para entregar a aplicação.
*   **Shell Script (`.sh`)** - Automação do provisionamento do servidor durante a inicialização.

---

## 🗂️ Arquitetura de Módulos e Estrutura de Arquivos

O projeto está organizado em um módulo raiz e dois submódulos independentes:

### 📂 Diretório Raiz (Root Module)
Responsável por orquestrar o projeto, chamando os submódulos e passando os dados de um para o outro.
*   📄 **`main.tf`**: Instancia e interliga os módulos de rede (`vpc`) e computação (`EC2`).
*   📄 **`variables.tf`**: Variáveis globais e de ambiente (ex: região padrão da AWS).
*   📄 **`outputs.tf`**: Exibe as informações consolidadas no terminal ao fim do deploy (ex: URL/IP público da aplicação).
*   📄 **`data.tf`**: Consultas globais que servem de apoio para múltiplos componentes.
*   📄 **`.gitignore`**: Configurado para impedir o envio de arquivos de estado local do Terraform (`.tfstate`) e chaves privadas.

### 📂 Módulo de Rede (`/vpc`)
Contém a lógica isolada para a construção da malha de rede na nuvem.
*   📄 **`main.tf`**: Criação da VPC, Subnets públicas/privadas, Internet Gateway e Tabelas de Roteamento.
*   📄 **`variables.tf`**: Parâmetros exclusivos de rede (ex: blocos CIDR da VPC).
*   📄 **`outputs.tf`**: Exporta dados gerados (como `vpc_id` e `subnet_id`) que a EC2 precisará para ser criada.

### 📂 Módulo de Computação (`/EC2`)
Focado no provisionamento e na configuração do servidor virtual.
*   📄 **`main.tf`**: Criação da instância EC2, Security Groups (regras de firewall) e associação com a rede da VPC.
*   📄 **`variables.tf`**: Parâmetros de hardware (ex: tipo de instância, nome da chave SSH).
*   📄 **`outputs.tf`**: Exporta dados da máquina (ex: ID da instância, IP público isolado).
*   📄 **`Nginx.sh`**: Script de *User Data* injetado no boot da EC2 para instalar e iniciar o Nginx de forma 100% automatizada.
*   📄 **`.terraform.lock.hcl`**: Garante o travamento das versões dos provedores locais específicos deste bloco.

---

## 🚀 Como Executar o Projeto

### Prerrequisitos

1. Ter o [Terraform](https://hashicorp.com) instalado.
2. Ter uma conta na AWS e o [AWS CLI](https://amazon.com) configurado com suas credenciais de acesso (`aws configure`).

### Passo a Passo

**1. Clone o repositório:**
```bash
git clone https://gitlab.com/edina25-group/pequena-aplicacao-web-na-aws.git
cd pequena-aplicacao-web-na-aws
```

**2. Inicialize o ambiente do Terraform:**
Este comando deve ser executado no diretório raiz para baixar os provedores da AWS.
```bash
terraform init
```

**3. Valide e planeje a infraestrutura:**
Confira o planejamento do que o Terraform vai criar na sua conta AWS antes de aplicar as mudanças:
```bash
terraform plan
```

**4. Aplique as configurações (Deploy):**
Provisione a infraestrutura completa. Digite `yes` para confirmar quando solicitado no terminal.
```bash
terraform apply
```

**5. Destruir os recursos (Opcional):**
Caso precise encerrar o laboratório e queira remover tudo o que foi criado para evitar custos na AWS:
```bash
terraform destroy
```

---

## 👥 Autores e Agradecimentos

*   **Edina Prado** - *DevOps Engineer*


