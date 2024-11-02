## wip for eternity

### Contents

- xdg_config
  > Shared configuration that will go to `$XDG_CONFIG_HOME` (`~/.config`).
- home
  > Shared configuration that will go to home directory.
- Brewfile

### Usage

- Run `sh install.sh` or manually symlink:

  - xdg_config files to ~/.config
    > `ln -s ~/absolute-path-to-this/xdg_config/a ~/.config/`
  - home files to ~
    > `ln -s ~/absolute-path-to-this/home/a ~/`

- `brew bundle --file=~/code/.dotfiles/Brewfile`
- Import ./manual/RectangleConfig.json to rectangle
- curl -o ~/.zsh/git-completion.bash https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash
- curl -o ~/.zsh/_git https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.zsh
- Set environment variables in ~/.zshenv: TMTL_CONFIG_PATH, TMTL_START_PATH

