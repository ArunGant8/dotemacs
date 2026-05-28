;; Rust configuration

;; 1. Rustic
;; From the documentation
(use-package rustic
  :ensure t
  :config
  (setq rustic-format-on-save nil)
  :custom
  (rustic-cargo-use-last-stored-arguments t))

;; 2. Cargo-mode
;; again, straight from the documentation
(use-package cargo-mode
  :hook
  (rust-mode . cargo-minor-mode)
  :config
  (setq compilation-scroll-output t))

(provide 'config-rust)
