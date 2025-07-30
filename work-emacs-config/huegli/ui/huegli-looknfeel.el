;;; huegli-looknfeel.el --- Other Look & Feel UI configuration -*- coding: utf-8; lexical-binding: t -*-

;;; Commentary:

;;; Code:

(use-package display-line-numbers
  :ensure nil
  :demand t
  :custom
  (display-line-numbers-type 'relative)
  :config
  (add-hook 'prog-mode-hook #'display-line-numbers-mode))

(use-package delsel
  :ensure nil
  :hook (after-init . delete-selection-mode))

(use-package nerd-icons)

(use-package nerd-icons-dired
  :hook
  (dired-mode . nerd-icons-dired-mode))

(use-package which-key
  :ensure nil
  :demand t
  :config
  (which-key-mode))

(use-package aggressive-indent
  :hook
  emacs-lisp-mode)

(provide 'huegli-looknfeel)
;;; huegli-looknfeel.el ends here
