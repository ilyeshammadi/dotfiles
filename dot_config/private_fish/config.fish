fish_vi_key_bindings

set -g fish_greeting

# Aliases
alias vi="nvim"
alias vim="nvim"
alias fzf="fzf-tmux -p"
alias cat="bat"
alias ls="eza -l --icons --group-directories-first"

# Abbrevations
## Generic
abbr --add v nvim
abbr --add c clear
abbr --add e exit
abbr --add po poetry
## Docker
abbr --add dsrm "docker stop (docker ps -a -q) && docker rm (docker ps -a -q) && docker volume rm (docker volume ls -q)"
abbr --add dps "docker ps"
abbr --add lzd "lazydocker"
abbr --add lzg "lazygit"


starship init fish | source
