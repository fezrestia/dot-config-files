# .zshrc

# Lang
export LANG=en_EN.UTF-8

# Auto Completion
autoload -U compinit
compinit
zstyle ':completion:*:default' menu select=1 # Tab key navigation
setopt AUTO_LIST # Show list on single tab key click
setopt AUTO_MENU # Select option by tab key
setopt LIST_TYPES # Show file type

# History
HISTFILE=~/.zsh_history
HISTSIZE=1000 # History lines size on RAM
SAVEHIST=1000 # History lines size in HISTFILE
setopt HIST_IGNORE_ALL_DUPS # Do not store same history
setopt SHARE_HISTORY # Share history among all console
setopt APPEND_HISTORY # Append history instead of over write
setopt INC_APPEND_HISTORY # Add history immediately

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

