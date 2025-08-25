;;; huegli-terminal.el --- Terminal configurations -*- coding: utf-8; lexical-binding: t -*-

;;; Commentary:

;;; Code:

(use-package eat
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
  :custom
  (vterm-shell "/opt/homebrew/bin/fish")
  (vterm-kill-buffer-on-exit t)
  (vterm-tramp-shells '(("ssh" "/usr/bin/tcsh"))) ; For Apple CE VM's
  (vterm-always-compile-module t))

(provide 'huegli-terminal)
;;; huegli-terminal.el ends here
