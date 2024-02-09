alias ls='ls -la --color=auto'
alias grep='grep --color=auto'
alias vi='nvim'

HISTSIZE=-1
HISTFILESIZE=-1

eval "$(starship init bash)"

backup() {
    mkdir -p ~/.dotfiles/pacman
    pacman -Qqen > ~/.dotfiles/pacman/pkglist-repo.txt
    pacman -Qqem > ~/.dotfiles/pacman/pkglist-aur.txt
}
