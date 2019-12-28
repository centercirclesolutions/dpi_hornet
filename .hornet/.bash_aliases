#bash essentials
export LS_OPTIONS='--color=auto'
eval "`dircolors`"
alias ls='ls $LS_OPTIONS'
alias ll='ls $LS_OPTIONS -l'
alias l='ls $LS_OPTIONS -lA'
alias ..='cd ..'
alias ...='cd ../../../'
alias ....='cd ../../../../'
alias grep='grep --color=auto'
alias h='history'
alias j='jobs -l'
alias path='echo -e ${PATH//:/\\n}'
alias now='date +"%T"'
alias nowtime=now
alias nowdate='date +"%d-%m-%Y"'
alias vi=vim
alias svi='sudo vi'
alias psum='ss -s'
alias ports='ss -aute'
alias portsn='ss -auter'
alias aliasf='declare -F'

#apt
alias apt-get="sudo apt-get"
alias updatey="apt-get --yes"
alias update='apt-get update && apt-get upgrade'