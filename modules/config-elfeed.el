;; Elfeed configuration

(use-package elfeed
  :ensure t)

(use-package elfeed-goodies
  :after elfeed
  :init
  (elfeed-goodies/setup))

(use-package elfeed-dashboard
  :ensure t
  :config
  (setq elfeed-dashboard-file "~/elfeed-dashboard.org")
  ;; update feed counts on elfeed-quit
  (advice-add 'elfeed-search-quit-window :after #'elfeed-dashboard-update-links))

(use-package elfeed-org
  :ensure t
  :init
  (elfeed-org))


(provide 'config-elfeed)
