;; Seems like a one-stop solution :)
(use-package elpy
  :ensure t
  :defer t
  :init
  (advice-add 'python-mode :before 'elpy-enable))

(provide 'config-python)
