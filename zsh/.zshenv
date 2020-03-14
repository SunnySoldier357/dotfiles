#!/bin/zsh

# Load the shell dotfiles, and then some:
# * ~/.zsh/path can be used to extend `$PATH`.
for file in ~/.zsh/{exports,path}; do
	if [[ -r "$file" ]] && [[ -f "$file" ]]; then
		# shellcheck source=/dev/null
		source "$file"
	fi
done
unset file

[[ -f ~/.zshrc ]] && . ~/.zshrc