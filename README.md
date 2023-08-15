## wip for eternity

### Contents

- xdg_config
  > Shared configuration that will go to `$XDG_CONFIG_HOME` (generally, `~/.config`).
- home
  > Shared configuration that will go to home directory.
- Brewfile

### Usage

- Run `sh install.sh` or manually symlink:

  - xdg_config files to ~/.config
    > `ln -s ~/absolute-path-to-this/xdg_config/a ~/.config/`
  - home files to ~
    > `ln -s ~/absolute-path-to-this/home/a ~/`

- Set environment variables in ~/.zshenv: TMTL_WORK_PATH, TMTL_PERSONAL_PATH, TMTL_CONFIG_PATH, TMTL_START_PATH
- Run brew install over Brewfile for all software to be installed
