# custom.zsh - loaded by oh-my-zsh from $ZSH_CUSTOM/custom.zsh

# Print blank line before each prompt (keeps output readable)
_chao_print_newline() { print "" }
precmd_functions+=(_chao_print_newline)
