;;; huegli-remote.el --- Configuration for remote access -*- coding: utf-8; lexical-binding: t -*-

;;; Commentary:

;;; Code:


;; See https://sr.ht/~niklaseklund/dtache/
(use-package detached
  :ensure t
  :commands (detached-init)
  :init
  (detached-init)
  :bind (;; Replace `async-shell-command' with `detached-shell-command'
         ([remap async-shell-command] . detached-shell-command)
         ;; Replace `compile' with `detached-compile'
         ([remap compile] . detached-compile)
         ([remap recompile] . detached-compile-recompile)
         ;; Replace built in completion of sessions with `consult'
         ;; ([remap detached-open-session] . detached-consult-session)
         )
  :custom ((detached-show-output-on-attach t)
           (detached-terminal-data-command system-type)))


(provide 'huegli-remote)
;;; huegli-remote.el ends here
