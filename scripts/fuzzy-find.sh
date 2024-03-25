#!/bin/sh
selected=$(
(find ~/repositorios -maxdepth 1 -type d;
echo '/etc/nixos';
echo '/home/henrique/.config/i3';
echo '/home/henrique/.config/tmux';
echo '/home/henrique/.config/kitty';
echo '/home/henrique/.config/nvim') | fzf-tmux --multi --reverse);


selected_name=$(basename "$selected" | tr . _);
echo $seleted_name;

if [[ -z $selected ]]; then
    exit 0
fi

selected_name=$(basename "$selected" | tr . _)
tmux_running=$(pgrep tmux)

if [[ -z $TMUX ]] && [[ -z $tmux_running ]]; then
    tmux new-session -s $selected_name -c $selected
    exit 0
fi

if ! tmux has-session -t=$selected_name 2> /dev/null; then
    tmux new-session -ds $selected_name -c $selected
fi

tmux switch-client -t $selected_name;

#Atention it can be #!/bin/sh or #!/bin/bash
