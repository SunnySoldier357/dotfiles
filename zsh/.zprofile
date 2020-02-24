#!/bin/zsh

[[ -f ~/.zshrc ]] && . ~/.zshrc

# Load the shell dotfiles, and then some:
# * ~/.zsh/path can be used to extend `$PATH`.
for file in ~/.zsh/{path,exports}; do
	if [[ -r "$file" ]] && [[ -f "$file" ]]; then
		# shellcheck source=/dev/null
		source "$file"
	fi
done
unset file