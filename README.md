# ezsh

A simple script to setup an awesome shell environment.
Quickly install and setup zsh and oh-my-zsh (<https://github.com/ohmyzsh/ohmyzsh/>) with

* Nerd-Fonts (<https://github.com/ryanoasis/nerd-fonts>)
* zsh-completions (<https://github.com/zsh-users/zsh-completions>)
* zsh-autosuggestions (<https://github.com/zsh-users/zsh-autosuggestions>)
* zsh-syntax-highlighting (<https://github.com/zsh-users/zsh-syntax-highlighting>)
* history-substring-search (<https://github.com/zsh-users/zsh-history-substring-search>)
* k (<https://github.com/supercrabtree/k>)
* alias-tips (<https://github.com/djui/alias-tips>)

Sets following useful aliases and ohmyzsh plugins.

* l="ls -lah"         - just type "l" instead of "ls -lah"
* alias k="k -h"      - show human readable filesizes, in kb, mb etc
* e="exit"
* a='eza -la --git --colour-scale all -g --smart-group --icons always' - eza is the new ls
* myip - (wget -qO- <https://wtfismyip.com/text>)       - what's my ip: quickly find out external IP
* cheat - (<https://github.com/chubin/cheat.sh>)        - cheatsheets in the terminal!
* speedtest - (curl -s <https://raw.githubusercontent.com/sivel/speedtest-cli/master/speedtest.py> | python3 -) run speedtest on the fly
* dadjoke - (curl <https://icanhazdadjoke.com>)         - terminally sick jokes
* [x="extract"](https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/extract)      - extract any compressed files
* [z](https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/z)                      - quickly jump to most visited directories
* [sudo](https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/sudo)                - easily prefix your commands with sudo by pressing `esc` twice

## Installation

Requirements:

* `git` to clone it.
* `python3` or `python` is required to run option '-c' which copies history from .bash_history

``` bash
git clone https://github.com/tobias1610/ezsh.git
cd ezsh
./install.sh -c        # only run with '-c' the first time, running multiple times will duplicate history entries
```

This will install the setup under standard path.
Change your terminal's fonts to either "RobotoMono Nerd Font" or "Hack Nerd Font" or "DejaVu Sans Mono Nerd Fonts".
You can also manually install Nerd Fonts of your choice.

## Notes

* If you are already using zsh, your zsh config will be backed up to .zshrc-backup-date

* If the text/icons look broken, make sure your terminal is using one of the Nerd fonts. [discussion](https://github.com/powerline/fonts/issues/185). I recommend "RobotoMono Nerd Font"

### To Uninstall

To uninstall simply delete ~/.zshrc and ~/.config/ezsh/. The script creates a backup of your original .zshrc in the home folder with the filename indicating it's a backup. Rename it back to .zshrc
