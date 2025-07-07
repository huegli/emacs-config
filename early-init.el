
(menu-bar-mode 1)
(scroll-bar-mode 1)
(tool-bar-mode -1)

(let ((mono-spaced-font "MonoLisa")
      (proportionately-spaced-font "Atkinson Hyperledgible"))
  (set-face-attribute 'default nil :family mono-spaced-font :height 140)
  (set-face-attribute 'fixed-pitch nil :family mono-spaced-font :height 1.0)
  (set-face-attribute 'variable-pitch nil :family proportionately-spaced-font :height 1.2))

(load-theme 'modus-vivendi t)

;; need to set this before first use-package
(setq use-package-enable-imenu-support t)
