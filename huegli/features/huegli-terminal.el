;;; huegli-terminal.el --- Terminal configurations -*- coding: utf-8; lexical-binding: t -*-

;;; Commentary:

;;; Code:

(use-package vterm
  :custom
  (vterm-shell "/opt/homebrew/bin/fish")
  (vterm-kill-buffer-on-exit t)
  (vterm-tramp-shells '(("ssh" "/opt/homebrew/bin/fish"))) ; For MacMini
  (vterm-always-compile-module t))

(use-package mistty
  :custom
  (mistty-shell-command . ("/opt/homebrew/bin/fish"  "-i"))
  :bind (("C-c s" . mistty)

         ;; bind here the shortcuts you'd like the
         ;; shell to handle instead of Emacs.
         :map mistty-prompt-map

         ;; fish: directory history
         ("M-<up>" . mistty-send-key)
         ("M-<down>" . mistty-send-key)
         ("M-<left>" . mistty-send-key)
         ("M-<right>" . mistty-send-key)))

(provide 'huegli-terminal)
;;; huegli-terminal.el ends here
