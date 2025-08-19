;;; huegli-programing.el --- Programing Modes  -*- coding: utf-8; lexical-binding: t -*-

;;; Commentary:

;;; Code:

(use-package elisp-mode
  :ensure nil
  :config
  (add-hook 'emacs-lisp-mode-hook #'imenu-add-menubar-index))

(use-package slime
  :commands (slime-setup)
  :custom
  (inferior-lisp-program "/opt/homebrew/bin/sbcl")
  :config
  (slime-setup '(slime-fancy slime-quicklisp slime-asdf slime-mrepl)))

(provide 'huegli-programing)
;;; huegli-programing.el ends here
