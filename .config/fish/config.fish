# Set env variables
# For more information on XDG paths:
# https://wiki.archlinux.org/title/XDG_Base_Directory
set -gx XDG_CACHE_HOME $HOME/.cache
set -gx XDG_CONFIG_HOME $HOME/.config
set -gx XDG_DATA_HOME $HOME/.local/share
set -gx XDG_STATE_HOME $HOME/.local/state

set -gx CARGO_HOME $XDG_DATA_HOME/cargo
set -gx GOPATH $XDG_DATA_HOME/go

if type -q nvim
	set -gx EDITOR nvim
else
	set -gx EDITOR vim
end

# Set binary paths
fish_add_path /opt/homebrew/bin
fish_add_path $CARGO_HOME/bin
fish_add_path $GOPATH/bin
fish_add_path $HOME/.local/bin

if status is-interactive
    # Remove new shell greeting
    set fish_greeting

    # Match theme to system on start
    set_theme system

    # Terminal tab title
    function fish_title
        echo (string split -- / $PWD)[-1]
    end

    function fish_prompt
        printf '%s%s> ' (fish_prompt_pwd_dir_length=0 prompt_pwd) (set_color brblack; fish_git_prompt; set_color normal)
    end

    function fish_user_key_bindings
        # Toggle theme via <super+l>
        bind \e\[108\;9u set_theme
    end
end

# Skip aliased builtins via `command ls`
alias ls "ls -a"
alias vim "vim -c 'lcd %:p:h' $argv"
alias nvim "nvim -c 'lcd %:p:h' $argv"
alias rm trash

abbr --add ,dots "$EDITOR ~/.config/dots/setup.sh"
abbr --add ,fish "$EDITOR ~/.config/fish/config.fish"
abbr --add ,git "$EDITOR ~/.config/git/config"
abbr --add ,kitty "$EDITOR ~/.config/kitty/kitty.conf"
abbr --add ,lazygit "$EDITOR ~/.config/lazygit/config.yml"
abbr --add ,music "$EDITOR ~/.config/yt-dlp/music.conf"
abbr --add ,nvim "$EDITOR ~/.config/nvim/init.lua"

set dotgit_args "--git-dir=\$HOME/dots.git --work-tree=\$HOME"

abbr --add .git "git $dotgit_args"
abbr --add .lazygit "lazygit $dotgit_args"
abbr --add .ls "git $dotgit_args ls-files --others --no-empty-directory --exclude-standard \$XDG_CONFIG_HOME/*"
