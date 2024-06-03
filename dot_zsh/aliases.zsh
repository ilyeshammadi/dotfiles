alias v="nvim"
alias vi="nvim"
alias vim="nvim"
alias c="clear"
alias e="exit"
alias fzf="fzf-tmux -p"
alias cat="bat"
alias ls="exa --icons --group-directories-first"
alias po="poetry"
alias we="watchexec"

alias d='dirs -v'
for index ({1..9}) alias "$index"="cd +${index}"; unset index
