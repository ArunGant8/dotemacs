;; Embark
;; Think of `embark-act` as a right-click menu
;; add more stuff as needed
(use-package embark
  :ensure t

  :bind
  (("C-." . embark-act)         ;; pick some comfortable binding
   ("C-;" . embark-dwim)        ;; good alternative: M-.
   ("C-h B" . embark-bindings)) ;; alternative for `describe-bindings'

  :init

  ;; Optionally replace the key help with a completing-read interface
  (setq prefix-help-command #'embark-prefix-help-command)

  ;; Show the Embark target at point via Eldoc. You may adjust the
  ;; Eldoc strategy, if you want to see the documentation from
  ;; multiple providers. Beware that using this can be a little
  ;; jarring since the message shown in the minibuffer can be more
  ;; than one line, causing the modeline to move up and down:

  ;; (add-hook 'eldoc-documentation-functions #'embark-eldoc-first-target)
  ;; (setq eldoc-documentation-strategy #'eldoc-documentation-compose-eagerly)

  ;; Add Embark to the mouse context menu. Also enable `context-menu-mode'.
  ;; (context-menu-mode 1)
  ;; (add-hook 'context-menu-functions #'embark-context-menu 100)

  :config

  ;; Hide the mode line of the Embark live/completions buffers
  (add-to-list 'display-buffer-alist
               '("\\`\\*Embark Collect \\(Live\\|Completions\\)\\*"
                 nil
                 (window-parameters (mode-line-format . none)))))

;; Consult users will also want the embark-consult package.
(use-package embark-consult
  :ensure t) ; only need to install it, embark loads it after consult if found

(use-package vterm
  :load-path "/nix/store/h1qssg0iif589lpp5kfibwv10waivmn4-emacs-vterm-20251119.1653/share/emacs/site-lisp/elpa/vterm-20251119.1653"
  :ensure t)

;; Snippets

(use-package yasnippet
  :ensure t
  :init
  (yas-global-mode 1)
  :config
  (setq yas-snippet-dirs
	'("~/.emacs.d/snippets"))
  )

;; Sessions

(use-package easysession
  :ensure t

  :init
  (add-hook 'emacs-startup-hook #'easysession-load-including-geometry 102)
  (add-hook 'emacs-startup-hook #'easysession-save-mode 103)

  :custom
  (easysession-save-interval (* 10 60))
  (easysession-save-mode-lighter-show-session-name t)

  :config
  ;; Main keybindings
  (global-set-key (kbd "C-c sl") 'easysession-switch-to)  ; Load
  (global-set-key (kbd "C-c ss") 'easysession-save)  ; Save

  ;; Other keybindings
  (global-set-key (kbd "C-c sL") 'easysession-switch-to-and-restore-geometry)
  (global-set-key (kbd "C-c sd") 'easysession-delete)
  (global-set-key (kbd "C-c sr") 'easysession-rename)
  (global-set-key (kbd "C-c sR") 'easysession-reset)

  (defun my/empty-easysession ()
    "Set up a minimal environment when easysession creates a new session."
    (when (and (boundp 'tab-bar-mode) tab-bar-mode)
      (tab-bar-close-other-tabs))
    (delete-other-windows)
    (scratch-buffer))

  (add-hook 'easysession-new-session-hook #'my/empty-easysession)
  (add-hook 'easysession-before-load-hook #'easysession-reset)
  (add-hook 'easysession-new-session-hook #'easysession-reset))

;; Popup buffers
(use-package popper
  :ensure t ; or :straight t
  :bind (("C-`"   . popper-toggle)
         ("M-`"   . popper-cycle)
         ("C-M-`" . popper-toggle-type))
  :init
  (setq popper-reference-buffers
        '("\\*Messages\\*"
          "Output\\*$"
          "\\*Async Shell Command\\*"
	  "\\*scratch\\*"
	  "\\*vterm\\*"
	  "\\*response\\*"
          help-mode
          compilation-mode))
  (setq popper-window-height (lambda (win)
			  (fit-window-to-buffer
			   win
			   :max-height (floor (frame-height) 2)
			   :min-height (floor (frame-height) 2))))
  (popper-mode +1)
  (popper-echo-mode +1))                ; For echo area hints

;; Undo-tree
(use-package undo-tree
  :ensure t
  :init
  (global-undo-tree-mode +1))


;; Pretty symbols
(use-package svg-lib
  :ensure t
  :custom
  (svg-lib-style-default '(:background "#fbf7f0" :foreground "#000000" :padding 1 :margin 0 :stroke 2 :radius 3 :alignment 0.5 :width 20 :height 0.9 :scale 0.75 :ascent center :crop-left nil :crop-right nil :collection "material" :font-family "Iosevmata" :font-size 12 :font-weight regular)))

;; TODO Add more configuration to this
;; It seems better to use `svg-lib-tag`
;; instead of `svg-tag-make` simply because
;; of the options provided
(use-package svg-tag-mode
  :after svg-lib
  :hook
  (org-mode . svg-tag-mode)
  :custom
  (svg-tag-tags
   '(("TODO" . ((lambda (tag)
		  (svg-lib-tag "TODO" nil :font-weight 600 :background "red" :foreground "white"))))
     ("INPROGRESS" . ((lambda (tag)
			(svg-lib-tag "INPROGRESS" nil :background "orange" :foreground "white"))))
     ("DONE" . ((lambda (tag)
		  (svg-tag-make "DONE" :face 'custom-comment))))
     ("CANCELLED" . ((lambda (tag)
		       (svg-tag-make "CANCELLED" :face 'org-modern-done))))
     ("LOOKUP" . ((lambda (tag)
		    (svg-lib-icon+tag "magnify" "LOOKUP" nil :background "red" :foreground "white"))))
     ("FOUND" . ((lambda (tag)
		   (svg-tag-make "FOUND" :face 'custom-comment))))
     ("THINK" . ((lambda (tag)
		   (svg-lib-icon+tag "lightbulb-on" "THINK"  nil :background "orange" :foreground "white"))))
     ("UNRESOLVED" . ((lambda (tag)
			(svg-lib-icon+tag "help" "UNRESOLVED" nil :background "red" :foreground "white"))))
     ("[^A-Z]RESOLVED" . ((lambda (tag)
			    (svg-tag-make "RESOLVED" :face 'custom-comment))))
     ("[^A-Z]SOLVED" . ((lambda (tag)
			  (svg-tag-make "SOLVED" :face 'custom-comment)))) ;; hacky
     ("\\[#A\\]" . ((lambda (tag)
		       (svg-tag-make "A" :face 'cursor))))
     ("\\[#B\\]" . ((lambda (tag)
		      (svg-tag-make "B" :face 'isearch))))
     ("\\[#C\\]" . ((lambda (tag)
		      (svg-tag-make "C" :face 'highlight))))
     ("\\(:[A-Za-z]+:\\)" . ((lambda (tag)
                            (svg-tag-make tag :beg 1 :end -1 :font-size 12 :face 'org-warning)))))))

(use-package svg-tag-mode
  :ensure t
  :config
  (defconst date-re "[0-9]\\{4\\}-[0-9]\\{2\\}-[0-9]\\{2\\}")
  (defconst time-re "[0-9]\\{2\\}:[0-9]\\{2\\}")
  (defconst day-re "[A-Za-z]\\{3\\}")
  (defconst day-time-re (format "\\(%s\\)? ?\\(%s\\)?" day-re time-re))

  (defun svg-progress-percent (value)
    (save-match-data
      (svg-image (svg-lib-concat
		  (svg-lib-progress-bar  (/ (string-to-number value) 100.0)
					 nil :margin 0 :stroke 2 :radius 3 :padding 2 :width 11)
		  (svg-lib-tag (concat value "%")
                               nil :stroke 0 :margin 0)) :ascent 'center)))

  (defun svg-progress-count (value)
    (save-match-data
      (let* ((seq (split-string value "/"))           
             (count (if (stringp (car seq))
			(float (string-to-number (car seq)))
                      0))
             (total (if (stringp (cadr seq))
			(float (string-to-number (cadr seq)))
                      1000)))
	(svg-image (svg-lib-concat
                    (svg-lib-progress-bar (/ count total) nil
                                          :margin 0 :stroke 2 :radius 3 :padding 2 :width 11)
                    (svg-lib-tag value nil
				 :stroke 0 :margin 0)) :ascent 'center))))
  (dolist (tagstring
	   ;; Active date (with or without day name, with or without time)
	   `((,(format "\\(<%s>\\)" date-re) .
	      ((lambda (tag)
		 (svg-tag-make tag :beg 1 :end -1 :margin 0))))
	     (,(format "\\(<%s \\)%s>" date-re day-time-re) .
	      ((lambda (tag)
		 (svg-tag-make tag :beg 1 :inverse nil :crop-right t :margin 0))))
	     (,(format "<%s \\(%s>\\)" date-re day-time-re) .
	      ((lambda (tag)
		 (svg-tag-make tag :end -1 :inverse t :crop-left t :margin 0))))

	     ;; Inactive date  (with or without day name, with or without time)
	     (,(format "\\(\\[%s\\]\\)" date-re) .
	      ((lambda (tag)
		 (svg-tag-make tag :beg 1 :end -1 :margin 0 :face 'org-date))))
	     (,(format "\\(\\[%s \\)%s\\]" date-re day-time-re) .
	      ((lambda (tag)
		 (svg-tag-make tag :beg 1 :inverse nil :crop-right t :margin 0 :face 'org-date))))
	     (,(format "\\[%s \\(%s\\]\\)" date-re day-time-re) .
	      ((lambda (tag)
		 (svg-tag-make tag :end -1 :inverse t :crop-left t :margin 0 :face 'org-date))))

	     ;; ;; Progress
	     ("\\(\\[[0-9]\\{1,3\\}%\\]\\)" . ((lambda (tag)
						 (svg-progress-percent (substring tag 1 -2)))))
	     ("\\(\\[[0-9]+/[0-9]+\\]\\)" . ((lambda (tag)
					       (svg-progress-count (substring tag 1 -1)))))))
    (cl-pushnew tagstring svg-tag-tags
		:test (lambda (a b) (string-equal (car a) (car b))))))

(provide 'config-utils)
