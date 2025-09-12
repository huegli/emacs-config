;;; huegli-looknfeel.el --- Other Look & Feel UI configuration -*- coding: utf-8; lexical-binding: t -*-

;;; Commentary:

;;; Code:

(use-package delsel
  :ensure nil
  :hook (after-init . delete-selection-mode))

(use-package nerd-icons)

(use-package nerd-icons-dired
  :hook
  (dired-mode . nerd-icons-dired-mode))

(use-package which-key
  :ensure nil
  :demand t
  :config
  (which-key-mode))

(use-package aggressive-indent
  :hook
  emacs-lisp-mode)

(use-package hl-line-mode
  :ensure nil
  :hook
  (Info-mode ibuffer-mode prog-mode))

(use-package ibuffer
  :ensure nil
  :commands
  (ibuffer-switch-to-saved-filter-groups)
  :hook
  (ibuffer-mode . ibuffer-auto-mode)
  (ibuffer-mode . (lambda ()
                    (ibuffer-switch-to-saved-filter-groups "default")))
  :custom
  ((ibuffer-show-empty-filter-groups nil)
   (ibuffer-saved-filter-groups
    '(("default"
       ("org"     (or
                   (mode . org-mode)
                   (name . "^\\*Org Src")
                   (name . "^\\*Org Agenda\\*$")))
       ("tramp"   (name . "^\\*tramp.*"))
       ("emacs"   (or
                   (name . "^\\*scratch\\*$")
                   (name . "^\\*Messages\\*$")
                   (name . "^\\*Warnings\\*$")
                   (name . "^\\*Shell Command Output\\*$")
                   (name . "^\\*Async-native-compile-log\\*$")
                   (mode . emacs-lisp-mode)))
       ("ediff"   (name . "^\\*[Ee]diff.*"))
       ("vc"      (name . "^\\*vc-.*"))
       ("dired"   (mode . dired-mode))
       ("terminal" (or
                    (mode . term-mode)
                    (mode . shell-mode)
                    (mode . eshell-mode)))
       ("help"    (or
                   (name . "^\\*Help\\*$")
                   (name . "^\\*info\\*$"))))))))

;; From https://www.youtube.com/watch?v=5AzSahLmDQk
(use-package repeat
  :ensure nil
  :hook
  (after-init . repeat-mode)
  :custom
  (repeat-too-dangerous '(kill-this-buffer))
  (repeat-exit-timeout 5))

(use-package ultra-scroll
  :vc (:url "https://github.com/jdtsmith/ultra-scroll") ; if desired (emacs>=v30)
  :commands (ultra-scroll-mode)
  :init
  (setq scroll-conservatively 3 ; or whatever value you prefer, since v0.4
        scroll-margin 0)        ; important: scroll-margin>0 not yet supported
  :config
  (ultra-scroll-mode 1))

(provide 'huegli-looknfeel)
;;; huegli-looknfeel.el ends here
