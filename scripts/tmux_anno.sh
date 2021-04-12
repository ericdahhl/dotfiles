#!/bin/sh

tmux new -s annot8r -d

while [ "$#" -gt 0 ]; do
    curr=$1
    shift

    case "$curr" in
        "--frontend")
            tmux neww -t annot8r: -n run-batter -d 'cd ~/code/proj/tddd27-2021-annot8r/batter && npm run serve'
            tmux neww -t annot8r: -n code-batter -d 'cd ~/code/proj/tddd27-2021-annot8r/batter && nvim'
            ;;
        "--backend")
            tmux neww -t annot8r: -n run-resonant -d 'cd ~/code/proj/tddd27-2021-annot8r/resonant && npm start'
            tmux neww -t annot8r: -n code-resonant -d 'cd ~/code/proj/tddd27-2021-annot8r/resonant && nvim'
            ;;
        *) echo "Unavailable command... $curr"
    esac
done

tmux a -t annot8r
