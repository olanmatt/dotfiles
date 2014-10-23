DIR=$(HOME)/.dotfiles
DEB_GO='https://storage.googleapis.com/golang/go1.2.2.linux-amd64.tar.gz'

osx: symlinks brew python ruby go vundle oh_my_zsh
	@echo "Run 'make cask' to install applications"

deb: symlinks aptitude python ruby go godeb vundle oh_my_zsh

arch: symlinks pacman python ruby go godeb vundle oh_my_zsh

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
	command -v brew >/dev/null 2>&1 || ruby -e "$$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
	brew update
	brew upgrade
	$(DIR)/osx/Brewfile
	sudo sh -c 'echo "/usr/local/bin/zsh" >> /etc/shells'
	chsh -s /usr/local/bin/zsh $(USER)

cask: brew
	brew tap caskroom/cask
	brew install brew-cask
	brew cask update
	$(DIR)/osx/Caskfile

aptitude:
	sudo apt-get update
	sudo cat "$(DIR)/linux/packages.list" | sudo xargs apt-get -y install
	sudo dpkg-divert --local --divert /usr/bin/ack --rename --add /usr/bin/ack-grep

pacman:
	pacman -Syy
	pacman -S $(< $(DIR)/linux/packages.list)

python:
	command -v easy_install >/dev/null 2>&1 || { curl https://bootstrap.pypa.io/ez_setup.py -o - | sudo python; }
	command -v pip >/dev/null 2>&1 || sudo easy_install pip
	sudo $(DIR)/python/Pipfile

ruby:
	\curl -sSL https://get.rvm.io | bash -s stable --auto-dotfiles

go:
	mkdir -p $(HOME)/Documents/go

godeb:
	command -v go >/dev/null 2>&1 || { curl $(DEB_GO) -o - | sudo tar -C /usr/local -xz; }

vundle: symlinks
	git clone https://github.com/gmarik/Vundle.vim.git $(HOME)/.vim/bundle/Vundle.vim
	@echo "Reminder: Vim plugins are managed within Vim with Vundle."

oh_my_zsh:
	git clone git://github.com/robbyrussell/oh-my-zsh.git $(HOME)/.oh-my-zsh
	ln -sf $(DIR)/zsh/*.zsh-theme $(HOME)/.oh-my-zsh/themes

.PHONY: python
