;;; huegli-completion.el --- Completion features  -*- coding: utf-8; lexical-binding: t -*-

;;; Commentary:

;;; Code:

(use-package icomplete
  :ensure nil
  :bind (:map icomplete-minibuffer-map
              ("C-n" . icomplete-forward-completions)
              ("C-p" . icomplete-backward-completions)
              ("C-v" . icomplete-vertical-mode) ;; toggle vertical
              ("RET" . icomplete-force-complete-and-exit)
              ("C-j" . exit-minibuffer)) ;; So we can exit commands like `multi-file-replace-regexp-as-diff'
  :hook
  (after-init-hook . (lambda ()
                       (fido-mode -1)
                       (icomplete-vertical-mode 1)))
  :config
  (setq icomplete-delay-completions-threshold 0)
  (setq icomplete-compute-delay 0)
  (setq icomplete-show-matches-on-no-input t)
  (setq icomplete-hide-common-prefix nil)
  (setq icomplete-prospects-height 10)
  (setq icomplete-separator " . ")
  (setq icomplete-with-completion-tables t)
  (setq icomplete-in-buffer t)
  (setq icomplete-max-delay-chars 0)
  (setq icomplete-scroll t)

  (if icomplete-in-buffer
      (advice-add 'completion-at-point
                  :after #'minibuffer-hide-completions)))


(use-package orderless
  :custom
  (completion-styles '(orderless basic))
  (completion-category-defaults nil)
  (completion-category-overrides '((file (styles basic partial-completion)))))

(provide 'huegli-completion)
;;; huegli-completion.el ends here
