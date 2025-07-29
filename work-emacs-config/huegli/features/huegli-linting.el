;;; huegli-linting.el --- Linting related features -*- coding: utf-8; lexical-binding: t -*-

;;; Commentary:

;;; Code:

(use-package flymake
  :ensure nil
  :defer t
  :bind
  (("C-c t f" . flymake-mode)
   :map flymake-mode-map
        ("M-p" . flymake-goto-prev-error)
        ("M-n" . flymake-goto-next-error)
        ("C-c ! n" . flymake-goto-next-error)
        ("C-c ! p" . flymake-goto-prev-error)
        ("C-c ! l" . flymake-show-buffer-diagnostics)
        ("C-c ! P" . flymake-show-project-diagnostics))
  :custom
  (flymake-start-on-flymake-mode t)
  (flymake-start-on-save-buffer t)
  (flymake-show-diagnostics-at-end-of-line t))

(provide 'huegli-linting)
;;; huegli-linting.el ends here
