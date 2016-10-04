echo 'launching bash_aliases'

alias ll='ls -lAGh'

alias psf='ps a -f'

alias most='history | awk '\''{print $2}'\'' | awk '\''BEGIN{FS="|"}{print $1}'\'' | sort | uniq -c | sort -n | tail -n 20 | sort -nr'

alias ssar='sudo service apache2 restart'

#alias snet='sudo netstat -ltpn'
alias sshc='ssh -X alizee@chablis.ucsf.edu -p 815'
alias sshb='ssh -X alizee@beaujolais.ucsf.edu -p 816'
alias sshch='ssh -X alizee@champagne.ucsf.edu -p 817'

# PERSO
ALAN_HOME='/FD/ALAN'
alias act-lytics='source $ALAN_HOME/alan-lytics/env/bin/activate'
alias act='source ./env/bin/activate'

#AWS
alias ssha='ssh -i ~/.ssh/MainKey.pem ubuntu@ec2-54-148-152-24.us-west-2.compute.amazonaws.com'
#tunneling:
alias sshat='ssh -i ~/.ssh/MainKey.pem -f -L 4200:localhost:4243 ubuntu@ec2-54-148-152-24.us-west-2.compute.amazonaws.com -N'

#DO
alias sshdo='ssh root@45.55.200.158'

#MAC OSX specific
alias top='top -u'

#git
alias gitc="git commit -am "
alias gitp="git pull"
alias gita='git commit --amend -CHEAD'

alias envReinit='rm -rf env; virtualenv env && source env/bin/activate && pip install --upgrade pip && pip install -r requirements.txt'
alias findDir='find . -type d -maxdepth 4 -iname '


#Powerful tip...
alias sudo='sudo '

#dokku
#alias dokku='$HOME/.dokku/contrib/dokku_client.sh'
