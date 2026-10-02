#!/usr/bin/env bash
#
# Called from tmux's session-created hook with the new session's name and
# its initial pane path as arguments. If a directory exists at
# ~/devel/<session-name>, cd the new session's pane into it. Otherwise,
# fall back to the directory tmux was originally launched from (captured
# once, the first time a session is created on this server).

set -euo pipefail

SESSION_NAME="$1"
PANE_PATH="$2"
DEVEL_DIR="$HOME/devel/$SESSION_NAME"

# Record the directory of the very first session as the fallback default,
# if we haven't already captured one for this server instance.
if ! tmux show-environment -g TMUX_DEFAULT_DIR >/dev/null 2>&1; then
    tmux set-environment -g TMUX_DEFAULT_DIR "$PANE_PATH"
fi

if [ -d "$DEVEL_DIR" ]; then
    tmux send-keys -t "$SESSION_NAME" "cd \"$DEVEL_DIR\"" Enter
else
    DEFAULT_DIR="$(tmux show-environment -g TMUX_DEFAULT_DIR | sed 's/^TMUX_DEFAULT_DIR=//')"
    if [ -n "$DEFAULT_DIR" ] && [ "$DEFAULT_DIR" != "$PANE_PATH" ]; then
        tmux send-keys -t "$SESSION_NAME" "cd \"$DEFAULT_DIR\"" Enter
    fi
fi
