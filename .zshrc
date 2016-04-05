# .zshrc

# Lang
export LANG=en_EN.UTF-8

# Auto Completion
autoload -U compinit
compinit
zstyle ':completion:*' menu select # Tab key navigation

# History
HISTFILE=~/.zsh_history
HISTSIZE=1000 # History lines size on RAM
SAVEHIST=1000 # History lines size in HISTFILE
setopt HIST_IGNORE_ALL_DUPS # Do not store same history
setopt SHARE_HISTORY # Share history among all console

# Colors
autoload -Uz colors
colors

# Prompt UI
setopt PROMPT_SUBST # Enable script in prompt
case ${UID} in
    0 ) # Root
        PROMPT="%{$fg_bold[red]%}ENTER >%{$reset_color%}/%~/$ "
        RPROMPT="%{$fg[red]%}%n@%M%{$reset_color%}"
        ;;

    * )
        PROMPT="%{$fg_bold[red]%}ENTER >%{$reset_color%}/%~/$ "
        RPROMPT="%{$fg[green]%}%n@%M%{$reset_color%}"
        ;;
esac

# Console Title
case "${TERM}" in
    xterm* | kterm* )
        precmd() {
            echo -ne "\033]0;${USER}@${HOST%%.*}:${PWD}\007"
        }
        ;;
esac

