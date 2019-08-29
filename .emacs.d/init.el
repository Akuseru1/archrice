;; My Configs!!!

;; had to comment every magit  :c


;;this installs use-package
;; This is only needed once, near the top of the file
(eval-when-compile
  ;; Following line is not needed if use-package.el is in ~/.emacs.d
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
;(add-to-list 'load-path "~/.emacs.d/org-wiki")
(add-to-list 'load-path "~/.emacs.d/evil-org-mode")
(add-to-list 'load-path "~/.emacs.d/evil-magit")
(add-to-list 'load-path "~/.emacs.d/color-theme-approximate")
;(add-to-list 'load-path "~/.emacs.d/doom-modeline")

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
;(require 'org-wiki)
(require 'evil-org)
(require 'color-theme-approximate)
(require 'helm-bookmark)

;; adds option prompts for shortcuts after pressing a key binding
(add-to-list 'load-path "~/.emacs.d/emacs-which-key")
(require 'which-key)
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
                     ("marmalade" . "http://marmalade-repo.org/packages/") ("melpa" . "http://melpa.org/packages/")))


  (package-initialize)


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

;==============================================================

;Configuration
;; Themes

;; activate theme only in normal emacs

(if (display-graphic-p)
    (load-theme 'misterioso t)
  ) 

;;Remaps

;; remaps my alt gr key to work as meta

(define-key key-translation-map (kbd "»") (kbd "M-x"))
(global-set-key (kbd "”")   'evil-leader-mode)
(global-set-key (kbd "½") 'shrink-window)
(global-set-key (kbd "ĸ") 'enlarge-window)
(global-set-key (kbd "ħ") 'shrink-window-horizontally)
(global-set-key (kbd "ł") 'enlarge-window-horizontally)

;; bind meta hjkl keys to altgr (st bindings dont let you use alt)
;; define-key + mode-map or state-map lets you LOCALLY bind stuff, (only for that mode), unlike global which changes it for every mode no matter what
(defun org-nav-hjkl ()
  (define-key org-mode-map (kbd "ĸ") 'org-metaup)
  (define-key org-mode-map (kbd "½") 'org-metadown)
  (define-key org-mode-map (kbd "ł") 'org-metaright)
  (define-key org-mode-map (kbd "ħ") 'org-metaleft)
  (define-key org-mode-map (kbd "ß") 'shrink-window)
  (define-key org-mode-map (kbd "ð") 'enlarge-window)
  (define-key org-mode-map (kbd "æ") 'shrink-window-horizontally)
  (define-key org-mode-map (kbd "đ") 'enlarge-window-horizontally))

(add-hook 'org-mode-hook 'org-nav-hjkl)


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

;(setq org-wiki-location "~/org/wiki")
;;sets leader key

(evil-leader/set-leader "<SPC>")

;; leader shortcuts

;;to follow links in org mode you have to put (org-open-at-point) in the function file
(evil-leader/set-key
  "w" 'avy-goto-char
  "d" 'diff-buffer-with-file
  "r" 'dired
  "l" 'org-open-at-point
  "od" 'dired-open-term
  "on" 'newBuffer-ansi-term
  "f" 'find-file
  "ee" 'eval-last-sexp
  "eb" 'eval-buffer
  "p" 'helm-bookmarks
  "st" 'org-set-tags-command
  "ss" 'flyspell-mode
  "sp" 'split-window-horizontally
  "sb" 'flyspell-buffer
  "ma" 'which-key-show-top-level
  "mm" 'which-key-show-major-mode
  "b" 'switch-to-buffer
  "gs" 'magit-status
  "gl" 'magit-log-all
  "gi" 'magit-init
  "gb" 'magit-branch
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

(setq-default display-line-numbers 'visual
              display-line-numbers-current-absolute t
              display-line-numbers-width 0
              display-line-numbers-widen t)
(set-face-attribute 'line-number nil)
(set-face-attribute 'line-number-current-line nil
                    :background nil :foreground "#9E3A01")



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

;; Run C programs directly from within emacs
(defun execute-c-program ()
  (interactive)
  (defvar foo)
  (setq foo (concat "gcc " (buffer-name) " && ./a.out" ))
  (shell-command foo))

(global-set-key [C-f1] 'execute-c-program)

;; to make scrolling smoother:
(setq redisplay-dont-pause t
      scroll-margin 1
      scroll-step 1
      scroll-conservatively 10000
      scroll-preserve-screen-position 1)


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

(global-set-key (kbd "<f6>") (lambda() (interactive)(find-file "~/.emacs.d/init.el")))

(global-set-key (kbd "<f5>") (lambda() (interactive)(find-file "~/org/wiki/Semestre_5.org")))

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


;;=====================================================================


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(org-wiki-location-list (quote ("~/org-wiki")))
 '(package-selected-packages (quote (org-wiki xclip evil-magit magit diff-hl))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
