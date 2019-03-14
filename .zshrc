# .zshrc

# Environmental Variables
export LANG=en_EN.UTF-8
export EDITOR=vi

# Key Bind
bindkey -v # VI like key bind

# Colors
autoload -U colors
colors

# Command Alias
setopt COMPLETE_ALIASES # Alias can support auto completion
alias ls='ls -A -F --color=auto'
alias lsa='ls -a -l -F --color=auto'
alias lsd='lsa | grep -e ^d'
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
setopt NOAUTOREMOVESLASH # Do not remove slash after dir name

# History
HISTFILE=~/.zsh_history
HISTSIZE=1000 # History lines size on RAM
SAVEHIST=1000000 # History lines size in HISTFILE
setopt HIST_IGNORE_DUPS # Do not store repeated same command to history
setopt HIST_IGNORE_SPACE # Do not store the cmd started with space
setopt HIST_SAVE_NODUPS # Do not store dup command to history
setopt HIST_NO_STORE # Do not store "history" command
setopt HIST_REDUCE_BLANKS # Split head/tail white spaces
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
setopt PUSHD_IGNORE_DUPS # Do not pushd same dir

# Auto Correct
setopt CORRECT # Command auto correction

# No Beep
setopt NOLISTBEEP # Do not play beep sound

