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
# fzf-tab must come before plugins that wrap widgets (autosuggestions, syntax-highlighting)
# fzf itself is set up by ~/.fzf.zsh at the bottom, so the omz fzf plugin isn't needed
plugins=(git fzf-tab zsh-autosuggestions sudo web-search copyfile jsontools zsh-syntax-highlighting vi-mode)

# Keep large pastes fast: skip suggestions/highlighting on huge command lines
ZSH_AUTOSUGGEST_MANUAL_REBIND=1
ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20
ZSH_HIGHLIGHT_MAXLENGTH=512

source $ZSH/oh-my-zsh.sh

# Don't highlight pasted text
zle_highlight+=(paste:none)

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

# ZSH autocompletion (compinit is already run by oh-my-zsh)
bindkey -v
zstyle ':completion:*' verbose yes
# fzf-tab: plain group headers, no zsh menu (fzf replaces it), ls colors in the list
zstyle ':completion:*:descriptions' format '[%d]'
zstyle ':completion:*' menu no
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*:git-checkout:*' sort false

# fzf-tab: < and > switch between completion groups, previews per command
zstyle ':fzf-tab:*' use-fzf-default-opts yes
zstyle ':fzf-tab:*' switch-group '<' '>'
zstyle ':fzf-tab:complete:(cd|z|__zoxide_z):*' fzf-preview 'eza --tree --level=1 --color=always --icons=always $realpath'
zstyle ':fzf-tab:complete:(nvim|vim|bat|cat|less|eza|ls):*' fzf-preview 'fzf-preview $realpath'
zstyle ':fzf-tab:complete:(kill|ps):argument-rest' fzf-preview 'ps -p $word -o pid,user,%cpu,%mem,cmd --no-headers -ww'
zstyle ':fzf-tab:complete:(kill|ps):argument-rest' fzf-flags --preview-window=down:3:wrap
zstyle ':fzf-tab:complete:git-(checkout|switch|log|diff):*' fzf-preview 'git log --oneline --graph --color=always -20 $word'
zstyle ':fzf-tab:complete:systemctl-*:*' fzf-preview 'SYSTEMD_COLORS=1 systemctl status $word'
zstyle ':fzf-tab:complete:(-command-|-parameter-|-brace-parameter-|export|unset|expand):*' fzf-preview 'echo ${(P)word}'

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
# "ansi" uses the terminal's 16 colors, so it follows the WezTerm scheme (Batman); custom themes live in bat/.config/bat/themes
export BAT_THEME="ansi"
# no --color=always: bat colors on screen but acts like plain cat in pipes and redirects
alias cat="bat --plain --wrap character -n"
# ---- yazi (file manager) ----
# y [dir]: open yazi, and cd to the directory it was in when you quit with q (Q quits without cd)
y() {
  local tmp cwd
  tmp="$(mktemp -t yazi-cwd.XXXXXX)"
  yazi "$@" --cwd-file="$tmp"
  IFS= read -r -d '' cwd < "$tmp"
  [[ -n $cwd && $cwd != $PWD ]] && builtin cd -- "$cwd"
  rm -f -- "$tmp"
}
# for nvim 
alias vim="nvim"
alias nv="nvim ."
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

# Ghidra
alias ghidra="/opt/ghidra/ghidraRun"

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
# Minimal layout: no boxes, just a divider before the preview; Batman colors (same as WezTerm and tmux)
# full screen with the prompt on the bottom line, list reads top to bottom (best match first)
# preview starts hidden (ctrl-/ shows it); it goes above the list on narrow terminals
# ctrl-/ toggle preview, ctrl-d/ctrl-u scroll preview, alt-a select all, ctrl-y copy selection
export FZF_DEFAULT_OPTS="
  --height=100% --layout=reverse-list --style=minimal --border=none --info=inline-right
  --cycle --multi --prompt='❯ ' --pointer='▶' --marker='✓' --gutter=' '
  --preview-window='right,55%,border-left,hidden,<50(up,50%,border-bottom,hidden)'
  --bind='ctrl-/:toggle-preview,ctrl-d:preview-half-page-down,ctrl-u:preview-half-page-up,alt-a:toggle-all'
  --bind='ctrl-y:execute-silent(printf \"%s\n\" {+} | xclip -selection clipboard)'
  --color='bg:#1b1d1e,bg+:#4d504c,fg:#a3a3a6,fg+:#dadbd6,hl:#e6dc44,hl+:#fcef0c,query:#dadbd6'
  --color='info:#919495,prompt:#e6dc44,pointer:#fcef0c,marker:#fff78e,spinner:#fcef0c'
  --color='header:#737174,border:#505354,label:#a3a3a6,gutter:#1b1d1e,preview-bg:#1b1d1e'"
export FZF_COMPLETION_TRIGGER='**'
# ctrl+t: files and dirs, previewed by type (bat, eza tree, pdf text, ...)
export FZF_CTRL_T_COMMAND='fd --strip-cwd-prefix --hidden --follow --exclude .git'
export FZF_CTRL_T_OPTS="--preview 'fzf-preview {}'"
# alt+c: cd into a directory, previewed as a tree
export FZF_ALT_C_COMMAND='fd --type d --strip-cwd-prefix --hidden --follow --exclude .git'
export FZF_ALT_C_OPTS="--no-multi --preview 'eza --tree --level=2 --color=always --icons=always {}'"
# ctrl+r: command history; ctrl-/ shows the full command, ctrl-y copies it
export FZF_CTRL_R_OPTS="
  --preview 'echo {2..}' --preview-window='up,3,wrap,hidden'
  --bind 'ctrl-y:execute-silent(echo -n {2..} | xclip -selection clipboard)+abort'
  --color header:italic
  --header 'CTRL-Y: copy command, CTRL-/: show full command'"

# ** completion: list with fd instead of find
_fzf_compgen_path() {
  fd --hidden --follow --exclude .git . "$1"
}
_fzf_compgen_dir() {
  fd --type d --hidden --follow --exclude .git . "$1"
}
# ** completion: previews per command
_fzf_comprun() {
  local command=$1
  shift
  case "$command" in
    cd|z)         fzf --preview 'eza --tree --level=2 --color=always --icons=always {}' "$@" ;;
    export|unset) fzf --preview "eval 'echo \${}'" "$@" ;;
    *)            fzf --preview 'fzf-preview {}' "$@" ;;
  esac
}

# ---- fzf helpers ----
# inv: pick file(s) and open them in nvim
inv() {
  local files
  files=("${(@f)$(fzf --preview 'fzf-preview {}')}") || return
  nvim "${files[@]}"
}

# rgf [query]: live ripgrep, open the selected match in nvim at its line
rgf() {
  local rg="rg --column --line-number --no-heading --color=always --smart-case --hidden --glob '!.git'"
  local sel file line
  sel=$(fzf --ansi --disabled --no-multi --query "$*" --prompt 'rg ❯ ' --delimiter : \
    --bind "start:reload:$rg {q} || true" \
    --bind "change:reload:sleep 0.1; $rg {q} || true" \
    --preview 'bat --color=always --style=numbers --highlight-line {2} {1}' \
    --preview-window 'right,55%,border-left,+{2}/2,<50(up,50%,border-bottom,+{2}/2)') || return
  IFS=: read -r file line _ <<< "$sel"
  nvim "+$line" "$file"
}

# fkill [signal]: pick your processes (busiest first) and kill them, SIGTERM by default
fkill() {
  local pids
  pids=$(ps -u "$USER" -o pid,ppid,%cpu,%mem,start,cmd --sort=-%cpu |
    fzf --header-lines=1 --prompt 'kill ❯ ' --preview 'echo {}' --preview-window 'down,3,wrap' |
    awk '{print $1}')
  [[ -n $pids ]] && kill -"${1:-TERM}" ${(f)pids}
}

# fco: pick a local or remote git branch (most recent first) and switch to it
fco() {
  local branch
  branch=$(git branch --all --sort=-committerdate --format='%(refname:short)' |
    grep -v -e '^HEAD$' -e '/HEAD$' -e '^origin$' |
    fzf --no-multi --prompt 'branch ❯ ' --preview 'git log --oneline --graph --color=always -30 {}') || return
  git switch "${branch#origin/}"
}

# fenv: browse environment variables, prints the selected NAME=value lines
fenv() {
  env | sort | fzf --prompt 'env ❯ ' --preview 'echo {}' --preview-window 'down,5,wrap'
}

# For Node.js and NVM(Node version manager)
# Loading nvm.sh took ~250ms of every shell start, so only the default node goes on PATH here
# (newest installed version matching ~/.nvm/alias/default, e.g. "20"); nvm itself loads on first use
export NVM_DIR="$HOME/.nvm"
_nvm_load() {
  unfunction nvm _nvm_load
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
  [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
}
nvm() { _nvm_load && nvm "$@" }
() {
  local alias_file=$NVM_DIR/alias/default
  [[ -r $alias_file ]] || return
  local want=$(<$alias_file)
  local -a dirs=($NVM_DIR/versions/node/v${want#v}(N/nOn[1]) $NVM_DIR/versions/node/v${want#v}.*(N/nOn[1]))
  # aliases like lts/* or node can't be resolved without nvm: load it now
  (( $#dirs )) && export PATH="$dirs[1]/bin:$PATH" || _nvm_load
}

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
# The shims are enough to run the selected python; `pyenv init -` (a subprocess on every start) runs on first use of pyenv
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/shims:$PYENV_ROOT/bin:$PATH"
pyenv() {
  unfunction pyenv
  eval "$(command pyenv init - zsh)"
  pyenv "$@"
}

# For JAVA
# Adding JAVA_HOME Environment Variables manually
export JAVA_HOME=/usr/lib/jvm/java-1.21.0-openjdk-amd64
export JAVA_FX=/usr/lib/javafx-sdk-23.0.2
export PATH="$JAVA_HOME/bin:$PATH"
export PATH="$JAVA_FX/lib:$PATH"
export DATABASE_PASSWORD=""
# SDKMAN,which manages Java-related SDKs (e.g., Gradle, Maven, Kotlin, etc.)
# Its installed tools go on PATH (with GRADLE_HOME etc.) like sdkman-init.sh does; the sdk command loads on first use
export SDKMAN_DIR="$HOME/.sdkman"
() {
  local c
  for c in $SDKMAN_DIR/candidates/*/current(N); do
    export PATH="$c/bin:$PATH"
    export "${(U)${c:h:t}}_HOME"="$c"
  done
}
sdk() {
  unfunction sdk
  [[ -s "$SDKMAN_DIR/bin/sdkman-init.sh" ]] && source "$SDKMAN_DIR/bin/sdkman-init.sh"
  sdk "$@"
}

# Set up fzf key bindings and fuzzy completion
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# For custom aliases
[ -f ~/.zsh_aliases ] && source ~/.zsh_aliases
