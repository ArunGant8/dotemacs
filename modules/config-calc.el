(require 'transient)

(use-package casual
  :ensure t)

(keymap-set calc-mode-map "C-o" #'casual-calc-tmenu)
(keymap-set calc-alg-map "C-o" #'casual-calc-tmenu)


(provide 'config-calc)
