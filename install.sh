#!/bin/bash

# Flags to determine if the arguments were passed
noninteractive_flag=false

# Loop through all arguments
for arg in "$@"
do
    case $arg in
        --non-interactive|-n)
            noninteractive_flag=true
            ;;
        *)
            # Handle any other arguments or provide an error message
            ;;
    esac
done

if command -v zsh &> /dev/null && command -v git &> /dev/null && command -v wget &> /dev/null && command -v fzf &> /dev/null && command -v rlwrap &> /dev/null; then
    echo -e "zsh git wget fzf rlwrap are already installed\n"
else
    if sudo apt install -y zsh git wget autoconf fzf rlwrap xsel || sudo pacman -S zsh git wget fzf rlwrap xsel || sudo dnf install -y zsh git wget fzf rlwrap xsel || sudo yum install -y zsh git wget fzf rlwrap xsel || sudo brew install git zsh wget fzf rlwrap xsel || pkg install git zsh wget fzf rlwrap xsel; then
        echo -e "zsh git wget autoconf fzf rlwrap xsel Installed\n"
    else
        echo -e "Please install the following packages first, then try again: zsh git wget autoconf fzf rlwrap xsel \n" && exit
    fi
fi

# INSTALL FONTS
echo -e "Installing Nerd Fonts version of Hack, Roboto Mono, DejaVu Sans Mono\n"

wget -q --show-progress -N https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/Hack/Regular/HackNerdFont-Regular.ttf -P ~/.fonts/
wget -q --show-progress -N https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/RobotoMono/Regular/RobotoMonoNerdFont-Regular.ttf -P ~/.fonts/
wget -q --show-progress -N https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/DejaVuSansMono/Regular/DejaVuSansMNerdFont-Regular.ttf -P ~/.fonts/

fc-cache -fv ~/.fonts

if mv -n ~/.zshrc ~/.zshrc-backup-$(date +"%Y-%m-%d"); then # backup .zshrc
    echo -e "Backed up the current .zshrc to .zshrc-backup-date\n"
fi

echo -e "Installing oh-my-zsh\n"
if [ -d ~/.oh-my-zsh ]; then
    echo -e "oh-my-zsh in already installed at '~/.oh-my-zsh'."
else
    RUNZSH=no sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

echo -e "Copy .zshrc\n"
cp -f .zshrc ~/

mkdir -p ~/.cache/zsh/                # this will be used to store .zcompdump zsh completion cache files which normally clutter $HOME
mkdir -p ~/.fonts                     # Create .fonts if doesn't exist

if [ -f ~/.zcompdump ]; then
    mv ~/.zcompdump* ~/.cache/zsh/
fi

# INSTALL CUSTOM PLUGINS
echo -e "Install custom plugins\n"

if [ -d ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions ]; then
    cd ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions && git pull
else
    git clone --depth=1 https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
fi

if [ -d ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting ]; then
    cd ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting && git pull
else
    git clone --depth=1 https://github.com/zsh-users/zsh-syntax-highlighting ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
fi

if [ -d ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-completions ]; then
    cd ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-completions && git pull
else
    git clone --depth=1 https://github.com/zsh-users/zsh-completions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-completions
fi

if [ -d ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-history-substring-search ]; then
    cd ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-history-substring-search && git pull
else
    git clone --depth=1 https://github.com/zsh-users/zsh-history-substring-search ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-history-substring-search
fi

if [ -d ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/alias-tips ]; then
    cd ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/alias-tips && git pull
else
    git clone --depth=1 https://github.com/djui/alias-tips ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/alias-tips
fi

if [ -d ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/k ]; then
    cd ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/k && git pull
else
    git clone --depth 1 https://github.com/supercrabtree/k ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/k
fi

# Install cht.sh

if [ ! -f /usr/local/bin/cht.sh ]; then
    curl https://cht.sh/:cht.sh > "$HOME/bin/cht.sh"
    chmod +x $HOME/bin/cht.sh
fi

if [ "$noninteractive_flag" = true ]; then
    echo -e "Installation complete, exit terminal and enter a new zsh session\n"
    echo -e "Make sure to change zsh to default shell by running: chsh -s $(which zsh)"
else
    echo -e "\nSudo access is needed to change default shell\n"

    if chsh -s $(which zsh) && /bin/zsh -i -c 'omz update'; then
        echo -e "Installation complete, exit terminal and enter a new zsh session"
    else
        echo -e "Something is wrong"

    fi
fi
exit
