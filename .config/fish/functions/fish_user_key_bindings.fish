# Use fish_key_reader to get escape sequences
function fish_user_key_bindings
    # ctrl+t
    bind \cT toggle_theme

    # ctrl+f
    bind \cF ~/.local/bin/tmux-sessions
end
