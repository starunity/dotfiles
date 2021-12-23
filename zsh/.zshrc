# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

#
# Environment variables
#

# PATH
export PATH="/home/star/.local/bin:$PATH"

# fpath
fpath+=~/.zfunc


#
# Proxy
#

#alias pron='export ALL_PROXY=socks5://127.0.0.1:7891'
#alias proff='unset ALL_PROXY'

function pron() {
  export http_proxy=http://127.0.0.1:7890
  export https_proxy=http://127.0.0.1:7890
}

function proff() {
  unset http_proxy
  unset https_proxy
}

#
# History
#

# Remove older command from the history if a duplicate is to be added.
setopt HIST_IGNORE_ALL_DUPS

#
# Input/output
#

# Set editor default keymap to emacs (`-e`) or vi (`-v`)
bindkey -e

# Prompt for spelling correction of commands.
#setopt CORRECT

# Customize spelling correction prompt.
#SPROMPT='zsh: correct %F{red}%R%f to %F{green}%r%f [nyae]? '

# Remove path separator from WORDCHARS.
WORDCHARS=${WORDCHARS//[\/]}

# -----------------
# Zim configuration
# -----------------

# Use degit instead of git as the default tool to install and update modules.
zstyle ':zim:zmodule' use 'degit'

# --------------------
# Module configuration
# --------------------

#
# completion
#

# Set a custom path for the completion dump file.
# If none is provided, the default ${ZDOTDIR:-${HOME}}/.zcompdump is used.
#zstyle ':zim:completion' dumpfile "${ZDOTDIR:-${HOME}}/.zcompdump-${ZSH_VERSION}"

#
# input
#

# Append `../` to your input for each `.` you type after an initial `..`
#zstyle ':zim:input' double-dot-expand yes

#
# termtitle
#

# Set a custom terminal title format using prompt expansion escape sequences.
# See http://zsh.sourceforge.net/Doc/Release/Prompt-Expansion.html#Simple-Prompt-Escapes
# If none is provided, the default '%n@%m: %~' is used.
#zstyle ':zim:termtitle' format '%1~'

#
# zsh-autosuggestions
#

# Customize the style that the suggestions are shown with.
# See https://github.com/zsh-users/zsh-autosuggestions/blob/master/README.md#suggestion-highlight-style
#ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=242'

#
# zsh-syntax-highlighting
#

# Set what highlighters will be used.
# See https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/docs/highlighters.md
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets)

# Customize the main highlighter styles.
# See https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/docs/highlighters/main.md#how-to-tweak-it
#typeset -A ZSH_HIGHLIGHT_STYLES
#ZSH_HIGHLIGHT_STYLES[comment]='fg=242'

# ------------------
# Initialize modules
# ------------------

# Enable Proxy
#pron

# Automatic installation of command line tools

# zoxide
if (( ! ${+commands[zoxide]} )); then
  command curl -sS https://webinstall.dev/zoxide | bash
fi

# bat
if (( ! ${+commands[bat]} )); then
  command curl -sS https://webinstall.dev/bat | bash
fi

# fd
if (( ! ${+commands[fd]} )); then
  command curl -sS https://webinstall.dev/fd | bash
fi

# Ripgrep
if (( ! ${+commands[rg]} )); then
  command curl -sS https://webinstall.dev/rg | bash
fi

# fzf
if [[ ! -e ${HOME}/.fzf ]] && (( ! ${+commands[fzf]} )); then
  command git clone --depth 1 https://github.com/junegunn/fzf.git ${HOME}/.fzf
  command bash ${HOME}/.fzf/install
fi

# exa
if (( ! ${+commands[exa]} )); then
  EXA_VERSION=$(curl -sSL https://api.github.com/repos/ogham/exa/releases/latest | grep 'tag_name' | sed -r 's/.*"tag_name".*"(.*)",.*/\1/')
  EXA_SYSTEM=$(uname)
  EXA_ARCH=$(uname -m)

  STARUNITY_ZSH_CACHE="${HOME}/.cache/starunity-zsh"
  command mkdir -p ${STARUNITY_ZSH_CACHE}

  if [[ "${EXA_SYSTEM}" == "Linux" ]] && [[ "${EXA_ARCH}" == "x86_64" ]]; then
    command curl -fsSL -o ${STARUNITY_ZSH_CACHE}/exa.zip https://github.com/ogham/exa/releases/download/${EXA_VERSION}/exa-linux-x86_64-${EXA_VERSION}.zip
  elif [[ "${EXA_SYSTEM}" == "Linux" ]] && [[ "${EXA_ARCH}" == "armv7" ]]; then
    command curl -fsSL -o ${STARUNITY_ZSH_CACHE}/exa.zip https://github.com/ogham/exa/releases/download/${EXA_VERSION}/exa-linux-armv7-${EXA_VERSION}.zip
  elif [[ "${EXA_SYSTEM}" == "Darwin" ]] && [[ "${EXA_ARCH}" == "x86_64" ]]; then
    command curl -fsSL -o ${STARUNITY_ZSH_CACHE}/exa.zip https://github.com/ogham/exa/releases/download/${EXA_VERSION}/exa-macos-x86_64-${EXA_VERSION}.zip
  fi

  if [[ -e ${STARUNITY_ZSH_CACHE}/exa.zip ]]; then
    command mkdir -p ${STARUNITY_ZSH_CACHE}/exa
    command unzip -d ${STARUNITY_ZSH_CACHE}/exa ${STARUNITY_ZSH_CACHE}/exa.zip
    command install -Dm755 ${STARUNITY_ZSH_CACHE}/exa/bin/exa ${HOME}/.local/bin/exa
    command install -Dm644 ${STARUNITY_ZSH_CACHE}/exa/completions/exa.zsh ${HOME}/.zfunc/_exa
    command rm -rf ${STARUNITY_ZSH_CACHE}
  fi
fi

if [[ ! -e ${ZIM_HOME}/zimfw.zsh ]]; then
  # Download zimfw script if missing.
  command mkdir -p ${ZIM_HOME}
  if (( ${+commands[curl]} )); then
    command curl -fsSL -o ${ZIM_HOME}/zimfw.zsh https://github.com/zimfw/zimfw/releases/latest/download/zimfw.zsh
  else
    command wget -nv -O ${ZIM_HOME}/zimfw.zsh https://github.com/zimfw/zimfw/releases/latest/download/zimfw.zsh
  fi
fi
if [[ ! ${ZIM_HOME}/init.zsh -nt ${ZDOTDIR:-${HOME}}/.zimrc ]]; then
  # Install missing modules, and update ${ZIM_HOME}/init.zsh if missing or outdated.
  source ${ZIM_HOME}/zimfw.zsh init -q
fi
source ${ZIM_HOME}/init.zsh

# Disable Proxy
#proff

# ------------------------------
# Post-init module configuration
# ------------------------------

#
# zsh-history-substring-search
#

# Bind ^[[A/^[[B manually so up/down works both before and after zle-line-init
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

# Bind up and down keys
zmodload -F zsh/terminfo +p:terminfo
if [[ -n ${terminfo[kcuu1]} && -n ${terminfo[kcud1]} ]]; then
  bindkey ${terminfo[kcuu1]} history-substring-search-up
  bindkey ${terminfo[kcud1]} history-substring-search-down
fi

bindkey '^P' history-substring-search-up
bindkey '^N' history-substring-search-down
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down

#
# Alias
#

# color alias
alias rm='rm -i'
alias grep='grep --color=auto'
alias diff='diff --color=auto'
alias ip='ip --color=auto'
alias pacman='pacman --color=auto'
alias yay='yay --color=auto'

# alias
alias cat='bat'
alias ccat='/bin/cat'
alias tree='exa --tree'
#alias vim='nvim'
alias nf='neofetch | lolcat --seed=19'
alias pacman='sudo pacman'
alias wgon='sudo systemctl restart wg-quick@star-laptop.service'
alias wgoff='sudo systemctl stop wg-quick@star-laptop.service'
alias o='xdg-open'

#
# Extensions
#

# NeoVim host python3 path
export PYTHON3_HOST_PROG="/usr/bin/python3"

# zoxide
eval "$(zoxide init zsh)"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Generated for envman. Do not edit.
[ -s "$HOME/.config/envman/load.sh" ] && source "$HOME/.config/envman/load.sh"

