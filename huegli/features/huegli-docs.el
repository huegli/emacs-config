;;; huegli-docs.el --- Document handling related features -*- coding: utf-8; lexical-binding: t -*-

;;; Commentary:

;;; Code:

(setq package-vc-allow-build-commands t)

(use-package reader
  :vc (:url "https://codeberg.org/divyaranjan/emacs-reader"
  	    :make "all"))

(provide 'huegli-docs)
;;; huegli-docs.el ends here
