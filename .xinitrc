#!/bin/sh

# Add this to your .xinitrc or whatever file starts programs on startup.
# -R restores the last colorscheme that was in use.
wal -R
[ -f "$HOME/.xprofile" ] && . ~/.xprofile
#[[ -f ~/.Xmodmap ]] && xmodmap ~/.Xmodmap
setxkbmap -model pc104 -layout latam,latam -variant colemak, -option grp:win_space_toggle
sxhkd & # Bind keys
exec i3


