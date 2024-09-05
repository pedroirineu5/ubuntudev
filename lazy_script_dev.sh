#!/bin/bash

command_exists(){
    command -v "$1" &> /dev;null
}

sudo apt update && sudo apt upgrade -y

sudo apt install -y build-essential curl file git
sudo apt-get install wget gpg


# baixando um bom editor de texto

if ! command_exists code;
then

    wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
    sudo install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg
    echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" |sudo tee /etc/apt/sources.list.d/vscode.list > /dev/null
    rm -f packages.microsoft.gpg
    sudo apt install apt-transport-https
    sudo apt install code
fi

# Java de cria

if ! command_exists java; 
then
    sudo apt install -y openjdk-21-jdk
    echo "Java JDK 21 instalado com sucesso."
fi

# tentando usar o nvim para coisas rápidas na faculdade

if !command_exists nvim;
then
    sudo apt install neovim
fi


# pythonzinho de lei

if ! command_exists python3; then
    sudo apt install -y python3 python3-pip
    echo "Python3 e pip instalados."
fi

#Node e npm com nvm

if ! command_exists node; then
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash
        source ~/.bashrc
    nvm install --lts
    echo "Node.js e npm instalados."
fi

# baixando o SPOTIFY, MY SPECIAL :)

if ! command_exists spotify;
then
    curl -sS https://download.spotify.com/debian/pubkey_6224F9941A8AA6D1.gpg | sudo gpg --dearmor --yes -o /etc/apt/trusted.gpg.d/spotify.gpg
    echo "deb http://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list
    sudo apt-get update && sudo apt-get install spotify-client
fi


if ! command_exists zsh;
then 
    sudo apt install -y zsh
    chsh -s $(which zsh)
    echo "Zsh instalado e configurado no shell por padrão."
fi

if [ ! -d "$HOME/.oh-my-zsh" ]; 
then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi
