;;; huegli-theme.el --- Setting up the Theme & Fonts -*- coding: utf-8; lexical-binding: t -*-

;;; Commentary:

;;; Code:

(use-package modus-themes
  :ensure t
  :custom
  ;; Enable bold & italic globally
  (modus-themes-italic-constructs t)
  (modus-themes-bold-constructs t)
  :config
  (load-theme 'modus-vivendi :no-confirm))

;; Set default font to MonoLisa
(set-face-attribute 'default nil
                    :family "MonoLisa"
                    :weight 'regular
                    :slant 'normal
                    :height 150) ;; adjust as preferred

;; Set font for italic faces with "Light Italic" slant
(set-face-attribute 'italic nil
                    :family "MonoLisa"
                    :weight 'light
                    :slant 'italic)

;; Set font for bold faces with "Bold Italic" slant
(set-face-attribute 'bold nil
                    :family "MonoLisa"
                    :weight 'bold
                    :slant 'italic)

;;; https://github.com/alphapapa/prism.el/tree/master?tab=readme-ov-file
(use-package prism
  :ensure t)

(provide 'huegli-theme)
;;; huegli-theme.el ends here
