./catLogs.sh /var/log/dpkg.log | grep "(install \|remove\|upgrade)" | grep --color=auto $1
