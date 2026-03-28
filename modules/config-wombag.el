;; Wombag is an Emacs interface to Wallabag (https://app.wallabag.it)
;; which is a better, open-source version of Instapaper, say. You
;; add to it stuff that you collected from the Internet and want to
;; read.

(use-package wombag
  :vc (:url "https://github.com/karthink/wombag")
  :ensure t
  :custom
  (wombag-host "https://app.wallabag.it")
  (wombag-username "Arceus")
  (wombag-password "w@ll@B@g") ;; encrypt it, maybe
  (wombag-client-id "40118_646fv9pg1t8o440ww0g0skgk8w8g44gc8owk4cos0oc8sckssw")
  (wombag-client-secret "5zthk1bib3c48g8go8kwg40ggoc4cc8goocso88co4s80cw0ws")
  ;; The following is due to an error in Karthink's code
  (wombag-db-file (file-name-concat wombag-dir "wombag.sqlite")))


(provide 'config-wombag)
