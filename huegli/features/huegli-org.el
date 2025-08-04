;;; huegli-org.el --- Org Mode related features -*- coding: utf-8; lexical-binding: t -*-

;;; Commentary:

;;; Code:

(use-package org
  :ensure nil
  :commands org-link-set-parameters
  :custom
  (org-directory "~/Library/CloudStorage/Dropbox/Documents/Org")
  (org-startup-folded t) ; start up folded for speed
  (org-hide-emphasis-markers t) ; don't show markers for bold, underline etc.
  ;; (org-pretty-entities t) ; use UTF8 characters
  (org-startup-with-inline-images t)
  (org-id-method 'ts)
  :config
  (add-to-list 'org-file-apps '("\\.xlsx\\'" . system))
  (add-hook 'org-mode-hook #'imenu-add-menubar-index))

(use-package org-attach
  :ensure nil
  :after org
  :commands
  (org-attach-follow org-attach-complete-link)
  :init
  (org-link-set-parameters "attachment"
                           :follow #'org-attach-follow
                           :complete #'org-attach-complete-link)
  :custom
  ;;; https://medium.com/@James86768479/org-id-org-attach-better-folder-names-3905f3841044
  (org-attach-id-dir "~/Library/CloudStorage/Dropbox/Documents/Org/attachments")
  (org-attach-store-link-p 'attached)
  (org-attach-method 'mv)
  (org-attach-use-inheritance t) ;; FIXME - Should this be 'selective instead?
  (org-attach-id-to-path-function-list '(org-attach-id-ts-folder-format org-attach-id-uuid-folder-format)))

(use-package org-mac-link
  :after org
  :commands org-mac-link-mail-open
  :init
  (org-link-set-parameters "message"
                           :follow #'org-mac-link-mail-open)
  :bind
  (:map org-mode-map
        ("C-c l l g m" . org-mac-link-mail-insert-selected)))

(use-package denote
  :hook (dired-mode . denote-dired-mode)
  :init
  :commands
  (denote-rename-buffer-mode
   denote-dired-rename-files
   denote-dired-mode-in-directories)
  :bind
  ( :map global-map
    ("C-c d n" . denote-open-or-create)
    ("C-c d d" . denote-sort-dired)
    ("C-c d r" . denote-rename-file)
    )
  :custom
  ((denote-directory "~/Library/CloudStorage/Dropbox/Documents/Org/denote")
   (denote-file-type 'org)
   (denote-known-keywords '("emacs" "macosx" "stephanie" "mikhaila" "sandiego" "financials" "programing"))
   (denote-date-prompt-use-org-read-date t)
   (denote-dired-directories-include-subdirectories t)
   (denote-dired-directories
    '("~/Library/CloudStorage/Dropbox/Documents/Org/denote"
      "~/Library/CloudStorage/Dropbox/ScanSnap/Documents"
      "~/Desktop"
      "~/Downloads")))
  :config
  (denote-rename-buffer-mode 1))

;; Denote specific Dired configuration
(use-package dired
  :ensure nil
  :bind (
         :map dired-mode-map
         ("C-c C-d C-r" . #'denote-dired-rename-files)
         )
  :config
  (add-hook 'dired-mode-hook #'denote-dired-mode-in-directories))

(provide 'huegli-org)
;;; huegli-org.el ends here
