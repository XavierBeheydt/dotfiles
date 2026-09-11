# Copyright (c) 2026 Xavier Beheydt <xavier.beheydt@gmail.com>

# Replace ls with eza
alias ls='eza -al --color=always --group-directories-first --icons=always' # preferred listing
alias la='eza -a --color=always --group-directories-first --icons=always'  # all files and dirs
alias ll='eza -l --color=always --group-directories-first --icons=always'  # long format
alias lt='eza -aT --color=always --group-directories-first --icons=always' # tree listing
alias l.="eza -a | grep -e '^\.'"

alias untar='tar -zxvf'

alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ......='cd ../../../../..'
alias dir='dir --color=auto'
alias vdir='vdir --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

## Pacman / paru maintenance
alias update='paru -Syu'                        # full system + AUR update
alias orphans='pacman -Qtdq'                     # list orphaned packages (no removal)
alias cleanup='sudo pacman -Rns (pacman -Qtdq)'  # remove orphaned packages
alias pacnew='sudo -E pacdiff'                   # review/merge .pacnew files
alias fixpacman='sudo rm /var/lib/pacman/db.lck' # clear a stale pacman lock
alias big="expac -H M '%m\t%n' | sort -h | nl"                                # installed packages sorted by size
alias rip="expac --timefmt='%Y-%m-%d %T' '%l\t%n %v' | sort | tail -200 | nl" # recently installed packages

## Process monitoring
alias psmem='ps auxf | sort -nr -k 4'            # processes by memory usage
alias psmem10='ps auxf | sort -nr -k 4 | head -10'

## systemd
alias sctl='systemctl'
alias sctlu='systemctl --user'
alias jctl='journalctl -xe'
alias jerr='journalctl -p 3 -xb'  # errors only

## Snapper (root-only config)
alias snaps='snapper -c root list'
