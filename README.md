# dotfiles

Collection of Personal Dotfiles

## `rcm`

I use `rcm` to organise my dotfiles. To update the dotfiles, in the ~/.dotfiles
directory where this repo should be cloned, run this command: `rcup -v`.

To configure `rcm` like files to exclude or tags to automaticaly include for the
current machine, create the `.rcrc` file in your `$HOME` directory or `~/.config/rcm/config`

``` properties
EXCLUDES="*.md"
TAGS="awesome zsh"
```

## Initialization

Run the following command

```sh
rcup -v -x "*.md" -t tty -t zsh
```

## Dependecies

### zsh

- [prezto](https://github.com/sorin-ionescu/prezto) with
  [zsh-prompt-garrett](https://github.com/chauncey-garrett/zsh-prompt-garrett)

## Additional Steps

### macOS

- [`sudo` with Touch ID](https://dev.to/siddhantkcode/enable-touch-id-authentication-for-sudo-on-macos-sonoma-14x-4d28)
- Set hostnames
  - `sudo scutil --set HostName <new host name>`
  - `sudo scutil --set LocalHostName <new host name>`
  - `sudo scutil --set ComputerName <new name>`
