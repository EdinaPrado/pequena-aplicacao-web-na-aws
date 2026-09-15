# ☁️ Pequena Aplicação Web na AWS

Uma infraestrutura como código (IaC) leve, modular e automatizada utilizando **Terraform** para provisionar recursos na **Amazon Web Services (AWS)**.

---

## 📋 Descrição do Projeto

Este projeto automatiza a criação de um ambiente seguro e escalável na AWS para hospedar uma aplicação web simples. A infraestrutura foi totalmente dividida em arquivos de configuração do Terraform (`.tf`) para garantir boas práticas de organização, reusabilidade e fácil manutenção.

---

## 🛠️ Tecnologias Utilizadas

*   **Terraform** (v1.0.0+) - Ferramenta de Infraestrutura como Código.
*   **AWS Cloud** - Provedor de nuvem utilizado para hospedar a infraestrutura.

---

## 🗂️ Estrutura de Arquivos do Terraform

O projeto está organizado da seguinte forma:

*   📂 **`main.tf`**: O arquivo principal que contém a definição dos recursos (ex: Instâncias EC2, VPC, Security Groups).
*   📂 **`variables.tf`**: Definição das variáveis de entrada para parametrizar a infraestrutura (ex: região da AWS, tipo de instância, chaves SSH).
*   📂 **`data.tf`**: Utilizado para buscar dados dinâmicos da AWS que já existem ou mudam constantemente (ex: buscar a AMI do Ubuntu mais recente).
*   📂 **`outputs.tf`**: Define as informações que serão exibidas no terminal após a execução do Terraform (ex: o IP público do servidor web).
*   📂 **`.gitignore`**: Configurado para ignorar arquivos locais de estado do Terraform (`.tfstate`) e credenciais sensíveis.

---

## 🚀 Como Executar o Projeto

### Prerrequisitos

1. Ter o [Terraform](https://hashicorp.com) instalado em sua máquina.
2. Ter uma conta na AWS e o [AWS CLI](https://amazon.com) configurado com suas credenciais (`aws configure`).

### Passo a Passo

**1. Clone o repositório:**
```bash
git clone https://gitlab.com/edina25-group/pequena-aplicacao-web-na-aws.git
cd pequena-aplicacao-web-na-aws
```

**2. Inicialize o Terraform:**
Este comando baixa os provedores necessários (AWS) e inicializa o ambiente de trabalho.
```bash
terraform init
```

**3. Verifique o plano de execução:**
Antes de criar qualquer recurso na nuvem, visualize o que o Terraform planeja fazer:
```bash
terraform plan
```

**4. Aplique as mudanças:**
Crie a infraestrutura na AWS. Confirme digitando `yes` quando solicitado.
```bash
terraform apply
```

**5. Destruir a infraestrutura (Opcional):**
Caso queira remover todos os recursos criados para evitar cobranças na AWS:
```bash
terraform destroy
```

---

## 👥 Autores e Agradecimentos

*   **Edina Prado** - *Desenvolvedora Principal / DevOps Engineer*

