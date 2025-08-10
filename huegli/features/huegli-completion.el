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
                       (icomplete-mode 1)))
  :custom
  (icomplete-hide-common-prefix t)
  (icomplete-prospects-height 8)
  (icomplete-separator " . ")
  (icomplete-in-buffer t)
  :config
  (if icomplete-in-buffer
      (advice-add 'completion-at-point
                  :after #'minibuffer-hide-completions)))

;; See https://eshelyaron.com/posts/2023-11-17-completion-preview-in-emacs.html
(use-package completion-preview
  :ensure nil
  :hook
  (prog-mode text-mode))

(use-package minibuffer
  :ensure nil
  :custom
  (completion-ignore-case t)
  (completions-detailed t)
  (completion-cycle-threshold 2)
  (completion-styles '(basic partial-completion flex initials))
  (completion-auto-help 'always)
  (completion-auto-select 'second-tab)
  (completion-show-help nil)
  (completions-max-height 20)
  (completions-header-format nil)
  (completions-format 'one-column)
  (enable-recursive-minibuffers t)
  (read-file-name-completion-ignore-case t)
  (read-buffer-completion-ignore-case t))

(provide 'huegli-completion)
;;; huegli-completion.el ends here
