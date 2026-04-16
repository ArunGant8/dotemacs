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

;; gptel-quick
(require 'gptel-quick)

(keymap-set embark-general-map "?" #'gptel-quick)

;; AG EXPERIMENTAL
(use-package gptel-agent
  :vc ( :url "https://github.com/karthink/gptel-agent"
        :rev :newest)
  :config (gptel-agent-update))         ;Read files from agents directories

;; Org Babel support for AI
;; AG EXPERIMENTAL
(use-package ob-gptel
  :vc ( :url "https://github.com/jwiegley/ob-gptel"
	:rev :newest)
  :config
  (add-to-list 'org-babel-load-languages '(gptel . t))
  (defun ob-gptel-setup-completions ()
    (add-hook 'completion-at-point-functions
              'ob-gptel-capf nil t))
  :hook (org-mode . ob-gptel-setup-completions))

(provide 'config-ai)
