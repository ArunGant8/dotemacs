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


(provide 'config-macos)
