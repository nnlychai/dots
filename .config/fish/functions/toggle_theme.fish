function toggle_theme
    set -q THEME
    set dark_mode $(dark-mode status)

    if test "$dark_mode" = on
        set -U THEME rose-pine-dawn
    else
        set -U THEME rose-pine
    end

    set_kitty_theme "$THEME"

    # Toggle system theme last because it takes longer
    dark-mode
end
