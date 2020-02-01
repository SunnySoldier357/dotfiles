#!/bin/bash

[[ -f ~/.bashrc ]] && . ~/.bashrc

# Load the shell dotfiles, and then some:
# * ~/.bash_path can be used to extend `$PATH`.
# * ~/.bash_extra can be used for other settings you don’t want to commit.
for file in ~/.bash/{path,exports}; do
	if [[ -r "$file" ]] && [[ -f "$file" ]]; then
		# shellcheck source=/dev/null
		source "$file"
	fi
done
unset file