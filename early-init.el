;;; early-init.el --- Early init  -*- lexical-binding: t; -*-
(unless (file-exists-p "~/.emacs.d/elpa/org-mode/lisp/")
  (package-vc-install '(org-mode :url "https://code.tecosaur.net/tec/org-mode" :branch "dev")))

(when (file-exists-p "~/.emacs.d/elpa/org-mode/lisp/")
  (use-package org
    :load-path "~/.emacs.d/elpa/org-mode/lisp/"))
