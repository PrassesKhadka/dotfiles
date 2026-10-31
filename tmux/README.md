## Note:
1. Tmux copy mode to scroll up/down through terminal history Prefix(Ctrl+b) + [ (or v) and J and K to move
2. In copy mode, v to start a selection and y (or Enter) to copy it to the system clipboard. Ctrl+Shift+C in WezTerm does the same.
3. Mouse drags copy to the clipboard on release; the selection stays visible until you press Ctrl+Shift+C, q or Esc
4. Scrollback is 50000 lines per pane (history-limit)
5. Prefix + f opens tmux-sessionizer (tools/.local/bin) in a popup: pick a project folder to jump to its session
6. Status bar: session name and current directory on the left (session becomes a yellow block while the prefix is
   pressed), ○ windows centred with ● the active one (gold = activity, bold yellow = bell), time and battery on the right
   (battery turns yellow below 20%, bright yellow at 5%); colors are Batman
