# ----- guard against non-interactive logins ---------------------------------
[ -z "$PS1" ] && return


# ----- convenient alias and function definitions ----------------------------

# color support for ls and grep
alias grep='grep --color=auto'
if [[ `uname` = "Darwin" || `uname` = "FreeBSD" ]]; then
  alias ls='ls -G'
else
  alias ls='ls --color=auto'
fi

# Run firefox plugin debugger
ff() {
  if [[ $@ == "-test" ]]; then
    command jpm test -b /usr/bin/firefox
  else
    command jpm run -b /usr/bin/firefox
  fi
}

### cc <arguments to gcc> -- Invokes gcc with the flags you will usually use
### valgrind-leak <arguments to valgrind> -- Invokes valgrind in the mode to show all leaks
### hidden <arguments to ls> -- Displays ONLY the hidden files
### killz <program name> -- Kills all programs with the given program name
### shell -- Displays the name of the shell being used

alias killz='killall -9 '
alias hidden='ls -a | grep "^\..*"'
alias rm='rm -vi'
alias cp='cp -vi'
alias mv='mv -vi'
alias shell='ps -p $$ -o comm='
alias smlnj='rlwrap sml'
alias coin='rlwrap coin'
alias ocaml='rlwrap ocaml'
alias perl='rlwrap perl'
alias cc='gcc -Wall -W -ansi -pedantic -O2 '
alias valgrind-leak='valgrind --leak-check=full --show-reachable=yes'

# Make directory for storing rlwrap history
mkdir -p ~/.rlwrap

# Define custom rlwrap command that writes to my own history :)
rlwrap() {
  if [ $# -eq 1 ]; then
    command rlwrap -H ~/.rlwrap/${1}_history $1
  else
    command rlwrap $*
  fi
}

# Go up to top level of git repo
gitup() {
  top=$(git rev-parse --show-toplevel 2>/dev/null)
  if [ $? -eq 0 ]; then
    cd $top
  fi
}


# ----- shell settings and completion -------------------------------------

# Make .bash_history store more and not store duplicates
export HISTCONTROL=ignoreboth
export HISTSIZE=250000
export HISTFILESIZE=250000

# Append to the history file, don't overwrite it
shopt -s histappend

# Check the window size after each command and, if necessary,
# Update the values of LINES and COLUMNS.
shopt -s checkwinsize

# Enable programmable completion features
if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi

bind "set completion-ignore-case on"

# Make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe.sh ] && export LESSOPEN="|/usr/bin/lesspipe.sh %s"

# Turn off the ability for other people to message your terminal using wall
mesg n


# ----- change the prompt ----------------------------------------------------

branchname () {
  git branch 2>/dev/null | grep "^\*" | cut -c 3-
}

exit_status () {
  [ $? == 0 ] || echo "[$?]"
}

COLOR1='\[\033[1;32m\]'
COLOR2='\[\033[1;36m\]'
COLOR3='\[\033[0;92m\]'
COLOR4='\[\033[0m\]'
COLOR5='\[\033[1;35m\]'
COLOR6='\[\e[0;31m\]'

cute_git_thing () {
  ex=$(exit_status)
  bn=$(branchname)
  if [ ! -z $bn ]; then
    echo -n " ($bn)"
  fi
  if [ ! -z $ex ]; then
    echo " $ex"
  fi
}

PS1="$COLOR1\u:$COLOR2\w$COLOR5\$(cute_git_thing) $COLOR3\$ $COLOR4"

export PATH=$PATH":$HOME/bin"
export PATH="$HOME/node_modules/jpm/bin/:$PATH"

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

export JAVA_HOME="/home/nick/bin/java/jdk1.8.0_101/jre"
export PATH="$PATH:$JAVA_HOME/bin:$HOME/.rvm/bin" # Add RVM to PATH for scripting
export COURSE=~/Documents/cmu-coursework/

# Don't delete files without asking please
set -o noclobber

# OCaml setup
. /home/nick/.opam/opam-init/init.sh > /dev/null 2> /dev/null || true

# THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="/home/nick/.sdkman"
[[ -s "/home/nick/.sdkman/bin/sdkman-init.sh" ]] && source "/home/nick/.sdkman/bin/sdkman-init.sh"
