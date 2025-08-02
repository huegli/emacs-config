;;; huegli-casua.el --- Casual Transient menu configuration -*- coding: utf-8; lexical-binding: t -*-

;;; Commentary:

;;; Code:

(use-package casual
;;  :demand t
  :commands
  (casual-editkit-main-tmenu
   casual-help-tmenu
   casual-ibuffer-tmenu
   casual-info-tmenu
   casual-dired-tmenu
   casual-info-browse-backward-paragraph
   casual-info-browse-forward-paragraph
   casual-lib-browse-backward-paragraph
   casual-lib-browse-forward-paragraph)
  :bind
  (("C-o" . #'casual-editkit-main-tmenu)))

(use-package help
  :ensure nil
  :bind
  (:map help-mode-map
        ("C-o" . #'casual-help-tmenu)
        ("M-[" . #'help-go-back)
        ("M-]" . #'help-go-forward)
        ("p" . #'casual-lib-browse-backward-paragraph)
        ("n" . #'casual-lib-browse-forward-paragraph)
        ("P" . #'help-goto-previous-page)
        ("N" . #'help-goto-next-page)
        ("j" . #'forward-button)
        ("k" . #'backward-button)))

(use-package ibuffer
  :ensure nil
  :hook
  (ibuffer-mode . ibuffer-auto-mode)
  :bind
  (:map ibuffer-mode-map
        ("C-o" . #'casual-ibuffer-tmenu)
        ("F" . #'casual-ibuffer-filter-tmenu)
        ("S" . #'casual-ibuffer-sortby-tmenu)
        ("{" . #'ibuffer-backwards-next-marked)
        ("}" . #'ibuffer-forward-next-marked)
        ("[" . #'ibuffer-backward-filter-group)
        ("]" . #'ibuffer-forward-filter-group)
        ("$" . #'ibuffer-toggle-filter-group)))

(use-package dired
  :ensure nil
  :bind
  (:map dired-mode-map
        ("C-o" . #'casual-dired-tmenu)))



(use-package Info
  :ensure nil
  :commands (Info-history-back
             Info-history-forward
             Info-prev
             Info-next-reference
             Info-prev-reference
             Info-next
             Info-search)
  :init
  (add-hook 'Info-mode-hook #'scroll-lock-mode)
  :bind
  (:map Info-mode-map
        ("C-o" . #'casual-info-tmenu)
        ;; Use web-browser history navigation bindings
        ("M-[" . #'Info-history-back)
        ( "M-]" . #'Info-history-forward)
        ;; Bind p and n to paragraph navigation
        ("p" . #'casual-info-browse-backward-paragraph)
        ("n" . #'casual-info-browse-forward-paragraph)
        ;; Bind h and l to navigate to previous and next nodes
        ;; Bind j and k to navigate to next and previous references
        ("h" . #'Info-prev)
        ("j" . #'Info-next-reference)
        ("k" . #'Info-prev-reference)
        ("l" . #'Info-next)
        ;; Bind / to search
        ("/" . #'Info-search)
        ;; Set Bookmark
        ("B" . #'bookmark-set)))


(provide 'huegli-casual)
;;; huegli-casual.el ends here
