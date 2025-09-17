(use-package tuareg
  :ensure t)

(use-package merlin
  :ensure t)

(setq auto-mode-alist
      (append '(("\\.ml[ily]?\\'" . tuareg-mode)
                ("\\.topml\\'" . tuareg-mode))
              auto-mode-alist))

(use-package utop
  :ensure t)

(add-hook 'tuareg-mode-hook #'utop-minor-mode)
(add-hook 'tuareg-mode-hook #'merlin-mode)

(add-hook 'tuareg-mode-hook (lambda ()
                              (progn
                                (define-key tuareg-mode-map (kbd "C-c C-s")
                                  'utop)
                                (setq compile-command
                                      "opam config exec corebuild "))))

(setq merlin-use-auto-complete-mode t)

(setq utop-command "opam config exec utop -- -emacs"
      merlin-error-after-save nil)

(provide 'config-ocaml)
