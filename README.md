## wip for eternity

## Contents

- xdg_config
  > Shared configuration that will go to `$XDG_CONFIG_HOME` (generally, `~/.config`).
- home
  > Shared configuration that will go to home directory.

### Usage

- symlink everything inside xdg_config folder to ~/.config
  > `ln -s ~/absolute-path-to-this-xdg_config/a ~/.config/`
- symlink everything inside home folder to home path
  > `ln -s ~/absolute-path-to-this-home/a ~/`
