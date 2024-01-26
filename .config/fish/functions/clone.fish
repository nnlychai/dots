# @usage
#
# clone dots
# 	=> clones git@github.com:<user>/dots to ./dots
# clone mvllow/pinecone
# 	=> clones git@github.com:mvllow/pinecone to ./mvllow-pinecone
# clone rose-pine/neovim
# 	=> clones git@github.com:rose-pine/neovim to ./rose-pine-neovim
function clone -w "git clone" -a input -d "Clone remote repository"
    string match -rq '(?<user>.*)?\/(?<repo>.*)' -- $input

    if test -n "$repo"
        set source "$input"
        # Strip user name from repo name
        # @example mvllow/dots => dots
        # @example rose-pine/neovim => rose-pine-neovim
        # @example rose-pine/rose-pine-site => rose-pine-site
        if [ "$user" != "$repo" ]
            set output $(string replace "$user-$user-" "$user-" "$user-$repo")
        else
            set output "$repo"
        end
    else
        set source "$(git config --get user.name)/$input"
        set output "$input"
    end

    if test $argv[2]
        git clone git@github.com:$source.git $argv[2..]
        cd "$argv[2]"
    else
        git clone git@github.com:$source.git $output
        cd "$output"
    end
end
