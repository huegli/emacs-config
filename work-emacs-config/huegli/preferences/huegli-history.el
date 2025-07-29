;;; huegli-history.el --- History configuration  -*- coding: utf-8; lexical-binding: t -*-

;;; Commentary:

;;; Code:

(use-package savehist
  :ensure nil ; it is built-in
  :hook (after-init . savehist-mode))

(provide 'huegli-history)
;;; huegli-history.el ends here
