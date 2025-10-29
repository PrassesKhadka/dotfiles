<!-- ## Setting Up Locally -->
<!--     -->
<!--    - Build neovim from source -->
<!--    4 - set the installation location: `${HOME}/.local` -->
<!--    5 ``` -->
<!--    6 make CMAKE_BUILD_TYPE=Release \ -->
<!--    7 CMAKE_INSTALL_PREFIX=$HOME/.local install -->
<!--    8 ``` -->
<!--    9 - setup the bin path `${HOME}/.local/bin` in your .zshrc or .bashrc -->
<!--   10 - setup your nvim config -->
<!--   11  ```bash -->
<!--   12 # Update package lists -->
<!--   13 sudo apt-get update -->
<!--   14 -->
<!--   15 # Install required packages -->
<!--   16 sudo apt-get install -y neovim -->
<!--   17 sudo apt-get install -y ripgrep -->
<!--   18 sudo apt-get install -y fzf -->
<!--   19 sudo apt-get install -y fd-find -->
<!--   20 sudo apt-get install -y lua5.3 -->
<!--   21 sudo apt-get install -y nodejs npm -->
<!--   22 sudo apt-get install -y gcc -->
<!--   23 sudo apt-get install -y python3-pip -->
<!--   24 sudo apt-get install -y zip unzip -->
<!--   25 -->
<!--   26 # Install trash-cli : -->
<!--   27 # Install pynvim for Python support -->
<!--   28 pip3 install pynvim -->
<!--   29 -->
<!--   30 # Install Rust using rustup -->
<!--   31 curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y -->
<!--   32 -->
<!--   33 # Source cargo environment for Rust -->
<!---->
### GNU Stow

### Thanks / Shoutout / Inspired By

- The nvim config here is built on top of https://github.com/muhammadzkralla/zvim.nvim
- https://github.com/Sin-cy/dotfiles

