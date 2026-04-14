;; AI from within Emacs using GPTel

(use-package gptel
  :ensure t)

(setq
 gptel-model   'test
 gptel-backend (gptel-make-openai "llama-cpp"
                 :stream t
                 :protocol "http"
                 :host "localhost:8001"
		 :header (lambda () '())
                 :models '(test)))

(provide 'config-ai)
