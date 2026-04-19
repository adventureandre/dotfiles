# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Caminho do Oh My Zsh
export ZSH="$HOME/.oh-my-zsh"

# Tema Powerlevel10k
ZSH_THEME="powerlevel10k/powerlevel10k"

# Plugins
plugins=(
  git
  zsh-autosuggestions
  zsh-syntax-highlighting
  extract
  docker
  docker-compose
  npm
  node
  bun
  sudo
  history
  colored-man-pages
  kubectl
  kubectx
)

# Carrega o Oh My Zsh
source $ZSH/oh-my-zsh.sh

# Carrega Powerlevel10k se existir
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Configuração do autosuggestions
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=8"
ZSH_AUTOSUGGEST_STRATEGY=(history completion)
ZSH_AUTOSUGGEST_USE_ASYNC=true

# Navegação com setas ↑ ↓ baseada no histórico
bindkey '^[[A' history-search-backward
bindkey '^[[B' history-search-forward

# Editor padrão
export EDITOR='nvim'

# Homebrew
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

# Caminho extra se necessário
export PATH="$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH"

# Linguagem
export LANG=pt_BR.UTF-8

export JAVA_HOME=~/.jdks/ms-21.0.10
export PATH="$JAVA_HOME/bin:$PATH"

# bun completions
[ -s "/home/andre-luiz/.bun/_bun" ] && source "/home/andre-luiz/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

export NVM_DIR="$HOME/.nvm"
[ -s "/home/linuxbrew/.linuxbrew/opt/nvm/nvm.sh" ] && \. "/home/linuxbrew/.linuxbrew/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/home/linuxbrew/.linuxbrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/home/linuxbrew/.linuxbrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

# --- Ferramentas turbinadas ---

# thefuck - corretor de comandos (digite "fuck" pra corrigir o último comando errado)
eval $(thefuck --alias)

# atuin - histórico de comandos inteligente
eval "$(atuin init zsh)"

# fzf - busca fuzzy (Ctrl+R = histórico, Ctrl+T = arquivos, Alt+C = diretórios)
source <(fzf --zsh)

# zoxide - cd inteligente (use "z pasta" em vez de "cd /caminho/longo/pasta")
eval "$(zoxide init zsh)"

# Aliases úteis
alias ls="eza --group-directories-first"
alias ll="eza -la --group-directories-first --git"
alias lt="eza --tree --level=2"
alias cat="bat --style=auto"
alias find="fd"
