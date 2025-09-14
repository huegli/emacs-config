;;; huegli-programing.el --- Programing Modes  -*- coding: utf-8; lexical-binding: t -*-

;;; Commentary:

;;; Code:

(use-package elisp-mode
  :ensure nil
  :hook (emacs-lisp-mode . imenu-add-menubar-index))

(use-package slime
  :commands (slime-setup)
  :custom
  (inferior-lisp-program "/opt/homebrew/bin/sbcl")
  :config
  (slime-setup '(slime-fancy slime-quicklisp slime-asdf slime-mrepl)))

(use-package python-mode
  :ensure nil
  :hook (python-mode . imenu-add-menubar-index))

(use-package uv-mode
  :hook (python-mode . uv-mode-auto-activate-hook))

(use-package eglot
  :ensure nil)

(use-package swift-mode
  :after eglot
  :config
  (add-to-list 'eglot-server-programs '(swift-mode "sourcekit-lsp")))

(provide 'huegli-programing)
;;; huegli-programing.el ends here
