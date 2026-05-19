# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time Oh My Zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="powerlevel10k/powerlevel10k"

# Uncomment the following line to use case-sensitive completion.
CASE_SENSITIVE="false"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
HYPHEN_INSENSITIVE="true"

# Which plugins would you like to load?
# Add wisely, as too many plugins slow down shell startup.
plugins=(git zsh-autosuggestions sudo web-search copyfile jsontools zsh-syntax-highlighting vi-mode fzf)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi

# Compilation flags
# export ARCHFLAGS="-arch $(uname -m)"

# ZSH autocompletion
autoload -Uz compinit
compinit

bindkey -v
zstyle ':completion:*' verbose yes
zstyle ':completion:*:descriptions' format '%B%d%b'
zstyle ':completion:*' menu select

# Vim style movement in menu
bindkey -M menuselect 'h' backward-char
bindkey -M menuselect 'j' down-line-or-history
bindkey -M menuselect 'k' up-line-or-history
bindkey -M menuselect 'l' forward-char

# Aliases
# Set personal Aliases, overriding those provided by Oh My Zsh libs,
# ---- Eza (better ls) -----
alias ls="eza --icons=always"
alias ll="eza -alh"
alias tree="eza --tree"
# ---- Zoxide (better cd) ----
eval "$(zoxide init zsh)"
alias cd="z"
alias zz="z -"
# ---- bat (better cat) ----
alias cat="bat --color=always --plain --wrap character -n"
# for nvim 
alias vim="nvim"
alias nv="nvim ."
# for interactive neovim using fzf
alias inv='nvim $(fzf)'
# for lazydocker
alias lzd='lazydocker'
# for lazygit
alias lg='lazygit'
# alias for clear screen
alias c='clear'
# tmux
alias ts='tmux switch-client -t'
alias disks='echo "╓───── m o u n t . p o i n t s";echo "╙────────────────────────────────────── ─ ─ ";lsblk -a;echo "";echo "╓───── d i s k . u s a g e";echo "╙────────────────────────────────────── ─ ─ ";df -h;'

# Docker
# containers
alias dstopall='docker stop $(docker ps -q)'
alias dps='docker ps'
alias dpsa='docker ps -a'
alias dstart='docker start'
alias dstop='docker stop'
alias drm='docker rm'
alias drmf='docker rm -f'
# images
alias di='docker images'
alias drmi='docker rmi'
alias drmif='docker rmi -f'
alias dlog='docker logs -f'
alias dexec='docker exec -it'
# volumes
alias dv='docker volume'
alias dvl='docker volume ls'
alias dvi='docker volume inspect'
alias dvrm='docker volume rm'
# compose
alias dc='docker compose'
alias dcu='docker compose up'
alias dcud='docker compose up -d'
alias dcd='docker compose down'
alias dcl='docker compose logs -f'
# cleanups
alias dprune='docker system prune -f'
alias dpruneall='docker system prune -a -f'
alias dvolprune='docker volume prune -f'
alias dvrmall='docker volume rm $(docker volume ls -q)'

alias e='$EDITOR'
alias se='sudo $EDITOR'
alias g="git"
alias 'cd..'='cd ../'
alias rm="rm -i"
alias rmi="rm -I"
alias rmrf="rm -ri"
alias rmri="rm -rI"
alias psef="ps -ef"
alias ZZ="exit"

# for git
alias ga="git add"
alias gb="git branch"
alias gc="git clone"
alias gcm="git commit -m"
alias glo="git log --oneline"
alias gco="git checkout"
alias gcob="git checkout -b"
alias gcs="git commit -S -m"
alias gd="git difftool"
alias gdc="git difftool --cached"
alias gf="git fetch"
alias gg="git graph"
alias ggg="git graphgpg"
alias gm="git merge"
alias gp="git push"
alias gpr="gh pr create"
alias gr="git rebase -i"
alias gs="git status -sb"
alias gt="git tag"
alias gu="git reset @ -- "
alias gx="git reset --hard @"
alias mkdir="mkdir -p"
alias cp="cp -r"
alias scp="scp -r"
alias vimdiff="nvim -d -u ~/.config/nvim/init.vim"
alias ag="ag --color --color-line-number '0;35' --color-match '46;30' --color-path '4;36'"
alias aga="ag --hidden --color --color-line-number '0;35' --color-match '46;30' --color-path '4;36'"
alias curlh="curl -sILX GET"
alias curld="curl -A \"Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/44.0.2403.157 Safari/537.36\""
alias curlm="curl -A \"Mozilla/5.0 (iPhone; CPU iPhone OS 6_1_3 like Mac OS X) AppleWebKit/536.26 (KHTML, like Gecko) CriOS/28.0.1500.12 Mobile/10B329 Safari/8536.25\""

# For API calls
# Eg: api GET https://api.example.com/users
# api POST https://api.example.com/users '{"name":"Prasses"}'
api() {
  if [[ $# -lt 2 ]]; then
    echo "Usage: api METHOD URL [DATA]"
    echo "Example GET:  api GET https://api.example.com/users"
    echo "Example POST: api POST https://api.example.com/users '{\"name\":\"Prasses\"}'"
    return 1
  fi

  local METHOD=$(echo "$1" | tr '[:lower:]' '[:upper:]')
  local URL="$2"
  local DATA="$3"

  if [[ "$METHOD" == "GET" ]]; then
    curl -v -X GET -H "Accept: application/json" -H "Content-Type: application/json" "$URL"
  elif [[ "$METHOD" == "POST" ]]; then
    curl -v -X POST -H "Accept: application/json" -H "Content-Type: application/json" -d "$DATA" "$URL"
  else
    echo "Unsupported method: $METHOD"
    return 1
  fi
}

# Yarn commands
alias yb="yarn build"
alias yd="yarn dev"

# Gradle commands
alias gsa="./gradlew spotlessApply"
alias gb="./gradlew clean build --refresh-dependencies"
alias grun="./gradlew bootRun --args='--spring.profiles.active=local --server.port=8080'"

# Poetry (FastAPI / Uvicorn)
alias prun="poetry run uvicorn app.main:app --reload --host 0.0.0.0 --port 8000"
alias uvirun="PYTHONPATH=$(pwd) uvicorn app.main:app  --reload"

export FUNCNEST=500

# for fzf
# use fd instead of the default find
# respect .gitignore
export FZF_DEFAULT_COMMAND='fd --type f --strip-cwd-prefix --hidden --follow --exclude .git'
export FZF_DEFAULT_OPTS='--style full --height 100% --layout=reverse --info=inline --border=rounded --margin=3% --color=dark --cycle --multi --preview "bat --color=always --style=numbers --line-range=:500 {}"'
export FZF_COMPLETION_TRIGGER='**'
# fzf keybindings using ctrl+t
# Preview file content using bat (https://github.com/sharkdp/bat)
export FZF_CTRL_T_OPTS="
  --walker-skip .git,node_modules,target,.yarn
  --preview 'bat -n --color=always {}'
  --bind 'ctrl-/:change-preview-window(down|hidden|)'"
# preview cmd history using ctrl+r
# CTRL-Y to copy the command into clipboard using pbcopy
export FZF_CTRL_R_OPTS="
  --bind 'ctrl-y:execute-silent(echo -n {2..} | pbcopy)+abort'
  --color header:italic
  --header 'Press CTRL-Y to copy command into clipboard'"

# For Node.js and NVM(Node version manager)
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# For PYTHON
# >>> conda initialize >>>
# # !! Contents within this block are managed by 'conda init' !!

# __conda_setup="$('/home/prasses/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
# if [ $? -eq 0 ]; then
#     eval "$__conda_setup"
# else
#     if [ -f "/home/prasses/miniconda3/etc/profile.d/conda.sh" ]; then
#         . "/home/prasses/miniconda3/etc/profile.d/conda.sh"
#     else
#         export PATH="/home/prasses/miniconda3/bin:$PATH"
#     fi
# fi

# unset __conda_setup
# <<< conda initialize <<<

# Pyenv configuration
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init --path)"
eval "$(pyenv init -)"

# For JAVA
# Adding JAVA_HOME Environment Variables manually
export JAVA_HOME=/usr/lib/jvm/java-1.21.0-openjdk-amd64
export JAVA_FX=/usr/lib/javafx-sdk-23.0.2
export PATH="$JAVA_HOME/bin:$PATH"
export PATH="$JAVA_FX/lib:$PATH"
export DATABASE_PASSWORD=""
# SDKMAN,which manages Java-related SDKs (e.g., Gradle, Maven, Kotlin, etc.)
# THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

# Set up fzf key bindings and fuzzy completion
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# For custom aliases
[ -f ~/.zsh_aliases ] && source ~/.zsh_aliases
