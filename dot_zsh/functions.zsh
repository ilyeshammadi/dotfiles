function zvm_config() {
	 ZVM_LINE_INIT_MODE=$ZVM_MODE_INSERT
	 ZVM_INSERT_MODE_CURSOR=$ZVM_CURSOR_BLOCK
	 ZVM_CURSOR_STYLE_ENABLED=true
}

function zvm_after_init() {
	source <(fzf --zsh)
}

source $ZSH_CUSTOM/plugins/zsh-vi-mode/zsh-vi-mode.zsh
