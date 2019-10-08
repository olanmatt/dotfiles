#!/bin/bash

git init
git remote add origin git@github.com:olanmatt/dotfiles.git
git fetch
git checkout -t origin/master -f
git submodule update --init --recursive