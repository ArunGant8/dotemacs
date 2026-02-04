;; ERC configuration

;; I'm copying the sample configuration and modifying it as required

;; -*- lexical-binding: t -*-

(use-package erc
  :config
  ;; Prefer SASL to NickServ, colorize nicknames, and show side panels
  ;; with joined channels and members
  (setopt erc-modules
          (seq-union '(sasl nicks bufbar nickbar scrolltobottom)
                     erc-modules))

  :custom
  ;; Protect me from accidentally sending excess lines.
  (erc-inhibit-multiline-input t)
  (erc-send-whitespace-lines t)
  (erc-ask-about-multiline-input t)
  ;; Scroll all windows to prompt when submitting input.
  (erc-scrolltobottom-all t)

  ;; Reconnect automatically using a fancy strategy.
  (erc-server-reconnect-function #'erc-server-delayed-check-reconnect)
  (erc-server-reconnect-timeout 30)

  ;; Show new buffers in the current window instead of a split.
  (erc-interactive-display 'buffer)

  ;; Insert a newline when I hit <RET> at the prompt, and prefer
  ;; something more deliberate for actually sending messages.
  :bind (:map erc-mode-map
              ("RET" . nil)
              ("C-c C-c" . #'erc-send-current-line))

  ;; Emphasize buttonized text in notices.
  :custom-face (erc-notice-face ((t (:slant italic :weight unspecified)))))

(use-package erc-sasl
  ;; Since my account name is the same as my nick, free me from having
  ;; to hit C-u before M-x erc to trigger a username prompt.
  :custom (erc-sasl-user :nick))

(use-package erc-join
  ;; Join #emacs and #erc whenever I connect to Libera.Chat.
  ;; Add more to this list
  :custom
  (erc-autojoin-channels-alist '((Libera.Chat "#emacs" "#erc")))
  (erc-autojoin-delay 0))

(use-package erc-fill
  :custom
  ;; Prefer one message per line without continuation indicators.
  (erc-fill-function #'erc-fill-wrap)
  (erc-fill-static-center 18)

  :bind (:map erc-fill-wrap-mode-map ("C-c =" . #'erc-fill-wrap-nudge)))

(use-package erc-track
  ;; Prevent JOINs and PARTs from lighting up the mode-line.
  :config (setopt erc-track-faces-priority-list
                  (remq 'erc-notice-face erc-track-faces-priority-list))

  :custom (erc-track-priority-faces-only 'all))

(use-package erc-goodies
  ;; Turn on read indicators when joining channels.
  ;; Do I really need this?
  :hook (erc-join . my-erc-enable-keep-place-indicator-on-join))

(defvar my-erc-read-indicator-channels '("#emacs")
  "Channels in which to show a `keep-place-indicator'.")

(defun my-erc-enable-keep-place-indicator-on-join ()
  "Enable read indicators for certain queries or channels."
  (when (member (erc-default-target) my-erc-read-indicator-channels)
    (erc-keep-place-indicator-mode +1)))

;; Handy commands from the Emacs Wiki.
(defun erc-cmd-TRACK (&optional target)
  "Start tracking TARGET or that of current buffer."
  (setq erc-track-exclude
        (delete (or target (erc-default-target) (current-buffer))
                erc-track-exclude)))

(defun erc-cmd-UNTRACK (&optional target)
  "Stop tracking TARGET or that of current buffer."
  (setq erc-track-exclude
        (cl-pushnew (or target (erc-default-target) (current-buffer))
                    erc-track-exclude
                    :test #'equal)))

(provide 'config-erc)
