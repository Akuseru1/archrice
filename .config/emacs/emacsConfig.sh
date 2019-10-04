#!/bin/bash
mkdir ~/.emacs.d; cd ~/.emacs.d && awk '{print $2 }' ~/.config/emacs/emacsDependencies | xargs -n 1 git clone
