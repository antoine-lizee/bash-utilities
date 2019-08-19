##DEBUG
echo "Launching local .bash_profile"

# First is for light themes
export PS1_BASE="\[\033[36m\]\u\[\033[m\]@\[\033[32m\]\h:\[\033[33;1m\]\w\[\033[m\]"
export PS1="$PS1_BASE\$ "
#export PS1="\[\e[0;31m\]$PWD\[\e[0m\]@\[\e[0;32m\]\h\[\e[0m\]:\[\e[0;34m\]\w\[\e[0m\]\$"
#export PS1="\[\e]0;\u@\h: \w\a\]${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$"
export CLICOLOR=1
export LSCOLORS=ExFxBxDxCxegedabagacad
export LSCOLORS=GxFxCxDxBxegedabagaced

if [ -f ~/.git-completion.bash ]; then
    source ~/.git-completion.bash
fi

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

##PATH_ADD: Ruby versioning utility
export PATH="$HOME/.rbenv/bin:$PATH"

# GO compliance and export path
export GOPATH=/media/FD/GO/gocode
export PATH=$PATH:$GOPATH/bin

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

## For rbenv
eval "$(rbenv init -)"

## JAVA SELECTOR TRICK
# use /usr/libexec/java_home:
export JAVA_8_HOME=$(/usr/libexec/java_home -v1.8)
export JAVA_7_HOME=$(/usr/libexec/java_home -v1.7)

alias java7='export JAVA_HOME=$JAVA_7_HOME'
alias java8='export JAVA_HOME=$JAVA_8_HOME'

#default java8
export JAVA_HOME=$JAVA_7_HOME

# added by Anaconda3 4.0.0 installer
export PATH="/Users/alizee/anaconda3/bin:$PATH"

# For pdf generation libraries
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

## put git branch in PS1 #########
## Get git branch
function current_git_branch {
    git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/[\1]/"
}

# Build prompt
function prompt_command {
    # Some defaults:
	RED='\[\e[1;31m\]'
	NC='\[\e[0m\]'
	green='\[\e[0;32m\]'
	cyan='\[\e[0;36m\]'

    # Check for modified files
    if [[ $(git diff-files 2> /dev/null | cat) != "" ]]; then
        git_color=${RED}
    else
        git_color=${NC}
    fi

    # Check for staged files
    if [[ $(git diff-index --cached HEAD 2> /dev/null | cat) != "" ]]; then
        cached_files="${green} ●"
    else
        cached_files=""
    fi

    # Check for untracked files
    untracked_files=""
    if [[ $(git ls-files --exclude-standard --others 2> /dev/null | cat) != "" ]]; then
        untracked_files="${cyan} ●"
    else
        untracked_files=""
    fi

    virtual_env=""
    if [[ $VIRTUAL_ENV ]]; then
        virtual_env="${grey}(`basename $VIRTUAL_ENV`)${grey} "
    fi

    export PS1="${virtual_env}$PS1_BASE${git_color}\$(current_git_branch)${cached_files}${untracked_files}${NC}\n\$ "

    ### This is needed to update the cwd so the next window knows where to start:
    update_terminal_cwd
}

PROMPT_COMMAND=prompt_command

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
