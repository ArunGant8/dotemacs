(load "~/Projects/teyjus/emacs/teyjus.el")

;; Don't know why Emacs is unable to find this
(setq tjcc "~/Projects/teyjus/_build/install/default/bin/tjcc")

(defun my/lp-toggle-between-mod-and-sig (file)
  "Toggle between a .mod file and its corresponding
  .sig file in a lambdaProlog project"
  (interactive (list (file-name-nondirectory (buffer-file-name))))
  (let ((filename (file-name-sans-extension file))
	(extension (file-name-extension file)))
    (cond
     ((string-equal extension "mod")
      (find-file (concat filename ".sig")))
     ((string-equal extension "sig")
      (find-file (concat filename ".mod"))))))

(keymap-global-set "C-c p t" #'my/lp-toggle-between-mod-and-sig)

(provide 'config-lprolog)
