### cc <arguments to gcc> -- Invokes gcc with the flags you will usually use
### valgrind-leak <arguments to valgrind> -- Invokes valgrind in the mode to show all leaks
### hidden <arguments to ls> -- Displays ONLY the hidden files
### killz <program name> -- Kills all programs with the given program name
### shell -- Displays the name of the shell being used

alias killz='killall -9 '
alias hidden='ls -a | grep "^\..*"'
alias rm='rm -v'
alias cp='cp -v'
alias mv='mv -v'
alias shell='ps -p $$ -o comm='
alias smlnj='rlwrap sml'
alias coin='rlwrap coin'
alias ocaml='rlwrap ocaml'
alias perl='rlwrap perl'
alias cc='gcc -Wall -W -ansi -pedantic -O2 '
alias valgrind-leak='valgrind --leak-check=full --show-reachable=yes'

# pdflatex with cleanup
cpdflatex() {
  pdflatex $1
  x=${1%.tex}
  rm $x.log
  rm $x.out
  rm $x.aux
}
