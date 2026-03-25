;; Email configuration
;; Influenced by Daviwil's notes
;; and Rougier's upgrades

(add-to-list 'load-path "/nix/store/14mnch90rl8667gjcp0rrqq31qvv9igx-mu-1.12.13-mu4e/share/emacs/site-lisp/mu4e/")

(use-package mu4e
  :ensure nil
  ;; the version number being hardcoded makes me think that I'll probably need to change this by hand :(
  :defer 20 ; Wait until 20 seconds after startup
  :custom

  ;; This is set to 't' to avoid mail syncing issues when using mbsync
  (mu4e-change-filenames-when-moving t)

  ;; Refresh mail using isync every 10 minutes
  (mu4e-update-interval (* 10 60))
  (mu4e-get-mail-command "mbsync --config ~/.emacs.d/.mbsyncrc lix")
  ;; Further customization:
  ;;(mu4e-html2text-command "w3m -T text/html" ; how to hanfle html-formatted emails
  ;;(mu4e-get-mail-command "mbsync -a")
  (mu4e-maildir "~/email/lixmail")

  (mu4e-drafts-folder "/Drafts")
  (mu4e-sent-folder   "/Sent")
;;  (mu4e-refile-folder "/[Gmail]/All Mail")
  (mu4e-trash-folder  "/Trash")

  (mu4e-maildir-shortcuts
	'((:maildir "/INBOX"             :key ?i)
          (:maildir "/Sent" :key ?s)
          (:maildir "/Trash"     :key ?t)
          (:maildir "/Drafts"    :key ?d)))

  (mu4e-bookmarks
   '((:name "Unread messages" :query "flag:unread AND NOT flag:trashed" :key ?i)
     (:name "Today's messages" :query "date:today..now" :key ?t)
     (:name "The Bosses" :query "from:dale.miller@inria.fr AND from:kaustuv.chauduri@inria.fr" :key ?s)
     (:name "Last 7 days" :query "date:7d..now" :hide-unread t :key ?w)
     (:name "Messages with images" :query "mime:image/*" :key ?p)))

  ;; Sending mail
  (smtpmail-smtp-server "argos.lix.polytechnique.fr")
  (smtpmail-smtp-service 587)
  (smtpmail-stream-type nil)  ;; another option is 'ssl

  (message-send-mail-function 'smtpmail-send-it)
  (mu4e-compose-format-flowed t)
  (mu4e-compose-signature "Arunava Gantait")
  (user-mail-address "gantait@lix.polytechnique.fr")
  (user-full-name "Arunava Gantait")
  
  :config
  ;; Run mu4e in the background to sync mail periodically
  (mu4e t))
;;          (:maildir "/[Gmail]/All Mail"  :key ?a)))) ;; I don't have this

;; Integration with Org
(use-package org-mime
  :ensure t)

(require 'mu4e-org)

;; There's lots more to be done here: setting up capture templates, etc.

;; UI
;; from Rougier, of course
(require 'mu4e-thread-folding)
(add-to-list 'mu4e-header-info-custom
             '(:empty . (:name "Empty"
                               :shortname ""
                               :function (lambda (msg) "  "))))
(setq mu4e-headers-fields '((:empty         .    2)
                            (:human-date    .   12)
                            (:flags         .    6)
                            (:mailing-list  .   10)
                            (:from          .   22)
                            (:subject       .   nil)))
(add-hook 'mu4e-headers-mode #'mu4e-thread-folding-mode)

(define-key mu4e-headers-mode-map (kbd "<tab>")     'mu4e-headers-toggle-at-point)
(define-key mu4e-headers-mode-map (kbd "<left>")    'mu4e-headers-fold-at-point)
(define-key mu4e-headers-mode-map (kbd "<S-left>")  'mu4e-headers-fold-all)
(define-key mu4e-headers-mode-map (kbd "<right>")   'mu4e-headers-unfold-at-point)
(define-key mu4e-headers-mode-map (kbd "<S-right>") 'mu4e-headers-unfold-all)

(provide 'config-mail)
