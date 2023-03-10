# dots

> This is a bare repo. The structure resembles your `$HOME`

The setup scripts will install and configure a minimal amount of applications, command line tools, and other packages. See [brewfile](https://github.com/mvllow/dots/blob/main/.config/dots/brewfile) for specifics.

A written walkthrough can be found in the wiki's [macOS setup](https://github.com/mvllow/dots/wiki/macOS-setup).

## Usage

One liner to download and run the setup script. Unless our souls match, you may consider modifying a fork versus running this directly.

```sh
curl -LJO https://raw.githubusercontent.com/nnlychai/dots/main/.config/dots/setup.sh && ./setup.sh
```

## Manual installation

> To learn how to use a bare git repo for your own dotfiles, check out [postylem/dotfiles](https://github.com/postylem/dotfiles)

Clone to a temp directory

```sh
git clone \
  --separate-git-dir=$HOME/dots.git \
  https://github.com/nnlychai/dots.git \
  dots-tmp
```

Copy working tree snapshot from the temp directory to the home directory, then delete the temp directory.

```sh
rsync --recursive --verbose --exclude '.git' dots-tmp/ $HOME/
rm -rf dots-tmp
```

Optionally, add an alias to manage your dots directly.

```sh
alias .git='git --git-dir=$HOME/dots.git/ --work-tree=$HOME'
```

## Preferences

> For all options, search for "defaults" in [dots.sh](https://github.com/nnlychai/dots/blob/main/.github/dots.sh)

### System

- Dock sizing, orientation, and shown apps
- Keyboard key repeat, smart punctuation, and auto capitalise/correct
- Menubar appearance
- Trackpad behaviour and speed

### Applications

- Finder locations and views
- Screencapture locations and shadows
- Rectangle behaviour

## Notes

> All notes can be found in the [wiki](https://github.com/mvllow/dots/wiki)

- [Using a custom shell](https://github.com/mvllow/dots/wiki/Using-a-custom-shell)
- [Signing git commits with GPG](https://github.com/mvllow/dots/wiki/Signing-git-commits-with-GPG)
- [Update kitty config from neovim](https://github.com/mvllow/dots/wiki/Update-kitty-config-from-neovim)

## FAQ

- Theme used is [Ros?? Pine](https://github.com/rose-pine/rose-pine-theme)
- Inspired by [mvllow/dots](https://github.com/mvllow/dots)
