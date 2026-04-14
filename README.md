# My Dotfiles

These dotfiles are configured to my liking and support my setup of zsh, WezTerm, tmux, and Neovim. I primarily work with TypeScript, React/Next.js, Java Spring Boot, and Python FastAPI, and I’m currently learning Rust and systems programming.

### Installation Guide

- Clone the repo

```bash
cd ~
git clone git@github.com:PrassesKhadka/dotfiles.git
```

#### Packages

Make sure you have these packages installed

- [eza](https://github.com/eza-community/eza/blob/main/INSTALL.md)
- [bat](https://github.com/sharkdp/bat)
- [zoxide](https://github.com/ajeetdsouza/zoxide?tab=readme-ov-file#installation)
- [fzf](https://github.com/junegunn/fzf?tab=readme-ov-file#installation)
- [ripgrep](https://github.com/BurntSushi/ripgrep)
- [golang](https://go.dev/doc/install) 
- [cargo](https://doc.rust-lang.org/cargo/getting-started/installation.html)
- [lazygit](https://github.com/jesseduffield/lazygit?tab=readme-ov-file#installation)
- [lazydocker](https://github.com/jesseduffield/lazydockerhttps://github.com/jesseduffield/lazydocker) 
- [nvm](https://github.com/nvm-sh/nvm)
- [pyenv](https://github.com/pyenv/pyenv) 
- [openjdk-21-jdk](https://openjdk.org/projects/jdk/21/)

```bash
sudo apt install eza
sudo apt install bat
sudo apt install zoxide

# For fzf
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install

sudo apt-get install ripgrep

# For lazygit
LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | \grep -Po '"tag_name": *"v\K[^"]*')
curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/download/v${LAZYGIT_VERSION}/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
tar xf lazygit.tar.gz lazygit
sudo install lazygit -D -t /usr/local/bin/

# For go
sudo apt install golang-go

# For lazydocker
curl https://raw.githubusercontent.com/jesseduffield/lazydocker/master/scripts/install_update_linux.sh | bash

# For nvm
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash

# For Java
sudo apt install openjdk-21-jdk
```

#### Zsh

- Install [zsh](https://github.com/ohmyzsh/ohmyzsh/wiki/Installing-ZSH) , [oh-my-zsh](https://github.com/ohmyzsh/ohmyzsh/wiki) and [powerlevel-10k](https://github.com/romkatv/powerlevel10k?tab=readme-ov-file#oh-my-zsh)

```bash
# zsh
sudo apt install zsh

# oh my zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Powerlevel10k
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/themes/powerlevel10k

# Install all necessary plugins specified in .zshrc file
# plugins=(git zsh-autosuggestions sudo web-search copyfile jsontools zsh-syntax-highlighting vi-mode fzf)
```

#### Wezterm

- Install wezterm: https://wezterm.org/install/linux.html and set it as a startup application with startup cmd as `cd Desktop/code & wezterm`

#### GNU Stow

I use GNU stow to symlink my dotfiles

- Install [GNU stow](https://www.gnu.org/software/stow/) to symlink the dotfiles

```bash
sudo apt install stow
```

and then to symlink dotfiles

```bash
./install.zsh
```

and then to source the latest zshrc

```bash
source ~/.zshrc
```

#### Tmux

- Install tmux here: https://github.com/tmux/tmux/wiki/Installing


```bash
sudo apt install tmux
```

Setup [tpm](https://github.com/tmux-plugins/tpm)

```bash
git clone https://github.com/tmux-plugins/tpm ~/.config/tmux/.tmux/plugins/tpm
tmux source-file ~/.config/tmux/tmux.conf
```

Now to install all the plugins for tmux

```
Prefix Key is Ctrl+b
To Install Plugins: <Prefix>I
```

To source your tmux config

```
 tmux source-file ~/dotfiles/tmux/.config/tmux/tmux.conf  
```

#### Neovim

- Install [Neovim](https://github.com/neovim/neovim) from source

Currently all the configurations are for Neovim `0.12`, including `nvim-treesitter`.

##### `nvim-treesitter` on Neovim `0.12`

With the new `nvim-treesitter` setup for Neovim `0.12`, parser compilation is handled outside startup.
This config no longer runs parser installs on every launch, which avoids noisy startup failures when
`tree-sitter-cli` is missing or not set up yet.

You still need `tree-sitter-cli` available in your shell `PATH` for parser installs and updates.

###### Install `tree-sitter-cli`

Use your system package manager or Cargo. Avoid the older npm-based global install if possible.

```bash
cargo install tree-sitter-cli
```

###### Quick sanity check

```bash
tree-sitter --version
which tree-sitter
```

###### After setup

```vim
:Lazy sync
:TSUpdate
:checkhealth nvim-treesitter
```

```bash
nvim --version
cd ~/dotfiles
nv
```

## External toolings
- [jarexplorer](https://dst.in.ua/jarexp/)

## Thanks / Shoutout / Inspired By

- The nvim config here is built on top of [ https://github.com/muhammadzkralla/zvim.nvim ]
- The tmux config here is built on top of [ https://github.com/Sin-cy/dotfiles ]
- The LSP related configuration including integration with blink-cmp, fzf, conform was built using: [ https://github.com/jakobwesthoff/nvim-from-scratch/tree/main ] and corresponding youtube link [ https://www.youtube.com/watch?v=b17g20II6SQ&list=PLy68GuC77sURrnMNi2XR1h58m674KOvLG ]
- For more Neovim Configuration tips: [ https://alpha2phi.medium.com/learn-neovim-the-practical-way-8818fcf4830f ]
- [ https://github.com/josean-dev/dev-environment-files ]
- [ https://github.com/MariaSolOs/dotfiles ]
- [ https://github.com/davidosomething/dotfiles/tree/dev/nvim ]
- [ https://github.com/jugarpeupv/dotfiles/tree/main/nvim/.config/nvim ]
