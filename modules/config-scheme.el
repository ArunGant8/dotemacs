;; Chez-Scheme
(use-package geiser-chez
  :ensure t)

(use-package macrostep-geiser
  :after geiser-mode
  :config (add-hook 'geiser-mode-hook #'macrostep-geiser-setup))

(global-set-key "\C-ce" 'macrostep-expand)

(use-package macrostep-geiser
  :after geiser-repl
  :config (add-hook 'geiser-repl-mode-hook #'macrostep-geiser-setup))

(put 'fresh 'scheme-indent-function 1)
(put 'run* 'scheme-indent-function 1)
(put 'conde 'scheme-indent-function 0)
(put 'define-extend 'scheme-indent-function 0)
(put 'cond 'scheme-indent-function 0)

;; Racket
(use-package geiser-racket
  :ensure t
  :config
  (when (eq system-type 'darwin)
    (setq geiser-racket-binary "/Applications/Racket v8.18/bin/racket")))


(provide 'config-scheme)
