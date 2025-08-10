;;; huegli-emacs.el --- Customization preferences configuration -*- coding: utf-8; lexical-binding: t -*-

;;; Commentary:

;;; Code:

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
  :demand t
  :bind
  (("C-g" . #'prot/keyboard-quit-dwim)
   ("M-i" . imenu)
   ("M-o" . other-window)
   ("M-g r" . recentf-open-files)
   ("C-x C-b" . ibuffer))
  :hook
  ((text-mode-hook org-mode-hook) . visual-line-mode)
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
  (repeat-mode t)
  (recentf-mode t)
  (global-auto-revert-mode t)
  (winner-mode t))

(provide 'huegli-emacs)
;;; huegli-emacs.el ends here
