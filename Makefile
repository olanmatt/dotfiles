DIR=$(HOME)/.dotfiles

osx: symlinks brew python ruby go tmux vim zsh
	@echo "Run 'make cask' to install applications"

dotfiles: symlinks python ruby go tmux vim zsh
	@echo

symlinks:
	@ln -sf $(DIR)/bash/bash_profile $(HOME)/.bash_profile
	@ln -sf $(DIR)/bash/bashrc $(HOME)/.bashrc
	@ln -sf $(DIR)/bash/aliases $(HOME)/.aliases
	@ln -sf $(DIR)/bash/exports $(HOME)/.exports
	@ln -sf $(DIR)/bash/functions $(HOME)/.functions
	@ln -nsf $(DIR)/tmux/tmux $(HOME)/.tmux
	@ln -sf $(DIR)/tmux/tmux.conf $(HOME)/.tmux.conf
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

python:
	command -v easy_install >/dev/null 3>&1 || { curl https://bootstrap.pypa.io/ez_setup.py -o - | sudo python; }
	command -v pip >/dev/null 2>&1 || sudo easy_install pip
	sudo $(DIR)/python/Pipfile

ruby:
	curl -sSL https://get.rvm.io | bash -s stable

go:
	mkdir -p $(HOME)/Documents/go

tmux: symlinks
	git clone git://github.com/tmux-plugins/tpm $(HOME)/.tmux/plugins/tpm
	$(DIR)/tmux/tmux/plugins/tpm/scripts/install_plugins.sh >/dev/null 2>&1

vim: symlinks
	git clone https://github.com/gmarik/Vundle.vim.git $(HOME)/.vim/bundle/Vundle.vim
	vim +PluginInstall +qall
	ln -s $(DIR)/vim/olanmatt_airline.vim $(DIR)/vim/vim/bundle/vim-airline/autoload/airline/themes/olanmatt.vim

zsh:
	git clone git://github.com/robbyrussell/oh-my-zsh.git $(HOME)/.oh-my-zsh
	ln -sf $(DIR)/zsh/*.zsh-theme $(HOME)/.oh-my-zsh/themes

.PHONY: symlinks brew cask python ruby go tmux vim zsh
