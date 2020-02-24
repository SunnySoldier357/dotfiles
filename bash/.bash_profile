#!/bin/bash

[[ -f ~/.bashrc ]] && . ~/.bashrc

# Load the shell dotfiles, and then some:
# * ~/.bash/path can be used to extend `$PATH`.
for file in ~/.bash/{path,exports}; do
	if [[ -r "$file" ]] && [[ -f "$file" ]]; then
		# shellcheck source=/dev/null
		source "$file"
	fi
done
unset file