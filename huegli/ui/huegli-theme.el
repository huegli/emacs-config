;;; huegli-theme.el --- Setting up the Theme & Fonts -*- coding: utf-8; lexical-binding: t -*-

;;; Commentary:

;;; Code:

;;; https://github.com/d12frosted/homebrew-emacs-plus?tab=readme-ov-file#system-appearance-change
(defun my/apply-theme (appearance)
  "Load theme, taking current system APPEARANCE into consideration."
  (mapc #'disable-theme custom-enabled-themes)
  (pcase appearance
    ('light (progn
              (load-theme 'dracula-pro-alucard t)
              (custom-set-faces '(match ((t (:background "dark gray" :foreground "white smoke")))))))
    ('dark (progn
             (load-theme 'dracula-pro-pro t)
             (custom-set-faces '(match ((t (:background "dark slate blue" :foreground "white smoke")))))))))

(add-hook 'ns-system-appearance-change-functions #'my/apply-theme)

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
   :lightens '(0)))

(use-package ultra-scroll
  :demand t
  :commands (ultra-scroll-mode)
  :custom
  (scroll-conservatively 3)
  (scroll-margin 0)
  :config
  (ultra-scroll-mode 1))

(use-package kanata-kbd-mode
  :load-path "~/.config/emacs/packages/kanata-kbd-mode"
  :mode ("\\.kbd\\'" . kanata-kbd-mode))

;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:

(provide 'huegli-theme)
;;; huegli-theme.el ends here
