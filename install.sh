#!/bin/bash
############################
# .install.sh
# This script creates symlinks from the home directory to any desired dotfiles in ~/dotfiles
############################

########## Variables

dir=~/dotfiles # dotfiles directory
olddir=~/dotfiles_old # old dotfiles backup directory
files="aliases bash_profile bash_prompt bashrc cask curlrc exports functions gitconfig gitignore hgignore inputrc iterm2 oh-my-zsh vim vimrc wgetrc zshrc"
# ignore="LICENSE install.sh README.md fonts"

##########

# TODO allow for clean install from cmdline
#	fresh - install wihout backup
#	clean - remove all without install
# TODO install based on OS
#	darwin - install homebrew, iTerm, fonts, ...
#	linux - don't install homebrew, etc.


# create dotfiles_old in homedir
echo -n "Creating $olddir for backup of any existing dotfiles in ~ ..."
mkdir -p $olddir
echo "done"

# change to the dotfiles directory
echo -n "Changing to the $dir directory ..."
cd $dir
echo "done"

# move any existing dotfiles in homedir to dotfiles_old directory, then create symlinks from the homedir to any files in the ~/dotfiles directory specified in $files
for file in $files; do
	echo "Moving any existing dotfiles from ~ to $olddir"
	mv ~/.$file ~/dotfiles_old/
	echo "Creating symlink to $file in home directory."
	ln -s $dir/$file ~/.$file
	
	# Fixing looped symlinks in folders
	if [[ -d $file ]]; then
		rm $dir/$file/$file
	fi
done

# Installing iTerm2 Preferences
cp $dir/iterm2/com.googlecode.iterm2.plist ~/Library/Preferences

install_zsh () {
	# Test to see if zshell is installed.  If it is:
	if [ -f /bin/zsh -o -f /usr/bin/zsh ]; then
		# Clone my oh-my-zsh repository from GitHub only if it isn't already present
		if [[ ! -d $dir/oh-my-zsh/ ]]; then
			git clone https://github.com/robbyrussell/oh-my-zsh.git
			
			# Copy Agnoster theme to oh-my-zsh
			cp $dir/iterm2/agnoster.zsh-theme ./oh-my-zsh/themes
		fi
		# Set the default shell to zsh if it isn't currently set to zsh
		if [[ ! $(echo $SHELL) == $(which zsh) ]]; then
			chsh -s $(which zsh)
		fi
	else
		# If zsh isn't installed, get the platform of the current machine
		platform=$(uname);
		# If the platform is Linux, try an apt-get to install zsh and then recurse
		if [[ $platform == 'Linux' ]]; then
			sudo apt-get install zsh
			install_zsh
			# If the platform is OS X, tell the user to install zsh :)
		elif [[ $platform == 'Darwin' ]]; then
			if ! type brew > /dev/null; then
				brew install zsh
				install_zsh
			else
				echo "Please install Homebrew"
				exit
			fi
		fi
	fi
}

install_zsh
