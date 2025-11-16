;;; early-init.el --- Early Init File for Home Macbook Pro -*- lexical-binding: t; -*-
;;
;; Author: Nikolai Schlegel
;;

;;; Commentary:
;;  Early Init configuration for Emacs
;;

;;; Code:

;;; Fix the PATH
;;; https://github.com/d12frosted/homebrew-emacs-plus/issues/733
(setenv "PATH" "/Users/nikolai/.local/bin:/opt/homebrew/bin:/Applications/Emacs.app/Contents/MacOS/bin:/usr/local/bin:/System/Cryptexes/App/usr/bin:/usr/bin:/bin:/usr/sbin:/sbin:/var/run/com.apple.security.cryptexd/codex.system/bootstrap/usr/local/bin:/var/run/com.apple.security.cryptexd/codex.system/bootstrap/usr/bin:/var/run/com.apple.security.cryptexd/codex.system/bootstrap/usr/appleinternal/bin:/Library/Apple/usr/bin")
(setq exec-path (split-string (getenv "PATH") path-separator))

;;; https://github.com/d12frosted/homebrew-emacs-plus?tab=readme-ov-file#no-titlebar
(add-to-list 'default-frame-alist '(undecorated-round . t))

;;; Tweak the looks of Emacs
(menu-bar-mode 1)
(scroll-bar-mode -1)
(tool-bar-mode -1)


;;; https://emacsredux.com/blog/2025/03/28/speed-up-emacs-startup-by-tweaking-the-gc-settings/

;; Temporarily increase GC threshold during startup
(setq gc-cons-threshold most-positive-fixnum)

;; Restore to normal value after startup (e.g. 50MB)
(add-hook 'emacs-startup-hook
          (lambda () (setq gc-cons-threshold (* 50 1024 1024))))

;; Load themes early to avoid flickering during startup (you need a built-in theme, though)
(add-to-list 'custom-theme-load-path "~/.config/emacs/themes")
(load-theme 'dracula-pro-pro t)

(setq inhibit-startup-screen t)

;; tweak native compilation settings
(setq native-comp-speed 2)

;; From Emacs Solo: https://github.com/LionyxML/emacs-solo/
;; Better Window Management handling
(setq frame-resize-pixelwise t
      frame-inhibit-implied-resize t
      frame-title-format
      '(:eval
        (let ((project (project-current)))
          (if project
              (concat "Emacs - [p] "
                      (file-name-nondirectory (directory-file-name (project-root project))))
            (concat "Emacs - " (buffer-name))))))

(when (eq system-type 'darwin)
  (setq ns-use-proxy-icon nil))

(setq inhibit-compacting-font-caches t)

;; Avoid raising the *Messages* buffer if anything is still without
;; lexical bindings
(setq warning-minimum-level :error)
(setq warning-suppress-types '((lexical-binding)))

;; From Mastering Emacs, https://www.masteringemacs.org/article/spotlight-use-package-a-declarative-configuration-tool

;; need to set this before first use-package
(setq use-package-enable-imenu-support t)

;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:

;;; early-init.el ends here
