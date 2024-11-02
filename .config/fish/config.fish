set -x PATH "/usr/local/bin:/home/hamze/.local/bin:/bin:/sbin:/usr/bin:/usr/sbin"
set -x LD_LIBRARY_PATH "/usr/lib64"
#set -U fish_greeting "" | cowsay " me is hucker, you is fucker"
fastfetch --logo ~/Downloads/386460_fedora_icon.png --logo-width 45

starship init fish | source
alias codegpt="~/.local/share/nvim/lazy/tabnine-nvim/chat/target/release/tabnine_chat"
export LD_LIBRARY_PATH=0
#alias nvim="nvim $(pwd)"
alias ckear="clear"
alias celar="clear"
alias ll="lsd -l"
alias la="lsd -la"
alias ls="lsd"
alias lazyvim="NVIM_APPNAME=lazyvim nvim"
alias testvim="NVIM_APPNAME=testvim nvim"