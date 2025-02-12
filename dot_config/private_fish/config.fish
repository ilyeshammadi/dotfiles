fish_vi_key_bindings

alias vi="nvim"
alias vim="nvim"
alias fzf="fzf-tmux -p"
alias cat="bat"
alias ls="eza --icons --group-directories-first"
alias dsrm="docker stop $(docker ps -a -q) && docker rm $(docker ps -a -q) && docker volume rm $(docker volume ls -q)"

abbr --add v nvim
abbr --add c clear
abbr --add e exit
abbr --add po poetry


starship init fish | source
