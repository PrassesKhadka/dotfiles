### fzf / tmux tools

- `fzf-preview <path>`: preview used by fzf (Ctrl-T, `**`, fzf-tab, `inv`): eza tree for directories, bat for text, text of PDFs, image info, archive listing
- `tmux-sessionizer [dir]`: fuzzy-pick a folder in `~/Desktop/code` (or `~/dotfiles`) and switch to its tmux session; bound to `<Prefix>f`

Run `stow -v -t ~ -S tools` from the dotfiles root after adding a new script so it's linked into `~/.local/bin`.

### Git-tools

Git treats files named git-xxx in your PATH as external subcommands.
Stow links `tools/.local/bin/git-undo` to `~/.local/bin/git-undo`, and `~/.local/bin` is in PATH (see `.zshrc`),
so this works:
`git undo`
