test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"

export LC_ALL=en_US.UTF-8

# Setup color in terminal
export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagaced
PS1='\[\e[1;32m\][\u@\h \W]\$\[\e[0m\] '

# Setting PATH for Python 3.6
# The original version is saved in .profile.pysave
# export PATH="/Library/Frameworks/Python.framework/Versions/3.6/bin:${PATH}"

#export PATH="/Users/nnavarro/Library/Python/3.6/bin:$PATH"

export WORKON_HOME=$HOME/.virtualenvs
export PROJECT_HOME=$HOME/Devel
export VIRTUALENVWRAPPER_VIRTUALENV=/Users/nestornav/Library/Python/2.7/bin/virtualenv
source Library/Python/2.7/bin/virtualenvwrapper.sh

# Pyenv stuff

# For compilers to find readline you may need to set:
export LDFLAGS="-L/usr/local/opt/readline/lib"
export CPPFLAGS="-I/usr/local/opt/readline/include"

# For pkg-config to find readline you may need to set:
export PKG_CONFIG_PATH="/usr/local/opt/readline/lib/pkgconfig"

#export PYENV_ROOT=$HOME/.virtualenvs

# Git
if [ -f ~/.git-completion.bash ]; then
  . ~/.git-completion.bash
fi

parse_git_branch() {
     git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}


# Exports
export PATH=${PATH}:/usr/local/mysql/bin
export PATH="/usr/local/opt/openssl@1.1/bin:$PATH"
export PGDATA="/usr/local/var/postgres/cluster"
export PGLOG="/usr/local/var/postgres/server.log"
export PATH="/usr/local/sbin:$PATH"

# Alias
alias vscode="open -a Visual\ Studio\ Code"
alias python=python3
alias pip=pip3

# Alias git
alias gt="git --help"
alias gts="git status"
alias gtd="git diff"
alias gtl="git log"
alias gtb="git branch"
alias gtr="git remove -v"
alias gtcm="git commit -m"
alias gtp="git pull"
alias gtph="git push"
