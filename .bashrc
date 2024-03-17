alias ls='exa -la --color=auto'
alias grep='grep --color=auto'
alias vi='nvim'

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

export FZF_DEFAULT_COMMAND='fd --type f --strip-cwd-prefix --hidden --follow --exclude .git'
export FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS \
  --color=fg:#c0caf5,bg:#1a1b26,hl:#ff9e64 \
  --color=fg+:#c0caf5,bg+:#292e42,hl+:#ff9e64 \
  --color=info:#7aa2f7,prompt:#7dcfff,pointer:#7dcfff \
  --color=marker:#9ece6a,spinner:#9ece6a,header:#9ece6a"

bind -x '"\C-n":nvim $(fzf)'
