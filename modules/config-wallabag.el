;; Wallabag configuration

(use-package wallabag
  :defer t
  :config
  (setq wallabag-host "https://app.wallabag.it") ;; wallabag server host name
  (setq wallabag-username "Arceus") ;; username
  (setq wallabag-password "w@ll@B@g") ;; password - maybe encrypt this later
  (setq wallabag-clientid "40118_646fv9pg1t8o440ww0g0skgk8w8g44gc8owk4cos0oc8sckssw") ;; created with API clients management
  (setq wallabag-secret "5zthk1bib3c48g8go8kwg40ggoc4cc8goocso88co4s80cw0ws") ;; created with API clients management
  (setq wallabag-search-print-items '("title" "domain" "tag" "reading-time" "date")) ;; control what content should be show in *wallabag-search*
  (setq wallabag-search-page-max-rows 32)) ;; how many items shown in one page
  ;; (setq wallabag-db-file "~/OneDrive/Org/wallabag.sqlite") ;; optional, default is saved to ~/.emacs.d/.cache/wallabag.sqlite


(provide 'config-wallabag)
