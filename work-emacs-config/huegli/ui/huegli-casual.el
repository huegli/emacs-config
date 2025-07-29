;;; huegli-casua.el --- Casual Transient menu configuration -*- coding: utf-8; lexical-binding: t -*-

;;; Commentary:

;;; Code:

(use-package casual
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
  :bind
  (:map dired-mode-map
        ("C-o" . #'casual-dired-tmenu)))

(provide 'huegli-casual)
;;; huegli-casual.el ends here
