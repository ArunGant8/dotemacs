;; -*- lexical-binding: t; -*-

;; Configuration for Lean 4
(use-package lean4-mode
  :commands lean4-mode
  :vc (:url "https://github.com/leanprover-community/lean4-mode.git"
	    :rev :last-release)
  )

(provide 'config-lean)
