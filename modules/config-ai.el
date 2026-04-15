;; AI from within Emacs using GPTel

(use-package gptel
  :ensure t
  :config
  (setq
   gptel-model   'test
   gptel-backend (gptel-make-openai "llama-cpp"
                   :stream t
                   :protocol "http"
                   :host "localhost:8001"
		   :header (lambda () '())
                   :models '(test))
   gptel-default-mode 'org-mode))



(provide 'config-ai)
