;;; huegli-completion.el --- Completion features  -*- coding: utf-8; lexical-binding: t -*-

;;; Commentary:

;;; Code:

(use-package icomplete
  :ensure nil
  :custom
  (icomplete-vertical-mode t))

(use-package orderless
  :custom
  (completion-styles '(orderless basic))
  (completion-category-defaults nil)
  (completion-category-overrides '((file (styles basic partial-completion)))))

(provide 'huegli-completion)
;;; huegli-completion.el ends here
