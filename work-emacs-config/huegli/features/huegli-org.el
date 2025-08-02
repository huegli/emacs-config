;;; huegli-org.el --- Org Mode related features -*- coding: utf-8; lexical-binding: t -*-

;;; Commentary:

;;; Code:

(use-package org
  :ensure nil
  :commands org-link-set-parameters
  :custom
  ;; (org-startup-folded t) ; start up folded for speed
  ;; (org-hide-emphasis-markers t) ; don't show markers for bold, underline etc.
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
  (org-attach-id-dir "~/Library/Mobile Documents/com~apple~icloud~applecorporate/Documents/org-attachments/")
  (org-attach-store-link-p 'attached)
  (org-attach-method 'mv)
  (org-attach-use-inheritance t) ;; FIXME - Should this be 'selective instead?
  (org-attach-id-to-path-function-list '(org-attach-id-ts-folder-format org-attach-id-uuid-folder-format)))

(use-package denote
  :bind
  (("C-c d n" . denote-open-or-create)
   ("C-c d d" . denote-sort-dired)
   ("C-c d r" . denote-rename-file))
  :commands
  (denote-rename-buffer-mode)
  :custom
  ((denote-directory "~/Library/Mobile Documents/com~apple~icloud~applecorporate/Documents/Denote")
   (denote-file-type 'org)
   (denote-known-keywords '("management" "oneonone" "subra" "seb" "jose" "alex" "prashanth" "nguyen" "franz" "najib" "subhasis" "subra" "navid" "daniel"))
   (denote-date-prompt-use-org-read-date t)
   (denote-dired-directories '("~/Library/Mobile Documents/com~apple~icloud~applecorporate/Documents/Denote" "~/Desktop" "~/Downloads"))
   (denote-dired-directories-include-subdirectories t))
  :config
  (denote-rename-buffer-mode))

(use-package denote-org
  :after org
  :bind
  (:map org-mode-map
        ("C-c l d l" . denote-org-link-to-heading)))

(use-package denote-journal
  :bind
  (("C-c d j" . denote-journal-new-or-existing-entry)
   ("C-c d J" . denote-journal-link-or-create-entry))
  :hook (calendar-mode . denote-journal-calendar-mode)
  :custom
  (denote-journal-directory
   (expand-file-name "journal" denote-directory))
  (denote-journal-keyword "journal")
  (denote-journal-title-format 'day-date-month-year))

(use-package org-mem
  :commands org-mem-updater-mode
  :config
  (setq org-mem-watch-dirs
        (list
         "~/Library/Mobile Documents/com~apple~icloud~applecorporate/Documents/Org/journal"
         "~/Library/Mobile Documents/com~apple~icloud~applecorporate/Documents/Org/nodes"))
  (org-mem-updater-mode))

(use-package org-node
  :init
  (with-eval-after-load 'org
    (keymap-set org-mode-map "C-c l n" org-node-org-prefix-map))
  (defvar org-node-seq-defs)
  :commands (org-node-cache-mode
             org-node-seq-mode
             org-node-seq-def-on-filepath-sort-by-basename)
  :bind-keymap
  ("C-c n" . org-node-global-prefix-map)
  :config
  (org-node-cache-mode)
  (setq org-node-seq-defs
        (list
         ;; All notes in creation order,
         ;; according to the timestamps in their :CREATED: property.
         ;; (org-node-seq-def-on-any-sort-by-property
         ;;  "a" "All notes by property :CREATED:" "CREATED")

         ;; My day-notes, a.k.a. journal/diary.  Currently I still
         ;; structure them like org-roam-dailies expects: confined to a
         ;; subdirectory, with filenames such as "2024-11-18.org".
         ;; This is actually a sequence of files, not sequence of ID-nodes.
         (org-node-seq-def-on-filepath-sort-by-basename
          "d" "Journal" "~/Library/Mobile Documents/com~apple~icloud~applecorporate/Documents/Org/journal/" nil t)))
  (org-node-seq-mode))

(use-package org-mac-link
:after org
:commands org-mac-link-mail-open
:init
(org-link-set-parameters "message"
                         :follow #'org-mac-link-mail-open)
:bind
(:map org-mode-map
      ("C-c l l g m" . org-mac-link-mail-insert-selected)))

(provide 'huegli-org)
;;; huegli-org.el ends here
