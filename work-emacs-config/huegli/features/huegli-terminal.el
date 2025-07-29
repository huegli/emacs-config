;;; huegli-terminal.el --- Terminal configurations -*- coding: utf-8; lexical-binding: t -*-

;;; Commentary:

;;; Code:

(use-package eat
  :ensure t
  :defer t
  :bind
  (:map eat-mode-map
        ("C-c C-e" . eat-emacs-mode)
        ("C-c M-d" . eat-char-mode)
        ("C-c C-j" . eat-semi-char-mode))
  :custom
  (eat-buffer-name "*eat*")
  (eat-kill-buffer-on-exit t)
  (eat-enable-mouse t))

(use-package vterm
  :ensure t
  :defer t)

(provide 'huegli-terminal)
;;; huegli-terminal.el ends here
