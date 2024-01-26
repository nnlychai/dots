function match_system_theme
    set -q THEME
    set dark_mode $(dark-mode status)

    if test "$dark_mode" = on
        set -U THEME rose-pine
    else
        set -U THEME rose-pine-dawn
    end

    set_kitty_theme "$THEME"
end
