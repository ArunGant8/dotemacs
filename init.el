(setq custom-file "~/.emacs.d/custom.el")
(load custom-file)

;; init screen
(setq inhibit-startup-screen t)
;;(menu-bar-mode -1)
(scroll-bar-mode -1)  ;; Remove this line once you switch to emacs-daemon
(defun my/disable-scroll-bars (frame)
  (modify-frame-parameters frame
			   '((vertical-scroll-bars . nil)
			     (horizontal-scroll-bars . nil))))
(add-hook 'after-make-frame-functions 'my/disable-scroll-bars)
(tool-bar-mode -1)
;;(setq initial-buffer-choice t)
;;(set-frame-font "Fira Code 10" nil t)
(setq default-frame-alist '((width . 100) (height . 50)))

(line-number-mode t)
(column-number-mode t)
(size-indication-mode t)
(global-hl-line-mode t)

(save-place-mode 1)

(load-theme 'modus-operandi :no-confirm)

(custom-theme-set-faces
 'user
 '(default ((t (:family "FantasqueSansM Nerd Font" :height 140))))
 '(variable-pitch ((t (:family "ETBembo" :height 140 :weight thin))))
 '(fixed-pitch ((t (:family "Roboto Mono" :height 120)))))

(add-to-list 'package-archives
	     '("melpa" . "https://melpa.org/packages/") t)

(use-package spacious-padding
  :ensure t)

(setq spacious-padding-subtle-mode-line t)
(spacious-padding-mode)

(use-package exec-path-from-shell
  :ensure t)
(exec-path-from-shell-initialize)

;; Mac-specific stuff
(if (eq mac-command-modifier 'super)
    (progn
      (setq mac-command-modifier 'meta)
      (setq mac-option-modifier 'super)))

;; Enable emoji, and stop the UI from freezing when trying to display them
(when (fboundp 'set-fontset-font)
  (set-fontset-font t 'unicode "Apple Color Emoji" nil 'prepend))

;; disable the annoying bell ring
(setq ring-bell-function 'ignore)

;; y/n everywhere
(fset 'yes-or-no-p 'y-or-n-p)

;; store backups and autosaves in the tmp dir
(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))

(global-auto-revert-mode t)

(use-package which-key
  :ensure t
  :config (which-key-mode))

(add-to-list 'load-path "~/.emacs.d/modules/")

;; Load modules

;; Editor
(require 'config-editor)

;; Utils
(require 'config-utils)
(require 'config-calc)

;; Languages
(require 'config-latex)
(require 'config-org)
(require 'config-ocaml)
(require 'config-abella)

;; TODO:
;; 1. Undo-tree
;; 2. Snippets with Yasnippet
;; 3. Scheme and Lisp support
;; 4. Python support
(put 'narrow-to-region 'disabled nil)
