;;; huegli-remote.el --- Configuration for remote access -*- coding: utf-8; lexical-binding: t -*-

;;; Commentary:

;;; Code:

;; see https://coredumped.dev/2025/06/18/making-tramp-go-brrrr./
(use-package tramp-mode
  :ensure nil
  :init
  ;; configure SSH connections for Apple Linux VM's
  (connection-local-set-profile-variables
   'remote-local-bin-path-tcsh
   ;; https://stackoverflow.com/questions/26630640/tramp-ignores-tramp-remote-path
   '((tramp-remote-path . ("/home/nschlegel/.local/bin" tramp-default-remote-path))
     (explicit-shell-file-name . "/bin/tcsh")))
  (connection-local-set-profiles
   '(:application tramp :protocol "sshx")
   'remote-local-bin-path-tcsh)
  ;; Direct async for scp
  (connection-local-set-profile-variables
   'remote-direct-async-process
   '((tramp-direct-async-process . t)))
  (connection-local-set-profiles
   '(:application tramp :protocol "scp")
   'remote-direct-async-process)
  :custom
  (shell-history-file-name t)
  (remote-file-name-inhibit-locks t)
  (remote-file-name-inhibit-auto-save t)
  (tramp-default-method "ssh")
  (tramp-default-user "nschlegel")
  (tramp-default-host "lin8")
  (tramp-copy-size-limit (* 1024 1024))
  (tramp-verbose 2)  ;; 6 for debug
  (tramp-use-connection-share t)  ;; use Control* options below
  (tramp-ssh-controlmaster-options "-o ControlMaster=auto -o ControlPath=~/.ssh/controlmasters/%%r@%%h:%%p -o ControlPersist=90m"))


;; See https://sr.ht/~niklaseklund/dtache/
(use-package detached
  :commands (detached-init)
  :init
  (detached-init)
  :custom
  ((show-output-on-attach t)
   (detached-terminal-data-command 'gnu/linux) ;; this will only work for remote Linux VM's, not local MacOS shells
   (detached-notification-function #'detached-extra-alert-notification)))

;; https://github.com/jwiegley/alert
(use-package alert
  :custom
  (alert-default-style 'notifier)) ;; requires terminal-notifier to be installed

(provide 'huegli-remote)
;;; huegli-remote.el ends here
