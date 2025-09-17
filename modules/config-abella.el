  (defconst proof-site-file
    (expand-file-name "/Users/arun/PG/generic/proof-site.el"))
  (defconst lprolog-file
    (expand-file-name "/Users/arun/PG/abella/lprolog.el"))

  (defmacro delete-mappings (alist key)
    `(while (assoc ,key ,alist)
       (setq ,alist (delq (assoc ,key ,alist) ,alist))))

  (when (file-exists-p proof-site-file)
    (delete-mappings auto-mode-alist "\\.thm\\'")
    (setq proof-splash-enable nil
          proof-three-window-enable nil
          proof-three-window-mode-policy 'horizontal
          proof-output-tooltips nil
          proof-prog-name "/Users/arun/.opam/default/bin/abella")
    (load-file proof-site-file))

  (when (file-exists-p lprolog-file)
    (autoload 'lprolog-mode lprolog-file "Major mode for Lambda Prolog" t)
    (delete-mappings auto-mode-alist "\\.mod\\'")
    (add-to-list 'auto-mode-alist '("\\.mod\\'" . lprolog-mode))
    (add-to-list 'auto-mode-alist '("\\.sig\\'" . lprolog-mode)))

(provide 'config-abella)
