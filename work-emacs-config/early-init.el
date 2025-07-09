;;; Tweak the looks of Emacs

(menu-bar-mode 1)
(scroll-bar-mode -1)
(tool-bar-mode -1)

(let ((mono-spaced-font "MonoLisa")
      (proportionately-spaced-font "Atkinson Hyperledgible"))
  (set-face-attribute 'default nil :family mono-spaced-font :height 140)
  (set-face-attribute 'fixed-pitch nil :family mono-spaced-font :height 1.0)
  (set-face-attribute 'variable-pitch nil :family proportionately-spaced-font :height 1.1))

;; https://emacsredux.com/blog/2025/03/28/speed-up-emacs-startup-by-tweaking-the-gc-settings/

;; Temporarily increase GC threshold during startup
(setq gc-cons-threshold most-positive-fixnum)

;; Restore to normal value after startup (e.g. 50MB)
(add-hook 'emacs-startup-hook
          (lambda () (setq gc-cons-threshold (* 50 1024 1024))))

;; Load themes early to avoid flickering during startup (you need a built-in theme, though)
(load-theme 'modus-operandi t)

(setq inhibit-startup-screen t)

;; tweak native compilation settings
(setq native-comp-speed 2)

;; From Mastering Emacs, https://www.masteringemacs.org/article/spotlight-use-package-a-declarative-configuration-tool

;; need to set this before first use-package
(setq use-package-enable-imenu-support t)
