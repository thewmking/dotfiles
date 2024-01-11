# Path to your oh-my-zsh installation.
export ZSH="/Users/matthewking/.oh-my-zsh"

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git ruby capistrano gem rails rake rvm)

source $ZSH/oh-my-zsh.sh

# User configuration

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

export EDITOR="vim"

# custom commands

mkcd () {
  mkdir "$1"
  cd "$1"
}

# aliases
alias yrd="yarn run dev"
alias yrr="yarn run release"
alias yrs="yarn run serve"
alias rs="bundle exec rails s"
alias rc="bundle exec rails c"
alias migrate="bundle exec rake db:migrate"
alias create="bundle exec rake db:create"
alias drop="bundle exec rake db:drop"
alias rollback="bundle exec rake db:rollback"
alias bi="bundle install"
alias gb="gem install bundler"
alias deploy="bundle exec cap production deploy"
alias deployc="bundle exec cap production deploy:check"
alias deploys="bundle exec cap staging deploy"
alias rebase="git rebase master"
alias prebase="git pull --rebase"
alias gc="git checkout"
alias gs="git switch"
alias gcp="git cherry-pick"
alias merge="git merge"
alias dcu="docker-compose up"
alias dcd="docker-compose down"
alias bx="bundle exec"
alias cat="bat"

alias brname="ruby /Users/mk/desktop/dev/personal/branch_namer/branch_namer.rb"