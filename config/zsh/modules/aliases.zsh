# Aliases
alias ls='eza --color=always --long --git --icons=always --no-time --no-user --no-permissions --group-directories-first'
alias la='eza --color=always --long --git --icons=always --no-time --no-user --all --group-directories-first'
alias lt='eza --color=always --long --git --no-filesize --icons=always --no-time --no-user --no-permissions --all --tree --level=3 --group-directories-first'
alias venv="source .venv/bin/activate"
alias icat="kitten icat"
alias docker-compose="docker compose"
alias django="python3 manage.py"
alias github='xdg-open "$(git remote get-url origin | sed "s/git@github.com:/https:\/\/github.com\//; s/\.git$//")"'

# theme builder
alias build-theme="$HOME/.theme/build.sh"
