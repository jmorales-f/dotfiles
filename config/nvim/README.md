# Dotfiles
Please make my life easier

## Installation

*   Git setup
    ```bash
    sh git-setup.sh # or whatever name you gave it
    ```
*   Apt stuff
    ```bash
    sudo apt update
    sudo apt upgrade
    ```
    ```bash
    sudo apt install ansible curl ca-certificates python3 zsh vim fzf bat ripgrep neovim lua5.1 luarocks kitty golang
    ```
    ```bash
    ansible-playbook --become-user $(whoami) setup.yml
    ```
*   Set ZSH as default shell
    ```bash
    chsh -s $(which zsh)
    ```
*   Npm <br>
https://nodejs.org/en/download/package-manager

*   Docker <br>
https://docs.docker.com/engine/install/ubuntu/

## Extras

*   <a href="https://www.programmingfonts.org/#firacode">Font</a>

*   To get the color scheme in windows use ```windows-theme.json```
