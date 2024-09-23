# Lazy script enviroment

Isso é um pequeno script para automatizar a chatice que é configurar um ambiente de desenvolvimento em sistemas linux. Sinta-se à vontade para fazer um **fork** desse script, para customiza-lo à vontade. Isso é apenas para sistemas baseados no **debian/ubuntu** 

## O que esse script está fazendo?

- Atualiza os pacotes do sistema.
- Instala pacotes essenciais (compiladores, Git, etc.).
- Instala Node.js e npm usando o nvm.
- Instala o Java com seu kit de desenvolvimento.
- Instala o Python 3 e o pip.
- Instala o VSCode.
- Instala o neovim.
- Instala o spotify.
- Instala e configura o Zsh com o Oh My Zsh.

<hr>

### Guia de solução de problemas/ Troubleshooting guide

Caso esteja enfrentando problemas para rodar o script em seu ambiente. Faça o seguinte:

```bash
chmod +x setup_dev_env.sh
```

Esse comando vai permitir que você execute esse script como um executável.

```bash
./lazy_script_env.sh
```
Caso ainda dê problema, jogue o script para a pasta HOME `~/` e tente roda-lo novamente.
