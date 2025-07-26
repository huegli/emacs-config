;;; huegli-programing.el --- Programing Modes  -*- coding: utf-8; lexical-binding: t -*-

;;; Commentary:

;;; Code:

(use-package elisp-mode
  :ensure nil
  :config
  (add-hook 'emacs-lisp-mode-hook #'imenu-add-menubar-index))

(provide 'huegli-programing)
;;; huegli-programing.el ends here
