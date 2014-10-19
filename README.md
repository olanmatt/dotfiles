Dotfiles
========

Inspired by: [michaeljsmalley](https://github.com/michaeljsmalley/dotfiles), [mathiasbynens](https://github.com/mathiasbynens/dotfiles), and [skwp](https://github.com/skwp/dotfiles)

This repository includes all of my custom dotfiles.  They should be cloned to
your home directory so that the path is `~/.dotfiles/`.  The included setup
script creates symlinks from your home directory to the files which are located
in `~/.dotfiles/`.

I also prefer `zsh` as my shell of choice.  As such, the setup script will also
clone the `oh-my-zsh` repository from my GitHub. It then checks to see if `zsh`
is installed.  If `zsh` is installed, and it is not already configured as the
default shell, the setup script will execute a `chsh -s $(which zsh)`.  This
changes the default shell to zsh, and takes effect as soon as a new zsh is
spawned or on next login.

Installation
------------

``` bash
git clone git://github.com/olanmatt/dotfiles ~/.dotfiles
cd ~/.dotfiles
make osx
```
