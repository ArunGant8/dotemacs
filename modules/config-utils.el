(use-package vterm
  :ensure t)

;; Snippet

(use-package yasnippet
  :ensure t
  :init
  (yas-global-mode 1)
  :config
  (setq yas-snippet-dirs
	'("~/.emacs.d/snippets"
	  )))

(provide 'config-utils)
