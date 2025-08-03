;;; huegli-history.el --- History configuration  -*- coding: utf-8; lexical-binding: t -*-

;;; Commentary:

;;; Code:

(use-package desktop
  :ensure nil
  :demand t
  :custom
  ;; (desktop-restore-frames nil)
  (desktop-restore-eager 10)
  :config
  (desktop-save-mode t))

(use-package savehist
  :ensure nil ; it is built-in
  :hook (after-init . savehist-mode))

(provide 'huegli-history)
;;; huegli-history.el ends here
