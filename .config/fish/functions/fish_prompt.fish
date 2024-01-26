# function fish_prompt
#     match_system_theme
#     set -gx __fish_git_prompt_showdirtystate 1
#     printf '%s%s> ' (fish_prompt_pwd_dir_length=0 prompt_pwd) (set_color brblack; fish_git_prompt; set_color normal)
# end

function fish_prompt
    match_system_theme &

    set_color cyan
    echo -n "→ "
    set_color normal
    echo -n (prompt_pwd)

    # Use fish_git_prompt to display Git information
    set -gx __fish_git_prompt_showdirtystate 1
    set -gx __fish_git_prompt_showstashstate 1
    set -gx __fish_git_prompt_showuntrackedfiles 1
    set -gx __fish_git_prompt_showupstreamstate 1
    set_color brblack
    fish_git_prompt

    set_color normal
    echo -n "> "
end

# function fish_prompt
#     set_color cyan
#     echo -n "→ "
#     set_color normal
#     echo -n (prompt_pwd)
#
#     # Check if the current directory is a Git repository
#     if git rev-parse --is-inside-work-tree >/dev/null 2>&1
#         set_color normal
#         echo -n "|"
#         set_color brblack
#         echo -n (git symbolic-ref --short HEAD)
#
#         # Check if the Git repository is dirty
#         if git diff --quiet >/dev/null 2>&1
#             set_color red
#             echo -n "*"
#         end
#     end
#
#     set_color normal
#     echo -n "> "
# end
