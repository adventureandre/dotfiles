#!/bin/bash

set -e

echo "========================================="
echo "  Instalando dotfiles - André Luiz"
echo "========================================="

# Cores
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

log() { echo -e "${GREEN}[+]${NC} $1"; }
warn() { echo -e "${YELLOW}[!]${NC} $1"; }

DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"

# 1. Instalar Zsh
if ! command -v zsh &>/dev/null; then
    log "Instalando Zsh..."
    sudo apt update && sudo apt install -y zsh
    chsh -s $(which zsh)
else
    log "Zsh já instalado"
fi

# 2. Instalar Oh My Zsh
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    log "Instalando Oh My Zsh..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
else
    log "Oh My Zsh já instalado"
fi

# 3. Instalar Powerlevel10k
if [ ! -d "$HOME/.oh-my-zsh/custom/themes/powerlevel10k" ]; then
    log "Instalando Powerlevel10k..."
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$HOME/.oh-my-zsh/custom/themes/powerlevel10k"
else
    log "Powerlevel10k já instalado"
fi

# 4. Instalar plugins do Zsh
ZSH_CUSTOM="$HOME/.oh-my-zsh/custom"

if [ ! -d "$ZSH_CUSTOM/plugins/zsh-autosuggestions" ]; then
    log "Instalando zsh-autosuggestions..."
    git clone https://github.com/zsh-users/zsh-autosuggestions "$ZSH_CUSTOM/plugins/zsh-autosuggestions"
else
    log "zsh-autosuggestions já instalado"
fi

if [ ! -d "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" ]; then
    log "Instalando zsh-syntax-highlighting..."
    git clone https://github.com/zsh-users/zsh-syntax-highlighting "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"
else
    log "zsh-syntax-highlighting já instalado"
fi

# 5. Instalar pacotes apt
log "Instalando pacotes apt..."
sudo apt update && sudo apt install -y \
    git \
    curl \
    zsh \
    kubectx

# 6. Instalar Homebrew
if ! command -v brew &>/dev/null; then
    log "Instalando Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
else
    log "Homebrew já instalado"
fi

# 7. Instalar ferramentas via Brew
log "Instalando ferramentas via Brew..."
brew install \
    bat \
    btop \
    eza \
    fd \
    fzf \
    gh \
    git-delta \
    kubernetes-cli \
    lazydocker \
    lazygit \
    nvm \
    pnpm \
    ripgrep \
    thefuck \
    tldr \
    atuin \
    zoxide

# 8. Linkar dotfiles
log "Linkando dotfiles..."

link_file() {
    local src="$1"
    local dest="$2"
    if [ -f "$dest" ]; then
        warn "Backup: $dest -> ${dest}.bak"
        mv "$dest" "${dest}.bak"
    fi
    ln -sf "$src" "$dest"
    log "Linkado: $dest"
}

link_file "$DOTFILES_DIR/.zshrc" "$HOME/.zshrc"
link_file "$DOTFILES_DIR/.p10k.zsh" "$HOME/.p10k.zsh"
link_file "$DOTFILES_DIR/.gitconfig" "$HOME/.gitconfig"

# 9. Atuin (login se já tiver conta)
if command -v atuin &>/dev/null; then
    warn "Para sincronizar histórico, rode: atuin login"
fi

echo ""
echo "========================================="
echo "  Instalação concluída!"
echo "  Reinicie o terminal ou rode: source ~/.zshrc"
echo "========================================="
