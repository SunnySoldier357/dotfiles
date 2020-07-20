# dotfiles

Collection of Personal Dotfiles

## `rcm`

I use `rcm` to organise my dotfiles. To update the dotfiles, in the ~/.dotfiles
directory where this repo should be cloned, run this command: `rcup -v`.

To configure `rcm` like files to exclude or tags to automaticaly include for the
current machine, create the `.rcrc` file in your `$HOME` directory.

``` properties
EXCLUDES="*.md"
TAGS="git zsh"
```

## Dependecies

### zsh

- [prezto](https://github.com/sorin-ionescu/prezto) with
  [zsh-prompt-garrett](https://github.com/chauncey-garrett/zsh-prompt-garrett)
