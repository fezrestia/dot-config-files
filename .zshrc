# .zshrc

# Lang
export LANG=en_EN.UTF-8

# Key Bind
bindkey -v # VI like key bind

# Colors
autoload -U colors
colors

# Command Alias
alias ls='ls -A --color=auto'
alias lsa='ls -a -l --color=auto'
alias grep='grep --color=auto'

# Auto Completion
autoload -U compinit
compinit
zstyle ':completion:*' menu select=2 # Tab key navigation
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS} # Color option
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}' # No case sensitive
setopt AUTO_LIST # Show list on single tab key click
setopt AUTO_MENU # Select option by tab key
setopt LIST_TYPES # Show file type
setopt LIST_PACKED # Show list without large space

# History
HISTFILE=~/.zsh_history
HISTSIZE=1000 # History lines size on RAM
SAVEHIST=1000000 # History lines size in HISTFILE
setopt HIST_IGNORE_ALL_DUPS # Do not store same history
setopt SHARE_HISTORY # Share history among all console
setopt APPEND_HISTORY # Append history instead of over write
setopt INC_APPEND_HISTORY # Add history immediately
setopt EXTENDED_HISTORY # Add timestamp to history

# History Search
autoload -U history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end

# Prompt UI
setopt PROMPT_SUBST # Enable script in prompt
case ${UID} in
    0 ) # Root
        PROMPT="%{$fg_bold[red]%}ENTER>%{$reset_color%}/%~/$ "
        RPROMPT="%{$fg[red]%}%n@%M%{$reset_color%}"
        ;;

    * )
        PROMPT="%{$fg_bold[red]%}ENTER>%{$reset_color%}/%~/$ "
        RPROMPT="%{$fg[green]%}%n@%M%{$reset_color%}"
        ;;
esac

# Console Title
case "${TERM}" in
    xterm* | kterm* )
        precmd() {
            echo -ne "\033]0;${USER}@${HOST%%.*} : ${PWD}\007"
        }
        ;;
esac

# Dir Name
setopt MARK_DIRS # Add / after dir name

# Print 2-bytes code
setopt PRINT_EIGHT_BIT

# Directory Navigation
setopt AUTO_CD # Only directory name to move
alias ...='cd ../../'
alias ....='cd ../../../'
setopt AUTO_PUSHD # Always store directory, Tap TAB key after "cd -"

# Auto Correct
setopt CORRECT # Command auto correction

