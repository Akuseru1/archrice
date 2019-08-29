#!/bin/sh

# Add this to your .xinitrc or whatever file starts programs on startup.
# -R restores the last colorscheme that was in use.
wal -R
[ -f "$HOME/.xprofile" ] && . ~/.xprofile
[[ -f ~/.Xmodmap ]] && xmodmap ~/.Xmodmap
exec i3


