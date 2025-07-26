;;; huegli-org.el --- Org Mode related features -*- coding: utf-8; lexical-binding: t -*-

;;; Commentary:

;;; Code:

(use-package org
  :ensure nil
  :custom
  (org-startup-folded t) ; start up folded for speed
  (org-hide-emphasis-markers t) ; don't show markers for bold, underline etc.
  ;; (org-pretty-entities t) ; use UTF8 characters
  :config
  (add-hook 'org-mode-hook #'imenu-add-menubar-index))

(use-package org-mac-link
  :ensure t
  :bind
  (:map org-mode-map
        ("C-c l l g m" . org-mac-link-mail-insert-selected)))

(provide 'huegli-org)
;;; huegli-org.el ends here
