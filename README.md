# asdf-neovim

[![Build Status](https://travis-ci.org/richin13/asdf-neovim.svg?branch=master)](https://travis-ci.org/richin13/asdf-neovim)

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
