;;; huegli-programing.el --- Programing Modes  -*- coding: utf-8; lexical-binding: t -*-

;;; Commentary:

;;; Code:

(use-package treesit
  :ensure nil
  :demand t
  :config
  (add-to-list 'major-mode-remap-alist '(c-mode . c-ts-mode))
  (add-to-list 'major-mode-remap-alist '(c++-mode . c++-ts-mode))
  (add-to-list 'major-mode-remap-alist
               '(c-or-c++-mode . c-or-c++-ts-mode)))

(use-package elisp-mode
  :ensure nil
  :hook (emacs-lisp-mode . imenu-add-menubar-index))

(use-package sly
  :init
  (setq inferior-lisp-program "/opt/homebrew/bin/sbcl"))

(use-package geiser)
(use-package geiser-racket)

(use-package python-mode
  :ensure nil
  :hook (python-mode . imenu-add-menubar-index))

(use-package uv-mode
  :hook (python-mode . uv-mode-auto-activate-hook))

(use-package swift-mode
  :mode "\\.swift\\'"
  :hook (swift-mode . eglot-ensure)
  :interpreter "swift")

(use-package c-ts-mode
  :ensure nil
  :hook (c-ts-mode . eglot-ensure))

(use-package eglot
  :ensure nil
  :hook
  (c-mode . eglot-ensure)
  (c-ts-mode . eglot-ensure)
  :config
  (add-to-list 'eglot-server-programs '(swift-mode "sourcekit-lsp")))

(provide 'huegli-programing)
;;; huegli-programing.el ends here
