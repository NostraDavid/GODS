export ZSH="/home/david/.oh-my-zsh"
ZSH_THEME="fishy"
HYPHEN_INSENSITIVE="true"
DISABLE_UPDATE_PROMPT="true"
ENABLE_CORRECTION="true"
HIST_STAMPS="yyyy-mm-dd"

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS=true

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
plugins=(
    alias-finder
    autojump
    battery
    bgnotify
    catimg
    chucknorris
    colored-man-pages
    colorize
    command-not-found
    common-aliases
    compleat
    docker-compose
    docker
    encode64
    extract
    fasd
    fd
    git-escape-magic
    git-prompt
    git
    gitfast
    gitignore
    history
    httpie
    please
    ripgrep
    scd
    sudo
    taskwarrior
    thefuck
    themes
    timer
    wd
    z
)

source $ZSH/oh-my-zsh.sh

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
    export EDITOR='vim'
else
    export EDITOR='mvim'
fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# For a full list of active aliases, run `alias`.
alias update="sudo apt update && sudo apt upgrade -y"
alias vi=nvim
alias vim=nvim
alias vimdiff="/usr/bin/vimdiff -d"
