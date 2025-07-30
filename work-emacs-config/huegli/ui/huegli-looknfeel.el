;;; huegli-looknfeel.el --- Other Look & Feel UI configuration -*- coding: utf-8; lexical-binding: t -*-

;;; Commentary:

;;; Code:

(use-package display-line-numbers
  :ensure nil
  :custom
  (display-line-numbers-type 'relative)
  :config
  (add-hook 'prog-mode-hook #'display-line-numbers-mode))

(use-package delsel
  :ensure nil
  :hook (after-init . delete-selection-mode))

(use-package nerd-icons
  :ensure t)

(use-package nerd-icons-dired
  :ensure t
  :hook
  (dired-mode . nerd-icons-dired-mode))

(use-package which-key
  :ensure nil
  :config
  (which-key-mode))

(provide 'huegli-looknfeel)
;;; huegli-looknfeel.el ends here
