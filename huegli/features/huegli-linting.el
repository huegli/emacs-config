;;; huegli-linting.el --- Linting related features -*- coding: utf-8; lexical-binding: t -*-

;;; Commentary:

;;; Code:

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

(provide 'huegli-linting)
;;; huegli-linting.el ends here
