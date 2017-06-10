#!/bin/bash
# Usage: setup_vim_plugins <file> [<directory>]
# Will clone all github repos given into the given directory,
# making parent directories as necessary. By default, puts in
# ~/.vim/bundle.

file=${1:?No file given, see $0 for usage.}
directory=${2:-~/.vim/bundle}

# Make directory where plugins will go
mkdir -p $directory
cd $directory

# Skip comments
for x in $(grep "^[^#]" ~-/$file); do
  git clone $x
done
