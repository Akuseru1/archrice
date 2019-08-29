#!/bin/bash
mkdir ~/.emacs.d; cd ~/.emacs.d && awk '{print }' ~/.config/emacs/emacsDependencies | xargs -n 1 git clone
