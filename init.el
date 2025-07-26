;;; init.el --- Personal configuration file for my Home Macbook Pro -*- lexical-binding: t; -*-
;;
;; Author: Nikolai Schlegel
;;

;;; Commentary:
;;  Init configuration for Emacs
;;

;;; Code:

;;; custom ocnfiguration
(setq custom-file (locate-user-emacs-file "custom.el"))
(load custom-file :no-error-if-file-is-missing)

;;; Mac OSX Stuff
(when (eq system-type 'darwin)

  ;; Prevent macOS from creating new frames
  (setq ns-pop-up-frames nil)

  ;; Improve font rendering
  (setq ns-use-thin-smoothing t)

  ;; use GNU ls
  (setq insert-directory-program "gls"))

;;; Basic behaviour

;; Paths & packages

(add-to-list 'load-path "/Users/nikolai/.config/emacs/huegli/preferences")
(add-to-list 'load-path "/Users/nikolai/.config/emacs/huegli/features")
(add-to-list 'load-path "/Users/nikolai/.config/emacs/huegli/ui")

;; https://emacs.stackexchange.com/questions/48661/how-do-i-get-flymake-to-recognize-files-in-my-load-path
(setq elisp-flymake-byte-compile-load-path load-path)

(require 'huegli-emacs)
(require 'huegli-theme)
(require 'huegli-looknfeel)
(require 'huegli-history)
(require 'huegli-casual)
(require 'huegli-completion)
(require 'huegli-dired)
(require 'huegli-terminal)
(require 'huegli-org)
(require 'huegli-programing)
(require 'huegli-linting)
(require 'huegli-ai)


(provide 'init)
;;; init.el ends here
