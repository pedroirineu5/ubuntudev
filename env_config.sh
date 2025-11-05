#!/bin/bash

# Script de Configuração de Ambiente de Desenvolvimento baseado no antigo script feito por Alexandre
# Backend: Python/Django
# Autor: Pedro Irineu :D 
# Data: 05/11/2025

set -e  # Interrompe o script em caso de erro

# Cores para output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Função para imprimir mensagens coloridas
print_info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[✓]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[!]${NC} $1"
}

print_error() {
    echo -e "${RED}[✗]${NC} $1"
}

print_section() {
    echo ""
    echo -e "${CYAN}════════════════════════════════════════${NC}"
    echo -e "${CYAN}  $1${NC}"
    echo -e "${CYAN}════════════════════════════════════════${NC}"
    echo ""
}

# ============================================
# ATUALIZAÇÃO DO SISTEMA
# ============================================
print_section "🔄 Atualizando Sistema"
print_info "Atualizando lista de pacotes..."
sudo apt update
print_info "Atualizando pacotes instalados..."
sudo apt upgrade -y
print_success "Sistema atualizado!"

# ============================================
# DEPENDÊNCIAS BÁSICAS
# ============================================
print_section "📦 Instalando Dependências Básicas"

# Build essentials
if dpkg -l | grep -q build-essential; then
    print_success "build-essential já está instalado"
else
    print_info "Instalando build-essential..."
    sudo apt install -y build-essential
    print_success "build-essential instalado!"
fi

# Ferramentas essenciais
BASIC_TOOLS=("curl" "wget" "git" "gnupg" "lsb-release" "apt-transport-https" "ca-certificates")

for tool in "${BASIC_TOOLS[@]}"; do
    if command -v $tool &> /dev/null || dpkg -l | grep -q "^ii  $tool"; then
        print_success "$tool já está instalado"
    else
        print_info "Instalando $tool..."
        sudo apt install -y $tool
        print_success "$tool instalado!"
    fi
done

# ============================================
# SSH SERVER
# ============================================
print_section "🔐 Configurando Servidor SSH"

if systemctl is-active --quiet ssh || systemctl is-active --quiet sshd; then
    print_success "SSH já está instalado e ativo"
else
    print_info "Instalando OpenSSH Server..."
    sudo apt install -y openssh-server
    sudo systemctl enable --now ssh
    print_success "SSH instalado e ativado!"
fi

# ============================================
# SNAPD
# ============================================
print_section "🛠️  Configurando Snapd"

if command -v snap &> /dev/null; then
    print_success "Snapd já está instalado"
else
    print_info "Instalando snapd..."
    sudo apt install -y snapd
    sudo systemctl enable --now snapd.socket
    sudo ln -sf /var/lib/snapd/snap /snap
    print_success "Snapd instalado!"
fi

# ============================================
# PYTHON E DJANGO (BACKEND)
# ============================================
print_section "🐍 Configurando Python/Django"

# Python 3
if command -v python3 &> /dev/null; then
    PYTHON_VERSION=$(python3 --version)
    print_success "Python já instalado: $PYTHON_VERSION"
else
    print_info "Instalando Python3..."
    sudo apt install -y python3
    print_success "Python3 instalado!"
fi

# Python pip
if command -v pip3 &> /dev/null; then
    PIP_VERSION=$(pip3 --version | cut -d' ' -f2)
    print_success "Pip já instalado: versão $PIP_VERSION"
else
    print_info "Instalando pip3..."
    sudo apt install -y python3-pip
    print_success "Pip3 instalado!"
fi

# Python venv
if dpkg -l | grep -q python3-venv; then
    print_success "python3-venv já está instalado"
else
    print_info "Instalando python3-venv..."
    sudo apt install -y python3-venv
    print_success "python3-venv instalado!"
fi

# Dependências Python para desenvolvimento
print_info "Verificando dependências de desenvolvimento Python..."
PYTHON_DEV_DEPS=("python3-dev" "libpq-dev" "libssl-dev" "libffi-dev")

for dep in "${PYTHON_DEV_DEPS[@]}"; do
    if dpkg -l | grep -q "^ii  $dep"; then
        print_success "$dep já está instalado"
    else
        print_info "Instalando $dep..."
        sudo apt install -y $dep
        print_success "$dep instalado!"
    fi
done

# ============================================
# NAVEGADORES
# ============================================
print_section "🌐 Instalando Navegadores"

# Google Chrome
if command -v google-chrome &> /dev/null; then
    CHROME_VERSION=$(google-chrome --version)
    print_success "Google Chrome já instalado: $CHROME_VERSION"
else
    print_info "Instalando Google Chrome..."
    wget -q https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
    sudo apt install -y ./google-chrome-stable_current_amd64.deb
    rm google-chrome-stable_current_amd64.deb
    print_success "Google Chrome instalado!"
fi

# Chromium
if snap list 2>/dev/null | grep -q chromium; then
    print_success "Chromium já está instalado"
else
    print_info "Instalando Chromium..."
    sudo snap install chromium
    print_success "Chromium instalado!"
fi

# ============================================
# FERRAMENTAS DE COMUNICAÇÃO
# ============================================
print_section "💬 Instalando Ferramentas de Comunicação"

# Discord
if snap list 2>/dev/null | grep -q discord; then
    print_success "Discord já está instalado"
else
    print_info "Instalando Discord..."
    sudo snap install discord
    print_success "Discord instalado!"
fi

# ============================================
# EDITORES E IDEs
# ============================================
print_section "📝 Instalando Editores de Código"

# Visual Studio Code
if command -v code &> /dev/null; then
    CODE_VERSION=$(code --version | head -n1)
    print_success "VS Code já instalado: versão $CODE_VERSION"
else
    print_info "Instalando Visual Studio Code..."
    wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
    sudo install -o root -g root -m 644 microsoft.gpg /etc/apt/trusted.gpg.d/
    sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'
    rm microsoft.gpg
    sudo apt update
    sudo apt install -y code
    print_success "VS Code instalado!"
fi

# ============================================
# DOCKER
# ============================================
print_section "🐳 Configurando Docker"

# Docker
if command -v docker &> /dev/null; then
    DOCKER_VERSION=$(docker --version | cut -d' ' -f3 | tr -d ',')
    print_success "Docker já instalado: versão $DOCKER_VERSION"
    
    # Verificar se usuário está no grupo docker
    if groups $USER | grep -q docker; then
        print_success "Usuário já está no grupo docker"
    else
        print_info "Adicionando usuário ao grupo docker..."
        sudo usermod -aG docker $USER
        print_warning "Faça logout e login para aplicar permissões do Docker"
    fi
else
    print_info "Instalando Docker..."
    curl -fsSL https://get.docker.com -o get-docker.sh
    sudo sh get-docker.sh
    sudo usermod -aG docker $USER
    rm get-docker.sh
    print_success "Docker instalado!"
    print_warning "Faça logout e login para usar Docker sem sudo"
fi

# Docker Compose
if docker compose version &>/dev/null; then
    COMPOSE_VERSION=$(docker compose version --short)
    print_success "Docker Compose já instalado: versão $COMPOSE_VERSION"
else
    print_info "Instalando Docker Compose..."
    DOCKER_CONFIG=${DOCKER_CONFIG:-$HOME/.docker}
    mkdir -p $DOCKER_CONFIG/cli-plugins
    curl -SL https://github.com/docker/compose/releases/latest/download/docker-compose-linux-x86_64 -o $DOCKER_CONFIG/cli-plugins/docker-compose
    chmod +x $DOCKER_CONFIG/cli-plugins/docker-compose
    print_success "Docker Compose instalado!"
fi

# ============================================
# FERRAMENTAS DE API
# ============================================
print_section "🚀 Instalando Ferramentas de Teste de API"

# Postman
if snap list 2>/dev/null | grep -q postman; then
    print_success "Postman já está instalado"
else
    print_info "Instalando Postman..."
    sudo snap install postman
    print_success "Postman instalado!"
fi

# Insomnia
if snap list 2>/dev/null | grep -q insomnia; then
    print_success "Insomnia já está instalado"
else
    print_info "Instalando Insomnia..."
    sudo snap install insomnia
    print_success "Insomnia instalado!"
fi

print_section "📊 Resumo do Ambiente Instalado"

echo -e "${GREEN}╔════════════════════════════════════════╗${NC}"
echo -e "${GREEN}║     AMBIENTE DE DESENVOLVIMENTO        ║${NC}"
echo -e "${GREEN}╚════════════════════════════════════════╝${NC}"
echo ""
echo -e "██╗   ██╗███╗   ██╗██╗███████╗██╗██████╗ 
██║   ██║████╗  ██║██║██╔════╝██║██╔══██╗
██║   ██║██╔██╗ ██║██║█████╗  ██║██████╔╝
██║   ██║██║╚██╗██║██║██╔══╝  ██║██╔═══╝ 
╚██████╔╝██║ ╚████║██║██║     ██║██║     
 ╚═════╝ ╚═╝  ╚═══╝╚═╝╚═╝     ╚═╝╚═╝     "
echo ""
echo -e "${CYAN}BACKEND (Python/Django):${NC}"
echo "  • Python: $(python3 --version 2>&1)"
echo "  • Pip: $(pip3 --version 2>&1 | cut -d' ' -f1-2)"
if pip3 list 2>/dev/null | grep -q Django; then
    echo "  • Django: $(python3 -m django --version 2>&1)"
fi
if command -v psql &> /dev/null; then
    echo "  • PostgreSQL: $(psql --version 2>&1 | cut -d' ' -f3)"
fi
echo ""
echo -e "${CYAN}FERRAMENTAS:${NC}"
echo "  • Git: $(git --version 2>&1)"
if command -v docker &> /dev/null; then
    echo "  • Docker: $(docker --version 2>&1 | cut -d' ' -f3 | tr -d ',')"
fi
if docker compose version &>/dev/null; then
    echo "  • Docker Compose: v$(docker compose version --short 2>&1)"
fi
if command -v code &> /dev/null; then
    echo "  • VS Code: Instalado"
fi
echo ""

print_section "✅ Instalação Concluída!"
print_success "Ambiente de desenvolvimento configurado com sucesso!"
print_info "Execute 'cat ambiente_info.txt' para ver o resumo completo"

if groups $USER | grep -q docker; then
    print_info "Tudo pronto! Você pode começar a desenvolver!"
else
    print_warning "IMPORTANTE: Faça logout e login novamente para usar Docker sem sudo"
fi
