<div align="center">

# ☁️ Pequena Aplicação Web na AWS

**Uma aplicação web leve, hospedada na infraestrutura da AWS**

![Status](https://img.shields.io/badge/status-em%20desenvolvimento-yellow)
![AWS](https://img.shields.io/badge/cloud-AWS-orange?logo=amazon-aws)
![License](https://img.shields.io/badge/licença-MIT-blue)

[Sobre](#-sobre-o-projeto) •
[Arquitetura](#️-arquitetura) •
[Instalação](#-instalação) •
[Uso](#️-uso) •
[Deploy](#-deploy-na-aws) •
[Contribuindo](#-contribuindo) •
[Equipe](#-autores-e-agradecimentos)

</div>

---

## 📖 Sobre o Projeto

Este repositório contém o código-fonte de uma **pequena aplicação web** desenvolvida como parte do grupo **edina25-group**, com foco em explorar conceitos de hospedagem e implantação de aplicações na **Amazon Web Services (AWS)**.

> ✏️ *Personalize esta seção com uma descrição específica: qual problema a aplicação resolve, quem é o público-alvo e o que a torna única.*

### ✨ Funcionalidades

- ✅ Funcionalidade 1
- ✅ Funcionalidade 2
- ✅ Funcionalidade 3

---

## 🖼️ Visuais

<div align="center">

*Adicione aqui screenshots, GIFs ou um vídeo curto demonstrando a aplicação em funcionamento.*

</div>

---

## 🏗️ Arquitetura

| Camada | Tecnologia |
|---|---|
| Frontend | *ex: HTML/CSS/JS, React* |
| Backend | *ex: Node.js, Python (Flask/Django)* |
| Banco de Dados | *ex: DynamoDB, RDS* |
| Hospedagem | *ex: EC2, S3 + CloudFront, Elastic Beanstalk* |
| CI/CD | GitLab CI/CD |

---

## 🧰 Requisitos

Antes de começar, você vai precisar ter instalado:

- [Git](https://git-scm.com/)
- *[Node.js / Python / outra runtime]*
- Uma conta ativa na **AWS**
- AWS CLI configurada (`aws configure`)

---

## 🚀 Instalação

Clone o repositório e configure o ambiente local:

```bash
git clone https://gitlab.com/edina25-group/pequena-aplicacao-web-na-aws.git
cd pequena-aplicacao-web-na-aws
```

Instale as dependências:

```bash
# exemplo
npm install
```

---

## ▶️ Uso

Para rodar o projeto localmente:

```bash
# exemplo
npm start
```

A aplicação estará disponível em `http://localhost:3000`.

---

## ☁️ Deploy na AWS

Este projeto utiliza o pipeline de **CI/CD do GitLab** para automatizar o processo de implantação.

1. Configure as variáveis de ambiente/segredos da AWS no GitLab (**Settings > CI/CD > Variables**).
2. Cada push para a branch `main` aciona o pipeline definido em `.gitlab-ci.yml`.
3. O deploy pode ser feito via:
   - **Amazon EC2**
   - **Amazon ECS**
   - **AWS Elastic Beanstalk**
   - **S3 + CloudFront** (para sites estáticos)

> 🔒 Lembre-se de usar **ambientes protegidos** e escaneamento de segurança (**SAST**) antes de promover para produção.

---

## 🗺️ Roadmap

- [ ] Implementar autenticação de usuários
- [ ] Adicionar testes automatizados
- [ ] Configurar monitoramento com CloudWatch
- [ ] Documentar API

---

## 🤝 Contribuindo

Contribuições são muito bem-vindas! Para contribuir:

1. Faça um **fork** do projeto
2. Crie uma branch para sua feature (`git checkout -b feature/minha-feature`)
3. Faça commit das suas alterações (`git commit -m 'Adiciona minha feature'`)
4. Envie para a branch (`git push origin feature/minha-feature`)
5. Abra um **Merge Request**

Antes de enviar, rode os testes e o linter localmente.

---

## 💬 Suporte

Encontrou um problema ou tem uma dúvida?

- Abra uma [issue](https://gitlab.com/edina25-group/pequena-aplicacao-web-na-aws/-/issues)
- Entre em contato com a equipe do **edina25-group**

---

## 👥 Autores e Agradecimentos

Desenvolvido com 💙 pela equipe **edina25-group**.

---

## 📄 Licença

Distribuído sob a licença **MIT**. Veja `LICENSE` para mais informações.

---

## 📌 Status do Projeto

🟡 **Em desenvolvimento ativo**
