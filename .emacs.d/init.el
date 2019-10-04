;; My Configs!!!



;; dont forget to do M-x all-the-font-install
;; install from internet

;;company
;;company-irony
;;irony
;;writeroom
;;doom-mode

;; dependencies to install

;; clang for company
;; llvm for company
;; dont forget to run irony-install-server in a c file


;;programs i can disable

; display-line-numbers, tends to get slow in large files, so you should use nlinum-relative for those


;; it should fix the scrolling
(setq auto-window-vscroll nil)
(setq-default display-line-numbers 'relative)




;this installs use-package
;; This is only needed once, near the top of the file
(eval-when-compile
;;; code: Following line is not needed if use-package.el is in ~/.emacs.d
  (add-to-list 'load-path "~/.emacs.d/use-package")
  (require 'use-package))

;; =================>>>>  make sure to run the emacsDependencies script beforehand

;;adds the libraries to the path
(add-to-list 'load-path "~/.emacs.d/undo-tree")
(add-to-list 'load-path "~/.emacs.d/evil")
(add-to-list 'load-path "~/.emacs.d/evil-terminal-cursor-changer")
(add-to-list 'load-path "~/.emacs.d/goto-chg")
(add-to-list 'load-path "~/.emacs.d/evil-surround")
(add-to-list 'load-path "~/.emacs.d/evil-tutor")
(add-to-list 'load-path "~/.emacs.d/evil-leader")
(add-to-list 'load-path "~/.emacs.d/popup-el")
(add-to-list 'load-path "~/.emacs.d/emacs-async")
(add-to-list 'load-path "~/.emacs.d/helm")
(add-to-list 'load-path "~/.emacs.d/evil-org-mode")
(add-to-list 'load-path "~/.emacs.d/evil-magit")
(add-to-list 'load-path "~/.emacs.d/color-theme-approximate")
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes")
;; fixes tab for org-mode, must be before require evil!

(setq evil-want-C-i-jump nil)

;; require loads all the libraries that have been added to the path

(require 'evil)
(require 'undo-tree)
(require 'evil-terminal-cursor-changer)
(require 'goto-chg)
(require 'evil-surround)
(require 'evil-tutor)
(require 'evil-leader)
(require 'popup)
(require 'helm)
(require 'async)
(require 'evil-org)
(require 'color-theme-approximate)
(require 'helm-bookmark)

;; adds option prompts for shortcuts after pressing a key binding
(add-to-list 'load-path "~/.emacs.d/emacs-which-key")
(require 'which-key)

(add-hook 'org-mode-hook 'evil-org-mode)
(evil-org-set-key-theme '(navigation insert textobjects additional calendar shift))
(require 'evil-org-agenda)
(evil-org-agenda-set-keys)
;============================= init some modes
(setq which-key-idle-delay 0.01)
(which-key-mode)

(global-evil-leader-mode) ; needs to start before evil for scratch to have leader

(global-undo-tree-mode)
(evil-mode 1)

(unless (display-graphic-p)
  (require 'evil-terminal-cursor-changer)
  (evil-terminal-cursor-changer-activate) ; or (etcc-on)
  )
(global-set-key [(control ?.)] 'goto-last-change)
(global-set-key [(control ?,)] 'goto-last-change-reverse)
(global-evil-surround-mode 1)


; Repositories

(require 'package)
(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
			 ("marmalade" . "http://marmalade-repo.org/packages/")
			 ("melpa" . "http://melpa.org/packages/")))



  (package-initialize)

;; so that it uses the load-path to check for the right packages installed
(setq-default flycheck-emacs-lisp-load-path 'inherit)
;;checks if magit is installed


(if (package-installed-p 'magit)
    (require 'evil-magit))


;; other way of installing packages
(unless (package-installed-p 'xclip)
  (package-refresh-contents)
  (package-install 'xclip))

(unless (package-installed-p 'magit)
 (package-refresh-contents)
 (package-install 'magit))

;===============================================================================

; some installs using use-package

;; learning to use use-package to install packages and only use them when needed

(use-package doom-modeline
  :ensure t  ; ensure makes sure a package is installed , if not , it installs it yet another way to install packages
  :hook (after-init . doom-modeline-mode))

(use-package xclip
  :ensure t
  :init
  (xclip-mode 1))

(use-package evil-snipe ;; for jumping around like f in vimium
  :load-path "~/.emacs.d/evil-snipe"
  :config (progn
  (evil-define-key* '(motion normal) evil-snipe-local-mode-map
		    "s" nil  ;disables the override of s from snipe
		    "S" nil)
(evil-snipe-mode +1)
(evil-snipe-override-mode +1)
  ))

(use-package avy  ;; for jumping around like f in vimium
  :load-path "~/.emacs.d/avy")

;; visual fill column is a writeroom Dependency

(use-package visual-fill-column
  :load-path "~/.emacs.d/visual-fill-column")

(use-package writeroom-mode
  :load-path "~/.emacs.d/writeroom-mode")



;;for syntax checkint
(use-package flycheck
  :ensure t
  :init (add-hook 'c-mode-hook 'flycheck-mode))

;;Company for auto-complete

(use-package company
  :ensure t
  :config
  (setq company-idle-delay 0)
  (setq company-minimum-prefix-length 3))

;; to scroll with C-n and C-p
(defun company-nav ()
  (define-key company-active-map (kbd "C-n") 'company-select-next)
  (define-key company-active-map (kbd "C-p") 'company-select-previous))


;;for c programming autocomplete

(use-package company-irony
  :ensure t
  :config
  (require 'company)
  (add-to-list 'company-backends 'company-irony))

(use-package irony
  :ensure t
  :config
  (add-hook 'c++-mode-hook 'irony-mode)
  (add-hook 'c-mode-hook 'irony-mode)
  (add-hook 'irony-mode-hook '(irony-cdb-autosetup-compile-options)))

; python

;(use-package jedi-core
;  :ensure t
;  :config
;  (add-hook 'python-mode-hook 'jedi-mode))
;
;(use-package company-jedi
;  :ensure t
;  :config
;  (require 'company)
;  (add-to-list 'company-backends 'company-jedi))
;
;;; this is for an error in virtual environments
;(setq py-python-command "")
;(setq jedi:environment-root (quote ROOT_DIR/envs/NAME_1))

;;;set up Hooks FOR AUTOCOMPLETE

(use-package company-anaconda
  :ensure t
  :config (eval-after-load "company"
 '(add-to-list 'company-backends 'company-anaconda)))

(with-eval-after-load 'company
(add-hook 'company-mode-hook 'company-nav)
(add-hook 'emacs-lisp-mode-hook 'company-mode)
(add-hook 'c-mode-hook 'company-mode)
(add-hook 'c++-mode-hook 'company-mode)
(add-hook 'python-mode-hook 'company-mode)
(add-hook 'python-mode-hook 'anaconda-mode)
)


;; if writeroom is activated deactivated, otherwise activated with desired width

(defun writeroom-best ()
  (interactive)
  (if (eq writeroom-mode t) (writeroom-mode -1)
    (progn ( writeroom-mode t)
	  (writeroom-increase-width)
	   (writeroom-increase-width)
	   (writeroom-increase-width)
	   (writeroom-increase-width))))

;; for line numbers dont forget to disable display-line-numbers


;;use-package nlinum-relative
;;  :config
;;;; something else you want
;;  ;(nlinum-relative-setup-evil)
;;
;;  ;;modes to have lines
;;  (add-hook 'org-mode-hook 'nlinum-relative-mode)
;;  (add-hook 'prog-mode-hook 'nlinum-relative-mode))
;;
;;(setq nlinum-relative-redisplay-delay 0.2)      ;; delay
;;(setq nlinum-relative-current-symbol "")      ;; or "" for display current line number
;;(setq nlinum-format "%d    ") ;; padding!
;;(setq nlinum-relative-offset 0)

;; for using bibliographies in org-mode

(use-package org-ref
  :ensure t
  :config
  (setq reftex-default-bibliography '("~/org/bib/references.bib"))
  (setq org-ref-bibliography-notes "~/bib/notes.org"
	org-ref-default-bibliography '("~/org/bib/references.bib")
	org-ref-pdf-directory "~/org/latex-pdfs")
  (setq bibtex-completion-bibliography "~/org/bib/references.bib"
	bibtex-completion-library-path "~/org/latex-pdfs"
	bibtex-completion-notes-path "~/bib/helm-bibtex-notes")

  ;; open pdf with system pdf viewer (works on mac)
  (setq bibtex-completion-pdf-open-function
	(lambda (fpath)
	  (start-process "open" "*open*" "open" fpath)))
  (setq org-latex-pdf-process (list "latexmk -shell-escape -bibtex -f -pdf %f")))

;; alternative
;; (setq bibtex-completion-pdf-open-function 'org-open-file)

;==============================================================

;Configuration
;; Themes

;; activate theme only in normal emacs

(if (display-graphic-p)
  (load-theme 'dracula t)
  ;;(load-theme 'misterioso t)
  )

;;Remaps ======================================================

;;add go back functionality in terminal to Info mode
(add-hook 'help-mode-hook
	  (lambda ()
	    (define-key help-mode-map (kbd "SPC-l") 'help-go-back)))
;; remaps my alt gr key to work as meta

(define-key key-translation-map (kbd "»") (kbd "M-x"))
(global-set-key (kbd "”")   'evil-leader-mode)
(global-set-key (kbd "½") 'shrink-window)
(global-set-key (kbd "ĸ") 'enlarge-window)
(global-set-key (kbd "ħ") 'shrink-window-horizontally)
(global-set-key (kbd "ł") 'enlarge-window-horizontally)

;; bind meta hjkl keys to altgr (st bindings dont let you use alt)
;; define-key + mode-m-ap or state-map lets you LOCALLY bind stuff, (only for that mode), unlike global which changes it for every mode no matter what
(eval-after-load "evil-maps"
  (dolist (map '(evil-motion-state-map
                 evil-insert-state-map
                 evil-emacs-state-map))
    (define-key (eval map) "\C-o" nil)))

(define-key input-decode-map "^O" [C-<S-o>]) ;; defines my escape key for shift


;; defines most org-mode navigation bindings
(defun org-nav-hjkl ()
  ;; sets the variable so that enter actually enters links (it doesnt by default)
  (setq org-return-follows-link t)
  (define-key evil-motion-state-map (kbd "RET") nil) ;;to activate org-return and enter links
  (define-key org-mode-map (kbd "C-o") 'org-insert-heading) ;; to create a new heading
  (define-key org-mode-map (kbd "ĸ") 'org-metaup)
  (define-key org-mode-map (kbd "½") 'org-metadown)
  (define-key org-mode-map (kbd "ł") 'org-metaright)
  (define-key org-mode-map (kbd "ħ") 'org-metaleft)
  (define-key org-mode-map (kbd "ß") 'shrink-window)
  (define-key org-mode-map (kbd "ð") 'enlarge-window)
  (define-key org-mode-map (kbd "æ") 'shrink-window-horizontally)
  (define-key org-mode-map (kbd "đ") 'enlarge-window-horizontally))

;;to disable todo functions and re-enable evil functionality for shift H

;; for fixing it https://emacs.stackexchange.com/questions/22286/shiftarrow-to-change-window-does-not-work-in-org-mode/38443
;;(setq org-support-shift-select 'always)
;;(add-hook 'org-shiftleft-final-hook nil)
;;(add-hook 'org-shiftright-final-hook nil)
;; so that it adds all the non interactive functions to the apropos page in help
(setq apropos-do-all t)
;;org mode ======================================================

(add-hook 'org-mode-hook 'org-nav-hjkl)
;;so that the headings indent themselves
(add-hook 'org-mode-hook 'org-indent-mode)
;; so that yanking will include subtrees
(setq org-yank-adjusted-subtrees t)

;; set this only when you are exporting latex to pdf
(defun kdm/org-save-and-export ()
  (interactive)
  (if (and (eq major-mode 'org-mode)
	   (ido-local-file-exists-p (concat (file-name-sans-extension (buffer-name)) ".pdf")))
      (org-latex-export-to-pdf)))

(add-hook 'after-save-hook 'kdm/org-save-and-export)


;; adds more options to TODO in org

(setq org-todo-keywords '((sequence "TODO(t)" "INPROGRESS(i)" "WAITING(w)" "|" "DONE(d)" "CANCELLED(c)")))

(setq org-todo-keyword-faces

      '(("TODO":foreground "purple" :weight bold :underline t)

	("DONE" :foreground "orange" :weight bold :underline t)

	("INPROGRESS" :foreground "blue" :weight bold :underline t)

	("WAITING" :foreground "green" :weight bold :underline t)

	("CANCELLED" :foreground "red" :weight bold :underline t)))
;; to add the timestamp with org-todo
(setq org-log-done 'time)
;; to jump between buffers
(global-set-key (kbd "M-b") 'evil-jump-backward)
(global-set-key (kbd "M-f") 'evil-jump-forward)

;; change enter to o <esc> my first try
(defun enter-func ()
  (interactive)
  (evil-open-below 1)
  (evil-normal-state))

(define-key evil-normal-state-map (kbd "ø") 'enter-func)

(defun newBuffer-ansi-term ()
  (interactive)
  (split-window-vertically)
  (evil-window-down 1)
  (ansi-term "bash"))

;; M-! pwd shows path

;(defun input-path-open-term ()
;  "Open an `ansi-term' that corresponds to current directory."
;  (interactive)
;  (let ((current-dir (substring (shell-command-to-string "pwd") 0 -1)))
;    (term-send-string
;     (ansi-term "bash")
;     (if (file-remote-p current-dir)
;         (let ((v (tramp-dissect-file-name current-dir t)))
;           (format "ssh %s@%s\n"
;                   (aref v 1) (aref v 2)))
;       (format "cd '%s'" current-dir))))) ;it will press enter after \n
;
;
;;this lets me save the output of a command
;
;(defvar pathi (shell-command-to-string pwd))
;(format "%s" pathi)

(defun dired-open-term ()
  "Open an `ansi-term' that corresponds to current directory."
  (interactive)
  (let ((current-dir (dired-current-directory)))
    (term-send-string
     (ansi-term "bash")
     (if (file-remote-p current-dir)
         (let ((v (tramp-dissect-file-name current-dir t)))
           (format "ssh %s@%s\n"
                   (aref v 1) (aref v 2)))
       (format "cd '%s'\n" current-dir)))))

;;=======================

;;sets leader key

(evil-leader/set-leader "<SPC>")

;; leader shortcuts

;; if (bound-and-true-p "mode") checks if a mode is active

;; use M-n to open hyperlinks in new buffers

;;to follow links in org mode you have to put (org-open-at-point) in the function file
(evil-leader/set-key
  "w" 'avy-goto-char
  "b" 'switch-to-buffer
  "<f1>" 'bookmark-bmenu-list
  "<f2>" 'bookmark-set-no-overwrite
  "<f3>" 'bookmark-jump
  "d" 'diff-buffer-with-file
  "r" 'dired
  "l" (if (bound-and-true-p org-mode) 'org-open-at-point 'Info-history-back)
  "ms" 'org-stored-links
  "ml" 'org-insert-link
  "o" 'org-insert-heading-respect-content
  "tt" 'org-todo
  "td" 'dired-open-term
  "tn" 'newBuffer-ansi-term
  "tp" 'org-cut-special
  "f" 'find-file
  "ee" 'eval-last-sexp
  "eb" 'eval-buffer
  "p" 'helm-bookmarks
  "sa" 'save-some-buffers
  "st" 'org-set-tags-command
  "ss" 'flyspell-mode
;  "sp" 'split-window-horizontally ;; C-x 3 does this already
  "sb" 'flyspell-buffer
  "ma" 'which-key-show-top-level
  "mm" 'which-key-show-major-mode
  "gs" 'magit-status
  "gl" 'magit-log-all
  "gi" 'magit-init
  "gb" 'magit-branch
  "go" 'writeroom-best
  "gi" 'writeroom-increase-width
  "gp" 'writeroom-decrease-width
  "k" 'kill-buffer)




;; disable ugly UI

(tool-bar-mode -1)
(menu-bar-mode -1)
(toggle-scroll-bar -1)

;; Change terminal cursor

(unless (display-graphic-p)
  (require 'evil-terminal-cursor-changer)
  (evil-terminal-cursor-changer-activate) ; or (etcc-on)
  )

(setq evil-motion-state-cursor 'box)  ; █
(setq evil-visual-state-cursor 'box)  ; █
(setq evil-normal-state-cursor 'box)  ; █
(setq evil-insert-state-cursor 'bar)  ; ⎸
(setq evil-emacs-state-cursor  'hbar) ; _



;this lets me switch windows with Ctrl and vim directions


(eval-after-load "evil"
  '(progn
     (define-key evil-normal-state-map (kbd "C-h") 'evil-window-left)
     (define-key evil-normal-state-map (kbd "C-j") 'evil-window-down)
     (define-key evil-normal-state-map (kbd "C-k") 'evil-window-up)
     (define-key evil-normal-state-map (kbd "C-l") 'evil-window-right)))

(eval-after-load "evil"
  '(progn
     (define-key evil-motion-state-map (kbd "C-h") 'evil-window-left)
     (define-key evil-motion-state-map (kbd "C-j") 'evil-window-down)
     (define-key evil-motion-state-map (kbd "C-k") 'evil-window-up)
     (define-key evil-motion-state-map (kbd "C-l") 'evil-window-right)))



;; native line numbers
;; possibly deprecated
;;(setq-default display-line-numbers 'visual
;;              display-line-numbers-current-absolute t
;;              display-line-numbers-width 0
;;              display-line-numbers-widen t)
;;(set-face-attribute 'line-number nil)
;;(set-face-attribute 'line-number-current-line nil
;;                    :background nil :foreground "#9E3A01")



;;adds ~ to empty lines
(setq-default indicate-empty-lines t)
(define-fringe-bitmap 'tilde [0 0 0 113 219 142 0 0] nil nil 'center)
(setcdr (assq 'empty-line fringe-indicator-alist) 'tilde)
(set-fringe-bitmap-face 'tilde 'font-lock-function-name-face)


;;To use evil-search instead of isearch default

(evil-select-search-module 'evil-search-module 'evil-search)

;;; esc quits: so that esc actually quits anything (pending prompts in the minibuffer)

(defun minibuffer-keyboard-quit ()

	;;  "Abort recursive edit.
	;;In Delete Selection mode, if the mark is active, just deactivate it;
	;;then it takes a second \\[keyboard-quit] to abort the minibuffer."

  (interactive)
  (if (and delete-selection-mode transient-mark-mode mark-active)
      (setq deactivate-mark  t)
    (when (get-buffer "*Completions*") (delete-windows-on "*Completions*"))
    (abort-recursive-edit)))
(define-key evil-normal-state-map [escape] 'keyboard-quit)
(define-key evil-visual-state-map [escape] 'keyboard-quit)
(define-key minibuffer-local-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-ns-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-completion-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-must-match-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-isearch-map [escape] 'minibuffer-keyboard-quit)

;; this enables ctrl-u since it wasnt working

(define-key evil-normal-state-map (kbd "C-u") 'evil-scroll-up)
(define-key evil-visual-state-map (kbd "C-u") 'evil-scroll-up)
(define-key evil-insert-state-map (kbd "C-u")
  (lambda ()
    (interactive)
    (evil-delete (point-at-bol) (point))))

;; this is to save macros between sessions!

(fset 'mymacro [?i ?f ?o ?o ?b ?a ?r escape])
	;; make sure this is done after evil-mode has been loaded
(evil-set-register ?f [?i ?f ?o ?o ?b ?a ?r escape])



;;Compilers!!!

(defun execute-c-program ()
  (interactive)
  (defvar foo)
  (save-buffer)
  (setq foo (concat "gcc " (buffer-name) " && ./a.out \n" ))
  (split-window-vertically)
  (evil-window-down 1)
  (term-send-string (ansi-term "bash") foo))

;; Run C programs directly from within emacs
;;(defun execute-c-program ()
;;  (interactive)
;;  (defvar foo)
;;  (save-buffer)
;;  (setq foo (concat "gcc " (buffer-name) " && ./a.out" ))
;;  (shell-command foo)) ;;change to return a string and make it go through ansi-term  function

(global-set-key [f25] 'execute-c-program)

;; to make scrolling smoother:
;(setq redisplay-dont-pause t
;      scroll-margin 1
;      scroll-step 1
;      scroll-conservatively 10000
;      scroll-preserve-screen-position 1)
;(setq scroll-conservatively 101) ;; move minimum when cursor exits view, instead of recentering
;(setq mouse-wheel-scroll-amount '(1)) ;; mouse scroll moves 1 line at a time, instead of 5 lines
;(setq mouse-wheel-progressive-speed nil) ;; on a long mouse scroll keep scrolling by 1 line
(setq scroll-margin 1
scroll-conservatively 2000)
(setq-default scroll-up-aggressively 0.01
scroll-down-aggressively 0.01)
;; Add powerline theme!

;;(add-to-list 'load-path "~/.emacs.d/powerline")
;;(require 'powerline)
;;(powerline-center-evil-theme)

;;Auto load flyspell-mode

(autoload 'flyspell-mode "flyspell" "On-the-fly spelling checker." t)
(autoload 'flyspell-delay-command "flyspell" "Delay on command." t) (autoload 'tex-mode-flyspell-verify "flyspell" "" t)

;; Set default dictionary

(setq ispell-dictionary "castellano")

;; correct words using f12

(global-set-key (kbd "<f12>") 'flyspell-auto-correct-previous-word)
(global-set-key (kbd "<f11>") 'flyspell-auto-correct-word)

;; change dictionary using flyspell

;; you need to install the hunspell dictionary beforehand for this to work

(defun fd-switch-dictionary()
  (interactive)
     (let* ((dic ispell-current-dictionary)
	    (change (if (string= dic "castellano") "english" "castellano")))
       (ispell-change-dictionary change)
       (message "Dictionary switched from %s to %s" dic change)
       ))

(global-set-key (kbd "<f8>")   'fd-switch-dictionary);; learning to use interactive functions



;According to the documentation
;
;    (global-set-key KEY COMMAND)
;
;    Give KEY a global binding as COMMAND. COMMAND is the command definition to use; usually it is a symbol naming an interactively-callable function.
;
;So you have to use an interactively-callable function:

;; theres also a bookmarks option in emacs but they are stored in a different file

;; this enables spell-check for strings in c

(add-hook 'c++-mode-hook
          (lambda ()
            (flyspell-prog-mode)
	    ; ...
	    ))

;; this enables it for org-mode

; lambda is used for when you need more than one function,

;(add-hook 'org-mode-hook 'flyspell-mode)

;; my Bookmarks

(global-set-key (kbd "<f4>") (lambda() (interactive)(find-file "~/org/wiki/Linux/Linux.org")))
(global-set-key (kbd "<f5>") (lambda() (interactive)(find-file "~/org/wiki/Semestre5/Semestre_5.org")))
(global-set-key (kbd "<f6>") (lambda() (interactive)(find-file "~/.emacs.d/init.el")))
(global-set-key (kbd "<f7>") (lambda() (interactive)(find-file "~/Sync/TODO.org")))
;; to show matching brackets


(show-paren-mode 1)

;; to save evil-marks between sessions

;;;;;;;;;;;;(add-to-list 'desktop-locals-to-save 'evil-markers-alist)

;; to be able to use brackets to jump sentences

(setq sentence-end-double-space nil)






;; so that the lines always stay on screen
;; made org-mode crash!!!!!!!!!!!!!!

;(add-hook 'org-mode-hook
;	  (lambda ()
;	    (visual-line-mode)))

;; for navigating better in helm mode for bookmarks

(define-key helm-map (kbd "C-j") 'helm-next-line)
(define-key helm-map (kbd "C-k") 'helm-previous-line)

;; alpha for GUI

 ;;(set-frame-parameter (selected-frame) 'alpha '(<active> . <inactive>))
 ;;(set-frame-parameter (selected-frame) 'alpha <both>)

(if (display-graphic-p)
 (set-frame-parameter (selected-frame) 'alpha '(85 . 50))
 (add-to-list 'default-frame-alist '(alpha . (85 . 50)))

 (defun toggle-transparency ()
   (interactive)
   (let ((alpha (frame-parameter nil 'alpha)))
     (set-frame-parameter
      nil 'alpha
      (if (eql (cond ((numberp alpha) alpha)
                     ((numberp (cdr alpha)) (cdr alpha))
                     ;; Also handle undocumented (<active> <inactive>) form.
                     ((numberp (cadr alpha)) (cadr alpha)))
               100)
          '(85 . 50) '(100 . 100)))))
 (global-set-key (kbd "C-c t") 'toggle-transparency))

;; evil-org mode variables

(setq org-special-ctrl-a/e t)
(setq evil-org-special-o/O '(table-row item))


;;so that splitting windows changes to them automatically

(global-set-key "\C-x2" (lambda () (interactive)(split-window-vertically) (other-window 1)))
(global-set-key "\C-x3" (lambda () (interactive)(split-window-horizontally) (other-window 1)))

;;=====================================================================


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(org-agenda-files (quote ("~/org/wiki/exporting.org")))
 '(package-selected-packages
   (quote
    (org-ref nlinum-relative flycheck xclip evil-magit magit diff-hl))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
