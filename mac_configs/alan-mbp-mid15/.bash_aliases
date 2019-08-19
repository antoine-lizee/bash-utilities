echo 'launching bash_aliases'

alias ll='ls -lAGh'

alias psf='ps a -f'

alias most='history | awk '\''{print $2}'\'' | awk '\''BEGIN{FS="|"}{print $1}'\'' | sort | uniq -c | sort -n | tail -n 20 | sort -nr'

alias findDir='find . -type d -maxdepth 4 -iname '

alias ssar='sudo service apache2 restart'

#alias snet='sudo netstat -ltpn'
alias sshc='ssh -X alizee@chablis.ucsf.edu -p 815'
alias sshb='ssh -X alizee@beaujolais.ucsf.edu -p 816'
alias sshch='ssh -X alizee@champagne.ucsf.edu -p 817'

# PERSO
ALAN_HOME='/FD/ALAN'
alias act-lytics='source $ALAN_HOME/alan-lytics/env/bin/activate'
alias act='source ./env/bin/activate'
alias nps='npm install && npm start'
alias startback='cd /FD/ALAN/alan-backend && ttab -d /FD/ALAN/alan-backend "act && flask runserver"'
alias startfront='cd /FD/ALAN/alan-web && ttab -d /FD/ALAN/alan-web nps && ttab -d /FD/ALAN/alan-web/shared nps && ttab -d /FD/ALAN/alan-web "act && flask runserver"'

#AWS
alias ssha='ssh -i ~/.ssh/MainKey.pem ubuntu@ec2-54-148-152-24.us-west-2.compute.amazonaws.com'
#tunneling:
alias sshat='ssh -i ~/.ssh/MainKey.pem -f -L 4200:localhost:4243 ubuntu@ec2-54-148-152-24.us-west-2.compute.amazonaws.com -N'

#DO
alias sshdo='ssh root@45.55.200.158'

#MAC OSX specific
alias top='top -u'

#git
alias gitw="git commit -am WIP"
alias gitp="git pull"
alias gita='git commit --amend -CHEAD'
alias gitr='git fetch && git rebase origin/acceptance'
alias gitb='git checkout acceptance && git pull && git checkout -b '
alias gitlb='git reflog | grep -Eo "moving from ([^ ]*)" | head -10'

# python
alias venv='/usr/local/bin/python3 -m venv'
alias envReinit='rm -rf env; /usr/local/bin/python3 -m venv env && source env/bin/activate && pip install --upgrade pip && pip install -r requirements.txt'

#Powerful tip...
alias sudo='sudo '

#dokku
alias dokku='$HOME/.dokku/contrib/dokku_client.sh'

# heroku shortcuts
alias h="heroku"
alias hl="heroku logs"
alias hlp="heroku logs -r prod"
alias hla="heroku logs -r acceptance"
alias hc="heroku run console"
alias hr="heroku run"
alias hp="heroku ps"
alias prod_to_stage="heroku pg:backups:restore `heroku pg:backups:public-url -a alan-backend` HEROKU_POSTGRESQL_GOLD_URL -r stage"

