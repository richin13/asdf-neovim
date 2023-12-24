# asdf-neovim

[![Build Status](https://github.com/richin13/asdf-neovim/workflows/Main%20workflow/badge.svg)](https://github.com/richin13/asdf-neovim/workflows/Main%20workflow/badge.svg)

Neovim plugin for [asdf-vm](https://github.com/asdf-vm/asdf)


## Install

```bash
asdf plugin add neovim
```

## Use

```bash

# Install a pre-compiled release

asdf install neovim 0.4.4 # tag of specific version
asdf install neovim nightly # nightly tag
asdf install neovim stable # stable tag

# Compile from source

asdf install neovim ref:master # install from a branch
asdf install neovim ref:f0eb3ca9163ad10753fbb75558b900a539f76e0d # or a commit
```

To "update" your `stable`, `nightly`, or a ref installation, you must first un-install and then re-install the desired version. You can create a few aliases to make this easier.

```bash
alias update-nvim-stable='asdf uninstall neovim stable && asdf install neovim stable'
alias update-nvim-nightly='asdf uninstall neovim nightly && asdf install neovim nightly'
alias update-nvim-master='asdf uninstall neovim ref:master && asdf install neovim ref:master'
```

Check asdf readme for instructions on how to install & manage versions of Neovim.

## License

See `LICENSE`
