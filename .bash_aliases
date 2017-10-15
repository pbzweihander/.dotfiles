alias ls='ls --color=auto'
alias ll='ls --color=auto -lF'
alias la='ls --color=auto -AlF'
alias lh='ls --color=auto -AlhF'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias diff='diff --color=auto'
alias vi=vim
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias ccd='cd ..'
alias cdd='cd $OLDPWD'

# ssh
alias sshmartini='ssh sd852456@martini.snucse.org'
alias sshcosmo='ssh thomas@147.46.241.244'
alias sshhelma='ssh -i ~/.ssh/id_rsa.helma thomas@helma.pbzweihander.me'
alias sshtrude='ssh -i ~/.ssh/id_rsa.trude thomas@pbzweihander.me'
alias moshhelma='mosh --ssh="ssh -i ~/.ssh/id_rsa.helma" thomas@helma.pbzweihander.me'
alias moshtrude='mosh --ssh="ssh -i ~/.ssh/id_rsa.trude" thomas@pbzweihander.me'

#
# rust
#

# cargo
alias cn='cargo new'
alias cnb='cargo new --bin'
alias cc='cargo check'
alias cb='cargo build'
alias cbr='cargo build --release'
alias ct='cargo test'
alias cr='cargo run'
alias crr='cargo run --release'

# clippy
alias ccl='cargo clippy'

# cargo-edit
alias ca='cargo add'
alias cu='cargo upgrade'
alias crm='cargo rm'

#
# exa
#

alias e='exa --group-directories-first'
alias ea='exa -a --group-directories-first'
alias el='exa -l --group-directories-first'
alias ela='exa -al --group-directories-first'
alias et='exa -T --group-directories-first'
alias eg='exa -l --git'

