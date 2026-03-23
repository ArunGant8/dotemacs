;; The appearance - Org Modern
(use-package org-modern
  :ensure t
  :hook (org-mode . org-modern-mode)
  :custom
  (org-modern-block-name '(("src". (" " ""))
			   ("quote" . ("❝ " "❞"))
			   ("example" . (" " ""))
			   ;; Add more
			   (t . t)))
  (org-modern-star 'replace)
  (org-modern-priority
    '((?A . "❗")
      (?B . "⬆")
      (?C . "⬇")))
  (org-modern-todo nil)
  (org-modern-tag nil))

(setq
 org-auto-align-tags nil
 org-tags-column 0
 org-catch-invisible-edits 'show-and-error
 org-special-ctrl-a/e t
 org-insert-heading-respect-content t

 ;; Org styling
 org-hide-emphasis-markers t
 org-pretty-entities t
 org-agenda-tags-column 0
 org-ellipsis "…"
 org-image-max-width 'window)

;; (defun my/org-prettify-symbols ()
;;   (setq prettify-symbols-alist
;;         (mapcan (lambda (x) (list x (cons (upcase (car x)) (cdr x))))
;;                 '(;; ("#+begin_src" . ?)
;;                   (":properties:" . "")
;;                   ;; ("#+end_src" . ?)
;;                   ("#+begin_src" . ?)
;;                   ;; ("#+begin_src" . ?)
;;                   ;; ("#+end_src" . ?)
;;                   ;; ("#+begin_src" . "")
;;                   ("#+end_src" . "―")
;;                   ("#+begin_example" . ?)
;;                   ("#+end_example" . ?)
;;                   ("scheduled:" . ?)
;;                   ("deadline:" . ?)
;;                   ;; ("#+header:" . ?)
;;                   ;; ("#+name:" . ?﮸)
;;                   ;; ("#+results:" . ?)
;;                   ;; ("#+call:" . ?)
;;                   ;; (":properties:" . ?)
;;                   ;; (":logbook:" . ?)
;;                   (":end:" . "―")
;;                   ("#+attr_latex:"    . "🄛")
;;                   ("#+attr_html:"     . "🄗")
;;                   ("#+attr_org:"      . "⒪")
;;                   ("#+begin_quote:"   . "❝")
;;                   ("#+end_quote:"     . "❞"))))
;;   (prettify-symbols-mode 1))

;; (add-hook 'org-modern-mode-hook #'my/org-prettify-symbols)

;;(global-org-modern-mode)

(add-hook 'org-mode-hook #'turn-on-org-cdlatex)

;; Org LaTeX Previews
(use-package org-latex-preview
  :config
  ;; Increase preview width
  ;; (plist-put org-latex-preview-appearance-options
  ;;            :page-width nil)

  ;; ;; Use dvisvgm to generate previews
  ;; ;; You don't need this, it's the default:
  ;; (setq org-latex-preview-process-default 'dvisvgm)
  
  ;; Turn on `org-latex-preview-mode', it's built into Org and much faster/more
  ;; featured than org-fragtog. (Remember to turn off/uninstall org-fragtog.)
  (add-hook 'org-mode-hook 'org-latex-preview-mode)

  ;; ;; Block C-n, C-p etc from opening up previews when using `org-latex-preview-mode'
  ;; (setq org-latex-preview-mode-ignored-commands
  ;;       '(next-line previous-line mwheel-scroll
  ;;         scroll-up-command scroll-down-command))

  ;; ;; Enable consistent equation numbering
  ;; (setq org-latex-preview-numbered t)

  ;; Bonus: Turn on live previews.  This shows you a live preview of a LaTeX
  ;; fragment and updates the preview in real-time as you edit it.
  ;; To preview only environments, set it to '(block edit-special) instead
  
  ;; This is buggy and is slowing me down at the moment
  ;; (setq org-latex-preview-mode-display-live t)

  ;; More immediate live-previews -- the default delay is 1 second
  (setq org-latex-preview-mode-update-delay 0.25))

;; code for centering LaTeX previews -- a terrible idea
(use-package org-latex-preview
  :config
  (defun my/org-latex-preview-uncenter (ov)
    (overlay-put ov 'before-string nil))
  (defun my/org-latex-preview-recenter (ov)
    (overlay-put ov 'before-string (overlay-get ov 'justify)))
  (defun my/org-latex-preview-center (ov)
    (save-excursion
      (goto-char (overlay-start ov))
      (when-let* ((elem (org-element-context))
                  ((or (eq (org-element-type elem) 'latex-environment)
                       (string-match-p "^\\\\\\[" (org-element-property :value elem))))
                  (img (overlay-get ov 'display))
                  (prop `(space :align-to (- center (0.55 . ,img))))
                  (justify (propertize " " 'display prop 'face 'default)))
        (overlay-put ov 'justify justify)
        (overlay-put ov 'before-string (overlay-get ov 'justify)))))
  (define-minor-mode org-latex-preview-center-mode
    "Center equations previewed with `org-latex-preview'."
    :global nil
    (if org-latex-preview-center-mode
        (progn
          (add-hook 'org-latex-preview-overlay-open-functions
                    #'my/org-latex-preview-uncenter nil :local)
          (add-hook 'org-latex-preview-overlay-close-functions
                    #'my/org-latex-preview-recenter nil :local)
          (add-hook 'org-latex-preview-overlay-update-functions
                    #'my/org-latex-preview-center nil :local))
      (remove-hook 'org-latex-preview-overlay-close-functions
                    #'my/org-latex-preview-recenter)
      (remove-hook 'org-latex-preview-overlay-update-functions
                    #'my/org-latex-preview-center)
      (remove-hook 'org-latex-preview-overlay-open-functions
                   #'my/org-latex-preview-uncenter))))

(add-hook 'org-mode-hook 'org-latex-preview-center-mode)

;; Literate Programming

(require 'org-tempo)

(org-babel-do-load-languages
 'org-babel-load-languages
 '((scheme . t)
   (ocaml . t)
   (python . t)
   (perl . t)
   (nix . t)))

;; Typst export

(use-package ox-typst
  :after ox
  :defer
  :config
  (setq org-typst-from-latex-environment #'org-typst-from-latex-with-pandoc
      org-typst-from-latex-fragment #'org-typst-from-latex-with-pandoc))


;; LaTeX export

;;(setq org-latex-listings 't) ;; Use listings for code export

(use-package ox-latex
  :after ox
  :defer
  :config
  (when (executable-find "latexmk")
    (setq org-latex-pdf-process '("latexmk -f -pdf -%latex -shell-escape -interaction=nonstopmode -output-directory=%o %f")))
  ;; (dolist (package '(;; (""                          "hyperref" t)
  ;; 		     (""                          "proof"    t)
  ;; 		     (""                          "amsmath"  t)
  ;; 		     (""                          "amssymb"  t)
  ;; 		     ;;("a4paper, margin=0.5in"     "geometry" nil)
  ;; 		     ("T1"                        "fontenc"  nil)
  ;; 		     ("breakable, xparse, skins"  "tcolorbox" t)
  ;; 		     ;;(""                          "minted" t)
  ;; 		     ("dvipsnames,svgnames,table" "xcolor" t)
  ;; 		     (""                          "cmll"   t) ;; improved linear logic symbols
  ;; 		     (""                          "framed" t)
  ;; 		     (""                          "enumitem" nil)
  ;; 		     (""                          "dsfont" t)
  ;; 		     (""                          "tikz" t)
  ;; 		      ))
  ;;   (cl-pushnew package org-latex-packages-alist
  ;; 		 :test (lambda (a b) (equal (cadr a) (cadr b)))))
  (setq org-latex-packages-alist
	'((""                          "proof"    t)
	  (""                          "amsmath"  t)
	  (""                          "amssymb"  t)
	  ;;("a4paper, margin=0.5in"     "geometry" nil)
	  ("T1"                        "fontenc"  nil)
	  ("breakable, xparse, skins"  "tcolorbox" t)
	  ;;(""                          "minted" t)
	  ("dvipsnames,svgnames,table" "xcolor" t)
	  (""                          "cmll"   t) ;; improved linear logic symbols
	  (""                          "framed" t)
	  (""                          "enumitem" nil)
	  (""                          "dsfont" t)
	  (""                          "tikz" t)))
  (let* ((article-sections '(("\\section{%s}"       . "\\section*{%s}")
                             ("\\subsection{%s}"    . "\\subsection*{%s}")
                             ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
                             ("\\paragraph{%s}"     . "\\paragraph*{%s}")
                             ("\\subparagraph{%s}"  . "\\subparagraph*{%s}"))))
    (pcase-dolist (`(,name ,class-string)
		   `(("article" "\\documentclass[11pt]{article}\n[NO-DEFAULT-PACKAGES]\n[PACKAGES]\n\\usepackage{palatino}\n\\usepackage[a4paper, margin=0.5in]{geometry}\n[EXTRA]")
		     ("notes" "\\documentclass{tufte-handout}\n[NO-DEFAULT-PACKAGES]\n[PACKAGES]\n[EXTRA]")))
		     ;;("beamer" "\\documentclass{beamer}\n[NO-DEFAULT-PACKAGES]\n[PACKAGES]\\usepackage{fira}\n[EXTRA]")))
      (setf (alist-get name org-latex-classes nil nil #'equal)
	    (append (list class-string) article-sections))))
  (setf (alist-get "beamer" org-latex-classes nil nil #'equal)
	(append (list "\\documentclass{beamer}\n[NO-DEFAULT-PACKAGES]\n[PACKAGES]\n[EXTRA]")
		'(("\\section{%s}" . "\\section*{%s}"))))		
  (setq
   org-latex-caption-above nil
   org-latex-prefer-user-labels t
   org-latex-hyperref-template
   "\\providecolor{url}{HTML}{0077bb}
\\providecolor{link}{HTML}{882255}
\\providecolor{cite}{HTML}{999933}
\\hypersetup{
  pdfauthor={%a},
  pdftitle={%t},
  pdfkeywords={%k},
  pdfsubject={%d},
  pdfcreator={%c},
  pdflang={%L},
  breaklinks=true,
  colorlinks=true,
  linkcolor=link,
  urlcolor=url,
  citecolor=cite}
\\urlstyle{same}\n"))

;;Presentations with Beamer
(use-package ox-beamer
  :defer
  :after ox
  ;; :init
  ;; (defun org-beamer-backend-p (info)
  ;;   (eq 'beamer (and (plist-get info :back-end)
  ;;                    (org-export-backend-name (plist-get info :back-end)))))

  ;; (add-to-list 'org-export-conditional-features
  ;;              '(org-beamer-backend-p . beamer) t)
  :config
  (setq org-beamer-theme "metropolis"))
;;        org-beamer-frame-level 2))

;; Code block export
(use-package org
  :defer
  :config

  ;; Engrave faces
  (use-package ox
    :if (version<= "9.5.4" org-version)
    :after ox
    :config
    ;;(setq org-latex-src-block-backend 'minted)
    (use-package engrave-faces
      :ensure t
      :config
      (setq org-latex-src-block-backend 'engraved))
    ))

;; Taking notes from PDFs

(use-package org-noter
  :ensure t
  :custom
  (org-noter-notes-search-path '("~/Documents/PhD/Notes/")))

;; Org Roam
;; Testing out this workflow. Not sure if I will keep using this or not.
(use-package org-roam
  :ensure t
  :custom
  (org-roam-directory (file-truename "~/Documents/PhD/Notes/"))
  (org-roam-capture-templates
   '(("d" "default" plain
         "%?"
         :target
         (file+head
          "%<%Y%m%d%H%M%S>-${slug}.org"
          "#+title: ${note-title}\n#+startup: latexpreview inlineimages\n")
         :unnarrowed t)
     ;; ("n" "literature note" plain
     ;;  "%?"
     ;;  :target
     ;;  (file+head
     ;;   "%(expand-file-name (or citar-org-roam-subdir \"\") org-roam-directory)/${citar-citekey}.org"
     ;;   "#+title: ${citar-citekey} (${citar-date}). ${note-title}.\n#+created: %U\n#+last_modified: %U\n\n")
     ;; :unnarrowed t)
     ("r" "ref" plain
      "%?"
      :target (file+head "refs/${citekey}.org"
                         "#+title: ${title}\n#+created: %U\n#+last_modified: %U\n#+startup: latexpreview inlineimages overview\n\n")
      :unnarrowed t)
     ("n" "ref + noter" plain
      "%?"
      :target (file+head "refs/${citekey}.org"
                         "#+title: ${title}\n#+created: %U\n#+last_modified: %U\n#+startup: latexpreview inlineimages overview\n\n* Notes on ${citekey} :noter:\n:PROPERTIES:\n:NOTER_DOCUMENT: %(orb-process-file-field \"${citekey}\")\n:NOTER_PAGE:\n:END:\n")
      :unnarrowed t)
     ("p" "programming" plain
      "%?"
      :target (file+head "code/${project}-notes.org"
			 "#+title: ${title}\n#+startup: latexpreview inlineimages\n#+created: %U\n#+PROPERTY: header-args:%^{Lang|ocaml|scheme}  :results output code replace\n#+PROPERTY: header-args:%\\1 :comments both\n#+PROPERTY: header-args:%\\1  :session %^{session-name|none}\n#+PROPERTY: header-args:%\\1  :tangle yes\n")
      :unnarrowed t)))
     ;; Easier way (possibly):
     ;; ("c" "citar literature note" plain "%?"
     ;;  :target (file+head "%(expand-file-name citar-org-roam-subdir org-roam-directory)/${citar-citekey}.org"
     ;; 			 "#+title: Notes on: ${citar-title}\n#+subtitle: ${citar-author}, ${citar-date}")
     ;;  :unnarrowed t)
  :bind (("C-c n l" . org-roam-buffer-toggle)
         ("C-c n f" . org-roam-node-find)
         ("C-c n g" . org-roam-graph)
         ("C-c n i" . org-roam-node-insert)
         ("C-c n c" . org-roam-capture)
         ;; Dailies
         ("C-c n j" . org-roam-dailies-capture-today))
  :config
  ;; If you're using a vertical completion framework, you might want a more informative completion interface
  (setq org-roam-node-display-template (concat "${title:*} " (propertize "${tags:10}" 'face 'org-tag)))
  (org-roam-db-autosync-mode))

  ;; Experimental
  ;; I don't think it's working
  ;; (cl-defmethod org-roam-node-lang ((node org-roam-node))
  ;;   (let ((lang (cdr (assoc-string "LANG" (org-roam-node-properties node)))))
  ;;     (if lang lang
  ;; 	(when org-roam-capture--node
  ;; 	  (setq lang (read-string "Lang: "))
  ;; 	  (push (cons "LANG" lang) (org-roam-node-properties node)))
  ;; 	lang))))
  ;; If using org-roam-protocol
  ;;(require 'org-roam-protocol))

;; To be clear, I am not interested in Org Roam by itself.
;; I want to integrate it with some type of bibliography
;; package and also with org-noter to ensure my notes on
;; various papers are accessible and interlinked.

;; Citar
;; For citations
(use-package citar
  :custom
  (citar-bibliography '("~/Documents/PhD/bibfiles/masterlib.bib"))
  (org-cite-insert-processor 'citar)
  (org-cite-follow-processor 'citar)
  (org-cite-activate-processor 'citar)
  :hook
  (LaTeX-mode . citar-capf-setup)
  (org-mode . citar-capf-setup)
  :bind
  (:map org-mode-map :package org ("C-c b" . #'org-cite-insert)))
  

;; Ok, so this seems to work.
;; Let's try integrating this with org-roam

(use-package citar-org-roam
  :after (citar org-roam)
  :config
  (citar-org-roam-mode)
  (citar-register-notes-source
   'orb-citar-source (list :name "Org-Roam Notes"
			   :category 'org-roam-node
			   :items #'citar-org-roam--get-candidates
			   :hasitems #'citar-org-roam-has-notes
			   :open #'citar-org-roam-open-note
			   :create #'orb-citar-edit-note
			   :annotate #'citar-org-roam--annotate))

  (setq citar-notes-source 'orb-citar-source))

;; Another alternative is to use org-roam-bibtex
;; which also uses citar.
;; For this we also need the following:

;; helm-bibtex
(use-package helm-bibtex
  :ensure t
  :custom
  (bibtex-completion-bibliography
   '("~/Documents/PhD/bibfiles/masterlib.bib"))
  (bibtex-completion-pdf-field "file"))

;; Org Ref
(use-package org-ref
  :ensure t
  :bind
  (:map org-mode-map (("C-c ]" . org-ref-insert-link)))
  :config
  (require 'org-ref-helm))

(use-package org-ref-prettify
  :defer
  :hook
  (org-mode . org-ref-prettify-mode))

;; And finally, org-roam-bibtex itself
(use-package org-roam-bibtex
  :after org-roam
  :hook
  (org-mode . org-roam-bibtex-mode)
  :config
  (require 'org-ref))

;; Org Capture templates for
;; code and webpage (EWW)

(use-package org
  :config
  (defvar my/file-extension-lang-alist
    '(("el" . "elisp")
      ("ml" . "ocaml")
      ("scm" . "scheme")
      ("nix" . "nix")
      ("py" . "python")
      ("pl" . "perl"))
    "An association list that matches a file's
     extension to a programming language")
  (defun my/lang-from-extension (filename)
    "If file contains source code, find
     the language that code is written in
     from the file extension."
    (let* ((ext (file-name-extension filename))
	   (res (assoc ext my/file-extension-lang-alist)))
      (if res (cdr res) ""))))

(use-package org
  :custom
  (org-capture-templates
   '(("c" "Code Snippet" entry (file "/Users/arun/Documents/PhD/Notes/code/captured-snippets.org")
      "* %^{Title:|Code from %f}\n:PROPERTIES:\n:FILE: %(string-replace \"\/Users\/arun\" \"\~\" \"%F\")\n:LINK: %a\n:END:\n#+begin_src %(my/lang-from-extension \"%f\")\n%i\n#+end_src\n %?"
      :jump-to-captured t
      :empty-lines-after 1)
     ("w" "Web Fragment" entry (file "/Users/arun/Documents/PhD/Notes/web/captured-content.org")
      "* Note from %^{Webpage desc|Web}\n:PROPERTIES:\n:URL: %l\n:END:\n#+begin_quote\n%i\n#+end_quote\n %?"
      :jump-to-captured t
      :empty-lines-after 1)))
  (org-capture-templates-contexts
   '(("w" ((in-mode . "eww-mode"))))))

;; Managing refile targets
(use-package org
  :config
  (defvar my/code-snippet-refile-targets
    (directory-files "~/Documents/PhD/Notes/code" nil ".org$"))
  (setq-default org-refile-targets
		`((,my/code-snippet-refile-targets . (:level . 1)))))

(use-package org
  :bind
  ("C-c c" . org-capture))

;; Org TODO Keywords

(use-package org
  :custom
  (org-todo-keywords
   ;; Keep adding to these as required
   '((sequence "TODO(t)" "INPROGRESS(i)" "|" "DONE(d) CANCELLED(c)")
     (sequence "UNRESOLVED(u)" "|" "RESOLVED(r)")
     (sequence "THINK" "|" "SOLVED(s)")
     (sequence "LOOKUP(l)" "|" "FOUND(f)")))
  (org-todo-keyword-faces
   ;; Keep adding to this as well
   '(("INPROGRESS" . "orange")))
  (org-agenda-files
   ;; Keep adding to this as well
   '("~/Documents/PhD/Notes"
     "~/Documents/PhD/Notes/refs"
     "~/Documents/PhD/Notes/code"
     "~/Documents/PhD/Notes/web"
     "~/Documents/PhD/Notes/daily"
     "~/Projects/rough-work/scheme"
     "~/Projects/rough-work/ocaml")))

;; Not sure how to use this,
;; may remove it

(use-package org-super-agenda
  :after org-agenda)

;; Org sidebar (copied from N. Rougier)

(use-package imenu-list
  :after org)

(use-package org
  :config
  (defun my/org-tree-to-indirect-buffer ()
    "Create indirect buffer, narrow it to current subtree and unfold blocks"
    
    (org-tree-to-indirect-buffer)
    (org-show-block-all)
    (setq-local my/org-blocks-hidden nil))

  (defun my/org-sidebar ()
    "Open an imenu list on the left that allow navigation."
    
    (interactive)
    (setq imenu-list-after-jump-hook #'my/org-tree-to-indirect-buffer
          imenu-list-position 'left
          imenu-list-size 36
          imenu-list-focus-after-activation t)

    (let ((heading (substring-no-properties (or (org-get-heading t t t t) ""))))
      (when (buffer-base-buffer)
	(switch-to-buffer (buffer-base-buffer)))
      (imenu-list-minor-mode)
      (imenu-list-stop-timer)
      (hl-line-mode)
      (face-remap-add-relative 'hl-line :inherit 'nano-subtle)
      (setq header-line-format
            '(:eval
              (nano-modeline-render nil
                                    (buffer-name imenu-list--displayed-buffer)
                                    "(outline)"
                                    "")))
      (setq-local cursor-type nil)
      (when (> (length heading) 0)
	(goto-char (point-min))
	(search-forward heading)
	(imenu-list-display-dwim))))

  ;; This toggles the org sidebar
  (defun my/org-sidebar-toggle ()
    "Toggle the org-sidebar"
    
    (interactive)
    (if (get-buffer-window "*Ilist*")
	(progn 
          (quit-window nil (get-buffer-window "*Ilist*"))
          (switch-to-buffer (buffer-base-buffer)))
      (my/org-sidebar))))

;; Habit Tracking

(use-package org
  :ensure t
  :config
  (add-to-list 'org-modules 'org-habit))

(provide 'config-org)
