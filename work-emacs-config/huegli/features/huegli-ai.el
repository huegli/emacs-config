;;; huegli-ai.el --- LLM's and other AI related features -*- coding: utf-8; lexical-binding: t -*-

;;; Commentary:

;;; Code:

(defvar gptel-backend)
(defvar gptel-model)

(defun huegli-gptel-config-models ()
  "Configure Apple's HWTGenAI models."
  (gptel-make-ollama "AppleAI"
      :host "localhost:11211"
      :stream t
      :models '(gemini-2.5-flash
                aws:anthropic.claude-3-5-haiku-20241022-v1:0
                aws:anthropic.claude-sonnet-4-20250514-v1:0
                gemini-2.5-pro
                aws:anthropic.claude-opus-4-20250514-v1:0))
  (setq gptel-backend (gptel-get-backend "AppleAI"))
  (setq gptel-model 'aws:anthropic.claude-3-5-haiku-20241022-v1:0))

(use-package gptel
  :ensure t
  :defer t
  :commands
  (gptel-make-ollama gptel-get-backend)
  :custom
  (gptel-default-mode 'org-mode)
  :config
  (huegli-gptel-config-models))

(use-package claude-code
  :ensure t
  :defer t
  :commands (claude-code-mode)
  :vc (:url "https://github.com/stevemolitor/claude-code.el" :rev :newest)
  :config
  (claude-code-mode)
  :bind-keymap ("C-c c" . claude-code-command-map))

(provide 'huegli-ai)
;;; huegli-ai.el ends here
