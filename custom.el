(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(erc-modules
   '(autojoin button completion fill imenu irccontrols list match menu
	      move-to-prompt netsplit networks readonly ring sasl
	      stamp track))
 '(org-mode-hook
   '(org-ref-prettify-mode org-roam-bibtex-mode org-ref-org-menu
			   citar-capf-setup org-tempo-setup
			   org-latex-preview-center-mode
			   org-latex-preview-mode
			   org-latex-preview--clear-preamble-cache
			   turn-on-org-cdlatex org-modern-mode
			   #[0 "\301\211\20\207"
			       [imenu-create-index-function
				org-imenu-get-tree]
			       2]
			   #[0 "\300\301\302\303\304$\207"
			       [add-hook change-major-mode-hook
					 org-fold-show-all append
					 local]
			       5]
			   #[0 "\300\301\302\303\304$\207"
			       [add-hook change-major-mode-hook
					 org-babel-show-result-all
					 append local]
			       5]
			   org-babel-result-hide-spec
			   org-babel-hide-all-hashes))
 '(package-selected-packages
   '(auctex casual cdlatex citar citar-org-roam consult counsel dune
	    easysession elfeed elfeed-dashboard elfeed-goodies
	    elfeed-org elpy engrave-faces exec-path-from-shell
	    geiser-chez geiser-racket helm helm-bibtex ivy-bibtex
	    latex-preview-pane macrostep-geiser magit marginalia
	    markdown-mode merlin mixed-pitch nasm-mode org-mode
	    org-modern org-noter org-ref org-ref-prettify org-roam
	    org-roam-bibtex ox-typst pdf-tools popper sly sml-mode
	    spacious-padding utop vterm x86-lookup yasnippet))
 '(package-vc-selected-packages
   '((org-mode :url "https://code.tecosaur.net/tec/org-mode" :branch
	       "dev"))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "FantasqueSansM Nerd Font" :height 140))))
 '(fixed-pitch ((t (:family "Roboto Mono" :height 120))))
 '(variable-pitch ((t (:family "ETBembo" :height 140 :weight thin)))))
