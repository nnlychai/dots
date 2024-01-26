# Use XDG paths for consolidating configuration locations.
# https://wiki.archlinux.org/title/XDG_Base_Directory
set -gx XDG_CACHE_HOME $HOME/.cache
set -gx XDG_CONFIG_HOME $HOME/.config
set -gx XDG_DATA_HOME $HOME/.local/share
set -gx XDG_STATE_HOME $HOME/.local/state

set -gx EDITOR nvim

set -gx CARGO_HOME $XDG_DATA_HOME/cargo
set -gx GOPATH $XDG_DATA_HOME/go

fish_add_path /opt/homebrew/bin
fish_add_path $HOME/.local/bin
fish_add_path $CARGO_HOME/bin
fish_add_path $GOPATH/bin

set fish_greeting

# Open common configuration files.
# @example `,fish` opens ~/.config/fish/config.fish in $EDITOR
set -l configs "fish/config.fish" "kitty/kitty.conf" "nvim/init.lua" "yt-dlp/music.conf" lf/lfrc git/config "lazygit/config.yml"
for config in $configs
    set app (string split "/" $config)[1]
    set file "~/.config/$config"
    abbr ",$app" "$EDITOR $file"
end

alias vim nvim

abbr ta "tmux attach"
abbr tn "tmux new -s (basename (pwd))"

# Helpers to manage our dotfiles bare repo.
# https://github.com/mvllow/dots
set dots_repo "--git-dir=\$HOME/dots.git --work-tree=\$HOME"
abbr .git "git $dots_repo"
abbr .lazygit "lazygit $dots_repo"
