# Tmux conf

Copy the `.tmux.conf` to `~/` 

# Scripts

All scripts should live in `~/.tmux/scripts/`

## Auto CD

This is a script that attempts to open a repo inside of the `devel` directory that matches the name of your session. For example if you name your session `my-repo` and there's a directory `~/devel/my-repo` then it will attempt to start the tmux session in that repo regardless of where it started.
