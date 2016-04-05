# .zshrc

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

