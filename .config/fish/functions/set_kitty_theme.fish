function set_kitty_theme -a theme
    if test "$TERM" = xterm-kitty
        kitty @ set-colors --all --configured "$HOME/.config/kitty/themes/$theme.conf"
        sed -i "" -e \
            "s/include themes\/.*\.conf/include themes\/$theme.conf/" \
            "$HOME/.config/kitty/kitty.conf"
    end
end
