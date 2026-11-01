#!/bin/bash
export PATH="/opt/homebrew/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"

THEME_DIR="$HOME/.tmux"
STATE_FILE="$HOME/.tmux/theme"

if [[ "$(defaults read -g AppleInterfaceStyle 2>/dev/null)" == "Dark" ]]; then
    THEME="dark"
    NVIM_THEME="tokyonight-moon"
else
    THEME="light"
    NVIM_THEME="tokyonight-day"
fi

# Avoid unnecessary reloads
if [[ -f "$STATE_FILE" ]] && [[ "$(cat "$STATE_FILE")" == "$THEME" ]]; then
    exit 0
fi

# Update tmux
if tmux list-sessions >/dev/null 2>&1; then
    tmux source-file "$THEME_DIR/tmux.$THEME.conf"
fi

# Update all running Neovim instances
while IFS= read -r -d '' socket; do
    nvim --server "$socket" \
        --remote-expr "execute('colorscheme $NVIM_THEME')" \
        >/dev/null 2>&1
done < <(find "${TMPDIR:-/tmp}" -type s -name 'nvim.*' -print0 2>/dev/null)

echo "$THEME" > "$STATE_FILE"
