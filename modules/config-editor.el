(use-package spacious-padding
  :ensure t)

(setq spacious-padding-subtle-mode-line t)
(spacious-padding-mode)

;; Mixed-pitch mode

(use-package mixed-pitch
  :hook
  (text-mode . mixed-pitch-mode))


(provide 'config-editor)
