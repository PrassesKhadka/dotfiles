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
- [fd](https://github.com/sharkdp/fd) (file listing for fzf, previews and tmux-sessionizer)
- [zoxide](https://github.com/ajeetdsouza/zoxide?tab=readme-ov-file#installation)
- [fzf](https://github.com/junegunn/fzf?tab=readme-ov-file#installation)
- [ripgrep](https://github.com/BurntSushi/ripgrep)
- [golang](https://go.dev/doc/install) 
- [cargo](https://doc.rust-lang.org/cargo/getting-started/installation.html)
- [lazygit](https://github.com/jesseduffield/lazygit?tab=readme-ov-file#installation)
- [lazydocker](https://github.com/jesseduffield/lazydocker) 
- [yazi](https://github.com/sxyazi/yazi) (terminal file manager, see the Yazi section)
- [nvm](https://github.com/nvm-sh/nvm)
- [pyenv](https://github.com/pyenv/pyenv) 
- [openjdk-21-jdk](https://openjdk.org/projects/jdk/21/)
- xclip (tmux/WezTerm copy to the system clipboard)
- ImageMagick and Ghostscript (images and PDFs in Neovim)

```bash
sudo apt install eza
sudo apt install bat
sudo apt install fd-find
sudo apt install zoxide

# Ubuntu installs bat and fd as batcat and fdfind; the config calls them bat and fd
mkdir -p ~/.local/bin
ln -s /usr/bin/batcat ~/.local/bin/bat
ln -s /usr/bin/fdfind ~/.local/bin/fd

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

# Clipboard, images/PDFs in Neovim
sudo apt install xclip imagemagick ghostscript
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
# plugins=(git fzf-tab zsh-autosuggestions sudo web-search copyfile jsontools zsh-syntax-highlighting vi-mode)
git clone https://github.com/Aloxaf/fzf-tab ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/fzf-tab
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
```

#### fzf

fzf lists with `fd`, previews with `fzf-preview` (in `tools/`), and uses the Batman colors (see Theme).
It runs full screen with the prompt on the bottom line, the best match at the top, and the preview hidden until Ctrl-/.
[fzf-tab](https://github.com/Aloxaf/fzf-tab) turns every Tab completion into an fzf list with previews.

```
Ctrl-T         insert file/dir paths
Ctrl-R         search history (Ctrl-Y copy, Ctrl-/ full command)
Alt-C          cd into a directory
Tab            fzf-tab completion (< and > switch groups)
cmd **<Tab>    fzf completion for paths, e.g. nvim **<Tab>, cd **<Tab>

Inside any fzf list
Ctrl-/         toggle preview          Ctrl-D/Ctrl-U   scroll preview
Tab            mark item (multi)       Alt-A           mark all
Ctrl-Y         copy selection to the clipboard

inv            open file(s) in nvim
rgf [query]    live ripgrep, opens the match in nvim at its line
fkill [sig]    kill your processes
fco            switch git branch (local or remote)
fenv           browse environment variables
zi             zoxide's interactive directory jump
<Prefix>f      tmux-sessionizer: jump to a project's tmux session
```

#### Yazi

[yazi](https://github.com/sxyazi/yazi) is the terminal file manager. Its config in `yazi/.config/yazi` only holds what
differs from the defaults: hidden files shown, natural sort, sizes next to names, the Batman theme, and a few keys.
The prebuilt musl binary works on Ubuntu 22.04:

```bash
YAZI_VERSION=$(curl -s "https://api.github.com/repos/sxyazi/yazi/releases/latest" | \grep -Po '"tag_name": *"v\K[^"]*')
curl -Lo yazi.zip "https://github.com/sxyazi/yazi/releases/download/v${YAZI_VERSION}/yazi-x86_64-unknown-linux-musl.zip"
unzip -q yazi.zip
install -m 755 yazi-x86_64-unknown-linux-musl/{yazi,ya} ~/.local/bin/
```

Previews use tools that are already listed above (`fd`, `rg`, `fzf`, `zoxide`, ImageMagick) plus `file`, `ffmpeg`,
`7z`, `jq` and `poppler-utils`; `resvg` adds SVG previews. Images show in WezTerm, also inside tmux (`allow-passthrough`).

```bash
sudo apt install file ffmpeg p7zip-full jq poppler-utils
```

Plugins are pinned in `package.toml` and installed into `plugins/` (not tracked). Install them after stowing:

```bash
ya pkg install
```

```
y [dir]        open yazi; quitting with q cds the shell to where you were (Q doesn't)
~ or F1        all key bindings
h/j/k/l        move, Enter/o open (nvim for text), O open with...
Space          select, v visual select, y/x yank/cut, p paste, d trash, a create, r rename
J / K          scroll the preview; on a PDF, next / previous page (page / total shows under it)
T              maximize or restore the preview pane (read PDFs and images full screen)
s / S          search names (fd) / contents (rg)
z / Z          jump with fzf / zoxide
gp / g.        go to ~/Desktop/code / ~/dotfiles
gi             lazygit in the current directory
!              a shell in the current directory (exit to go back)

<Prefix>C-y    yazi in a tmux popup; files you open go to nvim in a new tmux window
<leader>-      in nvim (yazi.nvim): yazi at the current file; <leader>_ at nvim's cwd, <leader>yr resume
```

The file list shows git status next to each name ([git.yazi](https://github.com/yazi-rs/plugins/tree/main/git.yazi)):
`M` modified, `?` untracked, `S`/`A` staged, `D` deleted, `!` ignored (grey). Folders show the status of what's inside.

#### Theme

Everything except Neovim uses WezTerm's built-in **Batman** scheme: a near-black background, greys and yellow. There's no red or
green, so alerts use bright yellow (e.g. the tmux prefix and bell, low battery).

- WezTerm: `Batman` color scheme, with its light grey (`#c6c5bf`) as the text color since the default is too dim
- tmux: Batman colors set as catppuccin's `@thm_*` values at the top of `tmux.conf` (the catppuccin plugin only
  provides the status bar layout)
- Neovim is the exception: it uses [Tokyo Night](https://github.com/folke/tokyonight.nvim) (`tokyonight-night`,
  transparent background) with lualine's `auto` theme. `:colorscheme batman` switches to `colors/batman.lua`, which
  matches the rest of the setup (errors bright yellow, warnings gold, info/hints grey)
- fzf: colors in `FZF_DEFAULT_OPTS` in `.zshrc`
- yazi: `yazi/.config/yazi/theme.toml`
- bat (fzf previews and `cat`): the built-in `ansi` theme, which uses the terminal's colors, so it follows WezTerm

The previous Rosé Pine Moon setup is still available: `rose-pine` is installed in Neovim, its bat theme is in
`bat/.config/bat/themes` (run `bat cache --build` after stowing), and the full config is in git history.

#### Wezterm

- Install wezterm: https://wezterm.org/install/linux.html and set it as a startup application with startup cmd as `cd Desktop/code & wezterm`
- Use the nightly build; the last stable release (`20240203`) is old and noticeably slower

```bash
curl -fsSL https://apt.fury.io/wez/gpg.key | sudo gpg --yes --dearmor -o /usr/share/keyrings/wezterm-fury.gpg
echo 'deb [signed-by=/usr/share/keyrings/wezterm-fury.gpg] https://apt.fury.io/wez/ * *' | sudo tee /etc/apt/sources.list.d/wezterm.list
sudo apt update
sudo apt install wezterm-nightly
```

- WezTerm starts tmux (session `main`) automatically, preferring `/usr/local/bin/tmux` when it exists
- Rendering uses `front_end = "WebGpu"` (Vulkan); set it back to `"OpenGL"` in `.wezterm.lua` if you see glitches

Copy / paste

```
Ctrl+Shift+C   copy: the WezTerm selection (Shift+mouse drag), or else the tmux copy-mode / mouse selection
Ctrl+Shift+V   paste from the system clipboard
Ctrl+Shift+X   WezTerm's own copy mode (V to select, y to copy)
Ctrl+Backspace delete the previous word (sends Ctrl+W)
```

Links

```
Shift+click    on file:line (e.g. src/main.rs:42:5 in compiler, rg or test output): nvim at that line in a new tmux
               window, relative to the active tmux pane's directory; URLs open in the browser
               (Shift because tmux has the mouse; a plain click works outside tmux)
Ctrl+Shift+Space  quick select: type the hint letters to copy a path, file:line, URL, hash or number
```

#### Keyboard

Caps Lock is Esc when tapped and Ctrl when held, on every keyboard, using [keyd](https://github.com/rvaiya/keyd)
(`keyd/.config/keyd/default.conf`). Shift+Caps Lock is still a real Caps Lock, so the tmux indicator keeps working.
keyd isn't packaged for Ubuntu 22.04; build a release tag and install the config. Copy it rather than symlinking:
keyd runs as root and its config can run commands, so it shouldn't be editable without sudo.

```bash
sudo apt install build-essential git
git clone --branch v2.6.0 --depth 1 https://github.com/rvaiya/keyd /tmp/keyd
make -C /tmp/keyd && sudo make -C /tmp/keyd install
sudo install -Dm 644 ~/dotfiles/keyd/.config/keyd/default.conf /etc/keyd/default.conf
sudo systemctl enable --now keyd
```

After changing the config, copy it again and run `sudo keyd reload`. If a key ever gets stuck, Backspace+Esc+Enter
pressed together kills keyd.

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
- Build tmux >= 3.4 from source. Ubuntu 22.04's `apt` package is 3.2a, which can't pass images through to WezTerm
  (`allow-passthrough` is silently ignored), so images/PDFs in Neovim won't render

```bash
sudo apt install libevent-dev libncurses-dev build-essential bison pkg-config
TMUX_VERSION=3.8 # latest: https://github.com/tmux/tmux/releases
curl -LO https://github.com/tmux/tmux/releases/download/${TMUX_VERSION}/tmux-${TMUX_VERSION}.tar.gz
tar xf tmux-${TMUX_VERSION}.tar.gz
cd tmux-${TMUX_VERSION}
./configure --enable-sixel && make
sudo make install # installs to /usr/local/bin/tmux
```

After upgrading, restart the tmux server so the new version is used (tmux-resurrect restores your sessions):

```bash
tmux kill-server
```

Notes

- Scrollback is kept by tmux (`history-limit 50000`), not WezTerm
- Copy mode: `<Prefix>v` (or `<Prefix>[`), `v` to select, `y`/`Enter` to copy to the clipboard. Mouse drags copy on release.
- Status bar, left: session, current directory with its git branch (`*` when tracked files have uncommitted changes,
  checked in the background every few seconds, `git-branch.sh`), then 🔒 CAPS while Caps Lock is on

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

[fzf-lua](https://github.com/ibhagwan/fzf-lua) is the only picker (telescope was removed): `ff` files, `fg` live grep,
`fw` word under cursor, `fr` resume, `fb` all pickers, and `<C-b>` live grep.

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

##### Images and PDFs

[snacks.nvim](https://github.com/folke/snacks.nvim) (`image`) renders images and PDFs when you open them. It needs
ImageMagick, Ghostscript (for PDFs), `enable_kitty_graphics = true` in WezTerm and tmux >= 3.4 (see the Tmux section).

Ubuntu's ImageMagick 6 blocks PDF conversion by default; allow it with:

```bash
sudo sed -i 's|<policy domain="coder" rights="none" pattern="PDF" />|<policy domain="coder" rights="read" pattern="PDF" />|' /etc/ImageMagick-6/policy.xml
```

WezTerm only partly supports the kitty graphics protocol: opening an image/PDF file works, inline images
(e.g. in markdown) don't. Kitty or Ghostty support both.

Check the setup with:

```vim
:checkhealth snacks
```

## External toolings
- [jarexplorer](https://dst.in.ua/jarexp/)
- Extract the Ghidra archive to /opt/ghidra/. A shell alias is already configured in .zshrc, so you can launch it with the ghidra command. [ghidra](https://github.com/nationalsecurityagency/ghidra)

## Thanks / Shoutout / Inspired By

- The nvim config here is built on top of [ https://github.com/muhammadzkralla/zvim.nvim ]
- The tmux config here is built on top of [ https://github.com/Sin-cy/dotfiles ]
- The LSP related configuration including integration with blink-cmp, fzf, conform was built using: [ https://github.com/jakobwesthoff/nvim-from-scratch/tree/main ] and corresponding youtube link [ https://www.youtube.com/watch?v=b17g20II6SQ&list=PLy68GuC77sURrnMNi2XR1h58m674KOvLG ]
- For more Neovim Configuration tips: [ https://alpha2phi.medium.com/learn-neovim-the-practical-way-8818fcf4830f ]
- [ https://github.com/josean-dev/dev-environment-files ]
- [ https://github.com/MariaSolOs/dotfiles ]
- [ https://github.com/davidosomething/dotfiles/tree/dev/nvim ]
- [ https://github.com/jugarpeupv/dotfiles/tree/main/nvim/.config/nvim ]
