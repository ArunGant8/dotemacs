(use-package spacious-padding
  :ensure t)

(setq spacious-padding-subtle-mode-line t)
(spacious-padding-mode)

;; Mixed-pitch mode

(use-package mixed-pitch
  :ensure t
  :hook
  (text-mode . mixed-pitch-mode)
  :config
  (setq mixed-pitch-set-height t)
  (add-to-list 'mixed-pitch-fixed-pitch-faces 'org-todo))



(provide 'config-editor)
