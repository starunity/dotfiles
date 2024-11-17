# Create .proxy.zsh

if [[ ! -e ${HOME}/.proxy.zsh ]]; then
  echo -n "Please input proxy URL (default: http://127.0.0.1:7890): "
  read PROXY_URL

  if [[ "${PROXY_URL}" == "" ]]; then
    PROXY_URL="http://127.0.0.1:7890"
  fi


  while (( 1 )) {
    echo "Choose proxy method:"
    echo "1. No proxy (default)"
    echo "2. Proxy only when installing the plugin in ZSH"
    echo "3. Always proxy"
    echo -n "==> "
    read PROXY_METHOD

    if [[ "${PROXY_METHOD}" == "" ]]; then
      PROXY_METHOD=1
    fi

    if (( $PROXY_METHOD >= 1 && $PROXY_METHOD <= 3 )); then
      break
    fi

    echo "Please enter the correct value"
  }


  cat > ${HOME}/.proxy.zsh << EOF
# Generated by starunity's zsh config

function pron() {
  export http_proxy=${PROXY_URL}
  export https_proxy=${PROXY_URL}
}

function proff() {
  unset http_proxy
  unset https_proxy
}

function procfg() {
  command rm ${HOME}/.proxy.zsh; source ${HOME}/.zshrc
}

# 1. No proxy (default)
# 2. Proxy only when installing the plugin in ZSH
# 3. Always proxy
export PROXY_METHOD=${PROXY_METHOD}
EOF
fi

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
export PATH="${HOME}/.local/bin:${PATH}"

# fpath
fpath+=~/.zfunc

# require .proxy.zsh
source ${HOME}/.proxy.zsh


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
zstyle ':zim:input' double-dot-expand yes

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

# Disable automatic widget re-binding on each precmd. This can be set when
# zsh-users/zsh-autosuggestions is the last module in your ~/.zimrc.
ZSH_AUTOSUGGEST_MANUAL_REBIND=1

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

# Enable proxy if PROXY_METHOD=2/3 at installing plugins
if (( $PROXY_METHOD == 2 || $PROXY_METHOD == 3)); then
  pron
fi

# fzf
if [[ ! -e ${HOME}/.fzf.zsh ]] && (( ! ${+commands[fzf]} )); then
  command git clone --depth 1 https://github.com/junegunn/fzf.git ${HOME}/.fzf
  command bash ${HOME}/.fzf/install
fi

ZIM_HOME=${ZDOTDIR:-${HOME}}/.zim
# Download zimfw plugin manager if missing.
if [[ ! -e ${ZIM_HOME}/zimfw.zsh ]]; then
  if (( ${+commands[curl]} )); then
    curl -fsSL --create-dirs -o ${ZIM_HOME}/zimfw.zsh \
        https://github.com/zimfw/zimfw/releases/latest/download/zimfw.zsh
  else
    mkdir -p ${ZIM_HOME} && wget -nv -O ${ZIM_HOME}/zimfw.zsh \
        https://github.com/zimfw/zimfw/releases/latest/download/zimfw.zsh
  fi
fi
# Install missing modules, and update ${ZIM_HOME}/init.zsh if missing or outdated.
if [[ ! ${ZIM_HOME}/init.zsh -nt ${ZDOTDIR:-${HOME}}/.zimrc ]]; then
  source ${ZIM_HOME}/zimfw.zsh init -q
fi
# Initialize modules.
source ${ZIM_HOME}/init.zsh


# Disable Proxy
if (( $PROXY_METHOD == 2 )); then
  proff
fi

# ------------------------------
# Post-init module configuration
# ------------------------------

#
# Alias
#

# color alias
alias grep='grep --color=auto'
alias diff='diff --color=auto'
alias ip='ip --color=auto'
alias pacman='sudo pacman --color=auto'
alias yay='yay --color=auto'

# alias

alias -- -='cd -'
alias 1='cd -0'
alias 2='cd -1'
alias 3='cd -2'
alias 4='cd -3'
alias 5='cd -4'
alias 6='cd -5'
alias 7='cd -6'
alias 8='cd -7'
alias 9='cd -8'
alias d='dirs -p | tac | head -n 10 | cat -n'

alias tree='eza --tree'
alias nf='neofetch | lolcat --seed=19'

#
# Extensions
#

# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# zoxide
eval "$(zoxide init zsh)"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
