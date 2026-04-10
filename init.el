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

;; previously: modus-operandi-tinted
(load-theme 'modus-operandi-tinted :no-confirm)

(custom-theme-set-faces
 'user
 ;;'(default ((t (:family "FantasqueSansM Nerd Font" :height 140))))
 '(default ((t (:family "Iosevmata" :height 125))))
 ;; '(variable-pitch ((t (:family "ETBookOT" :height 165))))
 ;; '(variable-pitch ((t (:family "Aporetic Serif Mono" :height 130))))
 '(variable-pitch ((t (:family "Charter" :height 140))))
 '(fixed-pitch ((t (:family "Iosevka Nerd Font Mono" :height 120))))
 `(mode-line ((t (:box nil :background ,(face-background 'default)
		       :overline ,(face-foreground 'default)))))
 `(mode-line-active ((t (:box nil :background ,(face-background 'default)
			      :overline ,(face-foreground 'default)))))
 `(mode-line-inactive ((t (:box nil :background ,(face-background 'default)
				:overline ,(face-foreground 'default))))))

;; Mode Line and Header Line settings

(setq-default header-line-format '(("%e" mode-line-front-space
				    (:propertize ("" mode-line-mule-info mode-line-client
						  mode-line-modified mode-line-remote
						  mode-line-window-dedicated)
						 display (min-width (6.0)))
				    mode-line-frame-identification mode-line-buffer-identification "   "
				    mode-line-position (project-mode-line project-mode-line-format)
				    (vc-mode vc-mode) "  " "(" mode-name ")"
				    mode-line-misc-info mode-line-end-spaces)))

(setq-default mode-line-format "")

;; WARN! This is kinda hardcoded, since it is inspired by the current theme I am using.
;; For other themes this might not be a good idea
(set-face-attribute 'font-lock-comment-face nil :foreground (face-foreground 'org-document-info-keyword))

;; Packages

(add-to-list 'package-archives
	     '("melpa" . "https://melpa.org/packages/") t)

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
;; Mac-specific
(when (eq system-type 'darwin)
  (require 'config-macos))

;; Completion
(require 'config-completion)

;; Utils
(require 'config-utils)
(require 'config-calc)
(require 'config-elfeed)
(require 'config-wallabag)
(require 'config-erc)
(require 'config-mail)
;; From Nicolas Rougier
(require 'nano-agenda)
(require 'nano-calendar)
(require 'notebook)

;; Version Control
(require 'config-vc)

;; Languages
(require 'config-latex)
(require 'config-org)
(require 'config-ocaml)
(require 'config-abella)
(require 'config-scheme)
(require 'config-lisp)
(require 'config-python)
(require 'config-lprolog)
(require 'config-markdown)
(require 'config-assembly)
(require 'config-nixlang)

(put 'narrow-to-region 'disabled nil)
(put 'downcase-region 'disabled nil)
(put 'upcase-region 'disabled nil)
