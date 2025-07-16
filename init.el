;;; init.el --- Emacs Configuration for my Home Macbook Pro  --- Init  -*- lexical-binding: t; -*-
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

;; helper function
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

(use-package emacs
  :ensure nil
  :bind
  (("C-g" . #'prot/keyboard-quit-dwim)
   ("M-i" . imenu)
   ("M-o" . other-window)
   ("M-g r" . recentf-open-files)
   ("C-x C-b" . ibuffer))
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
  (setq-default indent-tabs-mode nil)
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

(use-package display-line-numbers
  :ensure nil
  :custom
  (display-line-numbers-type 'relative)
  :config
  (add-hook 'prog-mode-hook #'display-line-numbers-mode))

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

;;; https://github.com/alphapapa/prism.el/tree/master?tab=readme-ov-file
(use-package prism
  :ensure t
  :vc (:url "https://github.com/alphapapa/prism.el.git"
            :rev :v0.3.5))

(use-package savehist
  :ensure nil ; it is built-in
  :hook (after-init . savehist-mode))

(use-package flymake
  :ensure nil
  :defer t
  :hook (prog-mode-hook . flymake-mode)
  :bind
  (:map flymake-mode-map
        ("M-p" . flymake-goto-prev-error)
        ("M-n" . flymake-goto-next-error)
        ("C-c ! n" . flymake-goto-next-error)
        ("C-c ! p" . flymake-goto-prev-error)
        ("C-c ! l" . flymake-show-buffer-diagnostics)))

(use-package casual
  :ensure t
  :commands
  (casual-editkit-main-tmenu
   casual-help-tmenu
   casual-ibuffer-tmenu
   casual-dired-tmenu)
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
    ("S-TAB" . dired-subtree-remove)))

(use-package eat
  :ensure t
  :defer t)

(use-package vterm
  :ensure t
  :defer t)

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

(use-package org-mac-link
  :ensure t
  :bind
  (:map org-mode-map
        ("C-c l l g m" . org-mac-link-mail-insert-selected)))

(use-package gptel
  :ensure t
  :defer t
  :commands
  gptel-make-openai
  gptel-make-anthropic
  gptel-make-perplexity
  :defines
  gptel-model
  gptel-backend
  :custom
  (gptel-default-mode 'org-mode)
  :config
  (setq gptel-model 'sonar
        gptel-backend (gptel-make-perplexity "Perplexity" :stream t))
  (gptel-make-anthropic "Claude" :stream t)
  (gptel-make-openai "OpenRouter"
    :host "openrouter.ai"
    :endpoint "/api/v1/chat/completions"
    :stream t
    :models '(openai/gpt-4.1-mini
              google/gemini-2.5-flash)))


(use-package claude-code
  :ensure t
  :defer t
  :commands
  (claude-code-mode)
  :vc (:url "https://github.com/stevemolitor/claude-code.el" :rev :newest)
  :config
  (claude-code-mode)
  :bind-keymap ("C-c c" . claude-code-command-map))

(provide 'init)
;;; init.el ends here
