;;; init.el --- Emacs Configuration for my Work Macbook Pro  --- Init  -*- lexical-binding: t; -*-
;;
;; Author: Nikolai Schlegel
;;

;;; Commentary:
;;  Init configuration for Emacs
;;

;;; Code:

(setq custom-file (locate-user-emacs-file "custom.el"))
(load custom-file :no-error-if-file-is-missing)

;;; Set up the package manager

(require 'package)
(package-initialize)

(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))

(add-to-list 'display-buffer-alist
             '("\\`\\*\\(Warnings\\|Compile-Log\\)\\*\\'"
               (display-buffer-no-window)
               (allow-no-window . t)))

;;; Mac OSX Stuff
(when (eq system-type 'darwin)
  
  ;; Prevent macOS from creating new frames
  (setq ns-pop-up-frames nil)
  
  ;; Improve font rendering
  (setq ns-use-thin-smoothing t)

  ;; use GNU ls
  (setq insert-directory-program "gls"))

;;; Basic behaviour

(use-package emacs
  :ensure nil
  :bind
  (("C-g" . #'prot/keyboard-quit-dwim)
   ("M-i" . imenu)
   ("M-o" . other-window)
   ("M-g r" . recentf-open-files)
   ("C-x C-b" . ibuffer))
  :config
  (setq-default indent-tabs-mode nil)
  :custom
  ;; Smooth scrolling
  (pixel-scroll-precision-mode 1)
  (pixel-scroll-precision-use-momentum t)
  ;; UI enhancements
  (inhibit-startup-messate t)
  (initial-scratch-message "")
  (column-number-mode nil)
  (line-number-mode nil)
  (help-window-select t)
  (read-answer-short t)
  (use-short-answers t)
  (use-dialog-box nil)
  (truncate-lines t)
  (kill-do-not-save-duplicates t) ; avoid multiple entries in the kill ring that are the same
  (display-line-numbers-width 3) ; mininum width for line numbers
  (display-line-numbers-widen t) ; don't change line numbers for narrowing
  ;; basic completion settings
  (completion-ignore-case t)
  (completions-detailed t)
  (completion-cycle-threshold 5)
  ;; no sound or visual bell
  (ring-bell-function 'ignore)
  (visible-bell nil)
  ;; no backup files
  (create-lockfiles nil)
  (make-backup-files nil)
  (backup-inhibited t)
  ;; dired related
  (find-ls-option '("-exec ls -ldh {} +" . "-ldh"))
  (global-auto-revert-non-file-buffers t) ; automatically updates dired buffers
  (auto-revert-verbose nil) ; no message on auto-revert
  ;; recentf configuration
  (recentf-max-saved-items 300)
  (recentf-max-menu-items 15)
  (recentf-auto-cleanup 300) ;; (if (daemonp) 300 'never))
  (recentf-exclude (list "^/\\(?:ssh\\|su\\|sudo\\)?:"))
  ;; imenu configuration: https://www.gnu.org/software/emacs/manual/html_node/emacs/Imenu.html
  (imenu-flatten 'group)
  (imenu-auto-rescan t)
  (imenu-auto-rescan-maxout (* 1024 1024))
  (imenu-max-index-time 2)
  :config
  (defun prot/keyboard-quit-dwim ()
    "Do-What-I-Mean behaviour for a general `keyboard-quit'.

The generic `keyboard-quit' does not do the expected thing when
the minibuffer is open.  Whereas we want it to close the
minibuffer, even without explicitly focusing it.

The DWIM behaviour of this command is as follows:

- When the region is active, disable it.
- When a minibuffer is open, but not focused, close the minibuffer.
- When the Completions buffer is selected, close it.
- In every other case use the regular `keyboard-quit'."
    (interactive)
    (cond
     ((region-active-p)
      (keyboard-quit))
     ((derived-mode-p 'completion-list-mode)
      (delete-completion-window))
     ((> (minibuffer-depth) 0)
      (abort-recursive-edit))
     (t
      (keyboard-quit))))

  (setq display-line-numbers-type 'relative)
  (add-hook 'prog-mode-hook #'display-line-numbers-mode)
  :init
  ;; UI inits
  ;; FIXME (set-window-margins (selected-window) 2 2)
  (tooltip-mode nil)
  (select-frame-set-input-focus (selected-frame))
  ;; Better default modes
  (electric-pair-mode t)
  (show-paren-mode 1)
  (save-place-mode t)
  (savehist-mode t)
  (recentf-mode t)
  (global-auto-revert-mode t)
  (winner-mode t)
  ;; open list of recent files on startup
  (recentf-open-files))
  


(use-package elisp-mode
  :ensure nil
  :config
  (add-hook 'emacs-lisp-mode-hook #'imenu-add-menubar-index))

(use-package delsel
  :ensure nil
  :hook (after-init . delete-selection-mode))

(use-package nerd-icons
  :ensure t)

(use-package nerd-icons-dired
  :ensure t
  :hook
  (dired-mode . nerd-icons-dired-mode))

(use-package savehist
  :ensure nil ; it is built-in
  :hook (after-init . savehist-mode))

(use-package casual
  :ensure t
  :bind
  (("C-o" . #'casual-editkit-main-tmenu)))


(use-package help
  :ensure nil
  :after casual
  :bind
  (:map help-mode-map
        ("C-o" . #'casual-help-tmenu)))

(use-package ibuffer
  :ensure nil
  :after casual
  :bind
  (:map ibuffer-mode-map
        ("C-o" . #'casual-ibuffer-tmenu)))

(use-package dired
  :ensure nil
  :after casual
  :commands (dired)
  :bind
  (:map dired-mode-map
        ("C-o" . #'casual-dired-tmenu))
  :hook
  ((dired-mode . dired-hide-details-mode)
   (dired-mode . hl-line-mode))
  :config
  (setq dired-recursive-copies 'always)
  (setq dired-recursive-deletes 'always)
  (setq delete-by-moving-to-trash t)
  (setq dired-dwim-target t))

(use-package dired-subtree
  :ensure t
  :after dired
  :bind
  ( :map dired-mode-map
    ("<tab>" . dired-subtree-toggle)
    ("TAB" . dired-subtree-toggle)
    ("<backtab>" . dired-subtree-remove)
    ("S-TAB" . dired-subtree-remove))
  :config
  (setq dired-subtree-use-backgrounds nil))

(use-package which-key
  :ensure nil
  :config
  (which-key-mode))

(use-package org
  :ensure nil
  :custom
  (org-startup-folded t) ; start up folded for speed
  (org-hide-emphasis-markers t) ; don't show markers for bold, underline etc.
  ;; (org-pretty-entities t) ; use UTF8 characters
  :config
  (add-hook 'org-mode-hook #'imenu-add-menubar-index))

(use-package denote
  :ensure t
  :bind
  (("C-c d n" . denote-open-or-create)
   ("C-c d d" . denote-sort-dired)
   ("C-c d r" . denote-rename-file))
  :custom
  ((denote-directory "~/Library/Mobile Documents/com~apple~icloud~applecorporate/Documents/Denote")
   (denote-file-type 'org)
   (denote-known-keywords '("management" "oneonone" "subra" "seb" "jose" "alex" "prashanth" "nguyen" "franz" "najib" "subhasis" "subra" "navid" "daniel"))
   (denote-date-prompt-use-org-read-date t)
   (denote-dired-directories '("~/Library/Mobile Documents/com~apple~icloud~applecorporate/Documents/Denote" "~/Desktop" "~/Downloads"))
   (denote-dired-directories-include-subdirectories t))
  :config
  (denote-rename-buffer-mode 1))

(use-package denote-org
  :ensure t
  :bind
  (:map org-mode-map
        ("C-c l d l" . denote-org-link-to-heading)))

(use-package denote-journal
  :ensure t
  ;; Bind those to some key for your convenience.
  :bind
  (("C-c d j" . denote-journal-new-or-existing-entry)
   ("C-c d J" . denote-journal-link-or-create-entry))
  :hook (calendar-mode . denote-journal-calendar-mode)
  :config
  ;; Use the "journal" subdirectory of the `denote-directory'.  Set this
  ;; to nil to use the `denote-directory' instead.
  (setq denote-journal-directory
        (expand-file-name "journal" denote-directory))
  ;; Default keyword for new journal entries. It can also be a list of
  ;; strings.
  (setq denote-journal-keyword "journal")
  ;; Read the doc string of `denote-journal-title-format'.
  (setq denote-journal-title-format 'day-date-month-year))

(use-package org-mac-link
  :ensure t
  :bind
  (:map org-mode-map
        ("C-c l l g m" . org-mac-link-mail-insert-selected)))

(provide 'init)
;;; init.el ends here

