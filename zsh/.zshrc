# We want to make sure cargo comes before .local
. "$HOME/.cargo/env"

# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

# Path to your Oh My Zsh installation.
ZSH_TMUX_FIXTERM=false
export ZSH="$HOME/.config/zsh/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time Oh My Zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git fzf-tab git zsh-autosuggestions fast-syntax-highlighting zsh-vi-mode tmux)

source $ZSH/oh-my-zsh.sh

# User configuration

export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Always use nvim
export EDITOR='nvim'

# Compilation flags
# export ARCHFLAGS="-arch $(uname -m)"

# Set personal aliases, overriding those provided by Oh My Zsh libs,
# plugins, and themes. Aliases can be placed here, though Oh My Zsh
# users are encouraged to define aliases within a top-level file in
# the $ZSH_CUSTOM folder, with .zsh extension. Examples:
# - $ZSH_CUSTOM/aliases.zsh
# - $ZSH_CUSTOM/macos.zsh
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# oh-my-posh
eval "$(oh-my-posh init zsh --config $HOME/.config/oh-my-posh/config.toml)"


# OMP zsh-vi-mode integration
_omp_redraw-prompt() {
  local precmd
  for precmd in "${precmd_functions[@]}"; do
    "$precmd"
  done

  zle .reset-prompt
}

export POSH_VI_MODE="INSERT"

function zvm_after_select_vi_mode() {
  case $ZVM_MODE in
  $ZVM_MODE_NORMAL)
    POSH_VI_MODE="NORMAL"
    ;;
  $ZVM_MODE_INSERT)
    POSH_VI_MODE="INSERT"
    ;;
  $ZVM_MODE_VISUAL)
    POSH_VI_MODE="VISUAL"
    ;;
  $ZVM_MODE_VISUAL_LINE)
    POSH_VI_MODE="V-LINE"
    ;;
  $ZVM_MODE_REPLACE)
    POSH_VI_MODE="REPLACE"
    ;;
  esac
  _omp_redraw-prompt
}

# This stops the shell from accepting empty lines
function _setup_zsh_enter_binding() {
  function accept-line-or-not {
    if [[ -z "$BUFFER" ]]; then
      return 0
    else
      zle accept-line
    fi
  }
  zle -N accept-line-or-not
  bindkey "^M" accept-line-or-not
}

# Make sure this runs after all plugins are loaded
autoload -U add-zsh-hook
add-zsh-hook precmd _setup_zsh_enter_binding

# Beautify ls
func ls() {
    if [[ ! (( $#commands[eza] )) ]]
    then
        /bin/ls $@
    elif [[ $1 == "size" ]]
    then
        ls-bysize --icons ${@:2}
    elif [[ $1 == "atime" ]]
    then
        ls-byatime --icons ${@:2}
    elif [[ $1 == "mtime" ]]
    then
        ls-bymtime --icons ${@:2}
    elif [[ $1 == "ctime" ]]
    then
        ls-byctime --icons ${@:2}
    else
        eza -h --group-directories-first --icons -g $@ --git --color always
    fi
}

func ls-bysize() {
    eza -h --group-directories-first -g $@ -l --git -s size --color always
}

func ls-byatime() {
    eza -h --group-directories-first -g $@ -l --git -s accessed --color always --accessed
}

func ls-bymtime() {
    eza -h --group-directories-first -g $@ -l --git -s accessed --color always --modified
}

func ls-byctime() {
    eza -h --group-directories-first -g $@ -l --git -s accessed --color always --created
}

func grep1() {
    awk -v pattern="${1:?pattern is empty}" 'NR==1 || $0~pattern' "${2:-/dev/stdin}";
}

func argtest() {
    echo "${@:2}"
}

