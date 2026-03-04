;; Settings for version control from within Emacs

;; Magit
(use-package magit
  :ensure t
  :config
  (setq magit-show-long-lines-warning nil))

;; Only this much for now. Will add more as I figure stuff out :)

(provide 'config-vc)
