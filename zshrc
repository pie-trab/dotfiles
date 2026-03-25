# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=2000
SAVEHIST=100000
setopt autocd extendedglob notify
unsetopt beep
# bindkey -v
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/pietro/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

autoload -U colors && colors
autoload -Uz vcs_info
setopt prompt_subst

# vcs_info Configuration
# Enable dirty check (important for the 'x' to work)
zstyle ':vcs_info:*' check-for-changes true

# Define formats: (%b%u%c) results in (branchnamex)
zstyle ':vcs_info:git:*' formats ' (%F{cyan}%b%f%u%c%m)'
zstyle ':vcs_info:git:*' actionformats ' (%F{cyan}%b%f|%a%u%c%m)'

# Define the "dirty" indicators
zstyle ':vcs_info:git:*' unstagedstr '%F{red}x%f'
zstyle ':vcs_info:git:*' stagedstr '%F{green}+%f'

# This hook detects untracked files and adds a red x to the %m variable
zstyle ':vcs_info:git*+set-message:*' hooks git-untracked
+vi-git-untracked() {
    if [[ $(git rev-parse --is-inside-work-tree 2> /dev/null) == 'true' ]] && \
       [[ -n $(git ls-files --others --exclude-standard) ]]; then
        hook_com[misc]+='%F{yellow}?%f'
    fi
}

# runs before every prompt
precmd() { vcs_info }

# Define the Prompt
# %B...%b makes text bold
# %F{...}...%f sets colors
# %n = username, %1~ = last component of current directory
PROMPT='%B%F{%(!.red.yellow)}%n %1~%b%F{reset}${vcs_info_msg_0_} %# '
RPROMPT=''
setopt share_history
if [ -x "$(command -v fzf)"  ]
then
    source /usr/share/fzf/shell/key-binding.zsh
fi
