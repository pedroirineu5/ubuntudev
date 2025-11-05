# 🚀 Guia Completo de Configuração do Ambiente de Desenvolvimento

## 📋 Sobre este Projeto

Este é um script automatizado para configurar um ambiente de desenvolvimento completo no **Debian 13**, incluindo todas as ferramentas necessárias para desenvolvimento **Backend (Python/Django)** e **Frontend (JavaScript/Node.js)**.

---

## 🎯 O que será instalado?

### 🐍 Backend (Python/Django)
- **Python 3** - Linguagem de programação
- **pip** - Gerenciador de pacotes Python
- **virtualenv** - Ambientes virtuais Python
- **Django** - Framework web
- **Django REST Framework** - API REST
- **PostgreSQL** - Banco de dados relacional
- Bibliotecas essenciais: `python-decouple`, `pillow`, `psycopg2-binary`, `django-cors-headers`
- Ferramentas de desenvolvimento: `black`, `flake8`, `pytest`

### 🟢 Frontend (JavaScript/Node.js)
- **Node.js LTS** - Runtime JavaScript
- **NPM** - Gerenciador de pacotes Node
- **Yarn** - Gerenciador de pacotes alternativo (opcional)
- **TypeScript** - Superset tipado do JavaScript (opcional)
- Ferramentas: `nodemon`, `eslint`, `prettier` (opcional)

### 🛠️ Ferramentas de Desenvolvimento
- **Git** - Controle de versão
- **Docker** - Containerização
- **Docker Compose** - Orquestração de containers
- **VS Code** - Editor de código
- **Postman** - Teste de APIs
- **Insomnia** - Teste de APIs alternativo

### 🌐 Navegadores
- **Google Chrome** - Navegador web
- **Chromium** - Versão open source do Chrome

### 💬 Comunicação
- **Discord** - Comunicação para desenvolvedores

---

## 📦 Pré-requisitos

### Sistema Operacional
- **Debian 13** (recém instalado)
- Acesso à internet
- Privilégios de administrador (sudo)

### Antes de começar
Certifique-se de que você tem:
1. ✅ Conexão estável com a internet
2. ✅ Senha de administrador (sudo)
3. ✅ Pelo menos **10 GB de espaço livre** no disco

---

## 🚀 Guia de Instalação (Passo a Passo)

### Passo 1️⃣: Atualizar o Sistema (IMPORTANTE!)

Após formatar o Debian 13, a primeira coisa a fazer é atualizar o sistema:

```bash
sudo apt update
sudo apt upgrade -y
```

**Por que fazer isso?**
- Atualiza a lista de pacotes disponíveis
- Instala as últimas atualizações de segurança
- Garante compatibilidade com os softwares que serão instalados

---

### Passo 2️⃣: Instalar o Git

O Git é necessário para clonar este repositório:

```bash
sudo apt install -y git
```

Verifique se foi instalado corretamente:

```bash
git --version
```

---

### Passo 3️⃣: Clonar este Repositório

Navegue até a pasta onde deseja salvar os scripts (por exemplo, Documentos):

```bash
cd ~/Documentos
```

Clone este repositório:

```bash
git clone https://github.com/seu-usuario/ambiente_dev.git
cd ambiente_dev
```

**OU** se você já tem os arquivos localmente, apenas navegue até a pasta:

```bash
cd ~/Documentos/ambiente_dev
```

---

### Passo 4️⃣: Dar Permissão de Execução ao Script

Antes de executar, o script precisa de permissão de execução:

```bash
chmod +x env_config.sh
```

**O que isso faz?**
- `chmod` = Change Mode (mudar permissões)
- `+x` = Adiciona permissão de execução
- Permite que o arquivo seja executado como um programa

---

### Passo 5️⃣: Executar o Script

Agora execute o script:

```bash
./env_config.sh
```

**Durante a execução:**
- ⏱️ O script pode levar de **15 a 40 minutos** dependendo da velocidade da internet
- 🔐 Você precisará digitar sua senha de sudo algumas vezes
- ❓ Algumas instalações pedirão confirmação (responda `s` para sim ou `n` para não)
- 📊 O progresso será exibido com cores:
  - 🔵 **AZUL** = Informação
  - 🟢 **VERDE** = Sucesso
  - 🟡 **AMARELO** = Aviso
  - 🔴 **VERMELHO** = Erro

---

### Passo 6️⃣: Reiniciar o Sistema (IMPORTANTE!)

Após a instalação, **REINICIE** o computador para aplicar todas as configurações:

```bash
sudo reboot
```

**Por que reiniciar?**
- Aplicar permissões do Docker
- Carregar novos serviços
- Atualizar variáveis de ambiente

---
