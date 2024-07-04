source $HOME/.bash_aliases

HISTSIZE=-1
HISTFILESIZE=-1

# enable bash completion in interactive shells
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

eval "$(starship init bash)"
eval "$(zoxide init bash)"

bind -x '"\C-n":nvim $(fzf)'

export EDITOR='nvim'
export FZF_DEFAULT_COMMAND='fd --type f --strip-cwd-prefix --hidden --follow --exclude .git'
export FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS \
  --bind 'ctrl-d:preview-up' \
  --bind 'ctrl-f:preview-down' \
  --ansi \
  --reverse \
  --no-scrollbar \
  --border=rounded \
  --tabstop=2 \
  --preview '$HOME/scripts/fzf-preview.sh {}' \
  --color=bg+:#283457 \
  --color=bg:#16161e \
  --color=border:#27a1b9 \
  --color=fg:#c0caf5 \
  --color=gutter:#16161e \
  --color=header:#ff9e64 \
  --color=hl+:#2ac3de \
  --color=hl:#2ac3de \
  --color=info:#545c7e \
  --color=marker:#ff007c \
  --color=pointer:#ff007c \
  --color=prompt:#2ac3de \
  --color=query:#c0caf5:regular \
  --color=scrollbar:#27a1b9 \
  --color=separator:#ff9e64 \
  --color=spinner:#ff007c \
"
