(use-package vterm
  :ensure t)

;; Snippets

(use-package yasnippet
  :ensure t
  :init
  (yas-global-mode 1)
  :config
  (setq yas-snippet-dirs
	'("~/.emacs.d/snippets"))
  )

;; Sessions

(use-package easysession
  :ensure t

  :init
  (add-hook 'emacs-startup-hook #'easysession-load-including-geometry 102)
  (add-hook 'emacs-startup-hook #'easysession-save-mode 103)

  :custom
  (easysession-save-interval (* 10 60))
  (easysession-save-mode-lighter-show-session-name t)

  :config
  ;; Main keybindings
  (global-set-key (kbd "C-c sl") 'easysession-switch-to)  ; Load
  (global-set-key (kbd "C-c ss") 'easysession-save-as)  ; Save

  ;; Other keybindings
  (global-set-key (kbd "C-c sL") 'easysession-switch-to-and-restore-geometry)
  (global-set-key (kbd "C-c sd") 'easysession-delete)
  (global-set-key (kbd "C-c sr") 'easysession-rename)
  (global-set-key (kbd "C-c sR") 'easysession-reset)

  (defun my/empty-easysession ()
    "Set up a minimal environment when easysession creates a new session."
    (when (and (boundp 'tab-bar-mode) tab-bar-mode)
      (tab-bar-close-other-tabs))
    (delete-other-windows)
    (scratch-buffer))

  (add-hook 'easysession-new-session-hook #'my/empty-easysession)
  (add-hook 'easysession-before-load-hook #'easysession-reset)
  (add-hook 'easysession-new-session-hook #'easysession-reset))

;; Popup buffers
(use-package popper
  :ensure t ; or :straight t
  :bind (("C-`"   . popper-toggle)
         ("M-`"   . popper-cycle)
         ("C-M-`" . popper-toggle-type))
  :init
  (setq popper-reference-buffers
        '("\\*Messages\\*"
          "Output\\*$"
          "\\*Async Shell Command\\*"
	  "\\*scratch\\*"
	  "\\*vterm\\*"
          help-mode
          compilation-mode))
  (popper-mode +1)
  (popper-echo-mode +1))                ; For echo area hints


(provide 'config-utils)
