(use-package nasm-mode
  :ensure t)

(use-package x86-lookup
  :after nasm-mode
  :config
  (global-set-key (kbd "C-h C-x") #'x86-lookup))

(provide 'config-assembly)
