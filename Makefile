DIR=$(HOME)/dotfiles
DEB_GO='https://storage.googleapis.com/golang/go1.2.2.linux-amd64.tar.gz'

osx: symlinks brew python_env go_env vundle oh_my_zsh

deb: symlinks apt-get python_env go_env godeb vundle oh_my_zsh

arch: symlinks pacman python_env go_env godeb vundle oh_my_zsh

symlinks:
	@ln -sf $(DIR)/bash/bash_profile $(HOME)/.bash_profile
	@ln -sf $(DIR)/bash/bashrc $(HOME)/.bashrc
	@ln -sf $(DIR)/bash/aliases $(HOME)/.aliases
	@ln -sf $(DIR)/bash/exports $(HOME)/.exports
	@ln -sf $(DIR)/bash/functions $(HOME)/.functions
	@ln -sf $(DIR)/zsh/zshrc $(HOME)/.zshrc
	@ln -nsf $(DIR)/vim/vim $(HOME)/.vim
	@ln -sf $(DIR)/vim/vimrc $(HOME)/.vimrc
	@ln -sf $(DIR)/git/gitconfig $(HOME)/.gitconfig
	@ln -sf $(DIR)/git/gitignore $(HOME)/.gitignore

brew:
	ruby $(DIR)/osx/ensure_homebrew.rb
	brew bundle $(DIR)/osx/Brewfile

cask: brew
	brew bundle $(DIR)/osx/Caskfile

apt-get:
	sudo apt-get update
	sudo cat "$(DIR)/linux/packages.list" | sudo xargs apt-get -y install
	sudo dpkg-divert --local --divert /usr/bin/ack --rename --add /usr/bin/ack-grep

pacman:
	pacman -Syy
	pacman -S $(< $(DIR)/linux/packages.list)

python_env:
	command -v easy_install >/dev/null 2>&1 || { curl https://bootstrap.pypa.io/ez_setup.py -o - | sudo python; }
	command -v pip >/dev/null 2>&1 || sudo easy_install pip
	sudo pip install virtualenv
	sudo pip install virtualenvwrapper

go_env:
	mkdir -p $(HOME)/Documents/go

godeb:
	command -v go >/dev/null 2>&1 || { curl $(DEB_GO) -o - | sudo tar -C /usr/local -xz; }

vundle: symlinks
	git clone https://github.com/gmarik/Vundle.vim.git $(HOME)/.vim/bundle/Vundle.vim
	@echo "Reminder: Vim plugins are managed within Vim with Vundle."

oh_my_zsh:
	git clone git://github.com/robbyrussell/oh-my-zsh.git $(HOME)/.oh-my-zsh
	cp $(DIR)/zsh/*.zsh-theme $(HOME)/.oh-my-zsh/themes
