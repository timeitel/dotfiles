## wip for eternity

### Usage
  - symlink the .config folder 
  >  `ln -s /absolute-path/to/.config/* ~/`
  - symlink the contents of home folder to home path
  >  `ln -s /absolute-path/to/home/* ~/`
  - pmake sure new location is checked for hammerspoon:
  >  `defaults write org.hammerspoon.Hammerspoon MJConfigFile "~/.config/hammerspoon/init.lua"`
