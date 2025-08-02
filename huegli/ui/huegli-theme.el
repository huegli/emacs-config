;;; huegli-theme.el --- Setting up the Theme & Fonts -*- coding: utf-8; lexical-binding: t -*-

;;; Commentary:

;;; Code:

(use-package modus-themes
  :ensure nil
  :commands (modus-themes-with-colors)
  :bind
  ("C-c t t" . modus-themes-toggle)
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
  :ensure t
  :defer t
  :commands (prism-set-colors prism-blend)
  :bind
  (("C-c t p" . prism-mode))
  :custom
  (prism-parens t)
  (prism-num-faces 4)
  :config
  (prism-set-colors
   :parens-fn (lambda (color)
                (prism-blend color (face-attribute 'default :background nil 'default) 0.25))
   :desaturations '(0) ; do not change---may lower the contrast ratio
   :lightens '(0)      ; same
   :colors (modus-themes-with-colors
             (list blue
                   magenta
                   magenta-cooler
                   green-warmer))))

(use-package kanata-kbd-mode
  :load-path "~/.config/emacs/packages/kanata-kbd-mode"
  :mode ("\\.kbd\\'" . kanata-kbd-mode))

;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:

(provide 'huegli-theme)
;;; huegli-theme.el ends here
