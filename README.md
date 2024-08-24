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

- Run brew install over Brewfile for all software to be installed
- Set environment variables in ~/.zshenv: TMTL_CONFIG_PATH, TMTL_START_PATH
