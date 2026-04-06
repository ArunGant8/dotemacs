(use-package spacious-padding
  :ensure t)

(spacious-padding-mode)

;; Mode line
(setq-default mode-line-format '((:eval (propertize " POP" 'face 'mode-line-emphasis))
				 ("%e" mode-line-front-space (:propertize
							      ("" mode-line-mule-info
							       mode-line-client
							       mode-line-modified
							       mode-line-remote
							       mode-line-window-dedicated)
							      display (min-width (6.0)))
				  mode-line-frame-identification
				  mode-line-buffer-identification "   "
				  mode-line-position
				  (project-mode-line project-mode-line-format)
				  (vc-mode vc-mode) "  "
				  "(" mode-name ")"
				  mode-line-misc-info mode-line-end-spaces)))

;; Mixed-pitch mode

(use-package mixed-pitch
  :ensure t
  :hook
  (text-mode . mixed-pitch-mode)
  :config
  (setq mixed-pitch-set-height t)
  (add-to-list 'mixed-pitch-fixed-pitch-faces 'org-todo)
  (add-to-list 'mixed-pitch-fixed-pitch-faces 'org-done))

;; Dired additions

;; Toggle as sidebar
(use-package dired-toggle
  :defer t
  :bind (("C-c C-t" . #'dired-toggle)
	 :map dired-mode-map
	 ("q" . #'dired-toggle-quit)
	 ([remap dired-find-file] . #'dired-toggle-find-file)
	 ([remap dired-up-directory] . #'dired-toggle-up-directory)
	 ("C-c C-u" . #'dired-toggle-up-directory))
  :config
  (setq dired-toggle-window-size 32) ;; experiment with this
  (setq dired-toggle-window-side 'left)

  ;; Optional, enable =visual-line-mode= for our narrow dired buffer:
  (add-hook 'dired-toggle-mode-hook
	    (lambda () (interactive)
	      (visual-line-mode 1)
	      (setq-local visual-line-fringe-indicators '(nil right-curly-arrow))
	      (setq-local word-wrap nil))))

(use-package dired-posframe
  :after (dired posframe)
  :init
  (dired-posframe-mode)
  :bind (:map dired-mode-map
              ("C-*" . dired-posframe-show)))

(provide 'config-editor)
