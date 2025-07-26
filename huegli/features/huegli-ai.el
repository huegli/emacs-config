;;; huegli-ai.el --- LLM's and other AI related features -*- coding: utf-8; lexical-binding: t -*-

;;; Commentary:

;;; Code:

(use-package gptel
  :ensure t
  :defer t
  :commands
  (gptel-make-openai  gptel-make-anthropic gptel-make-perplexity
                      gptel-get-backend)
  :defines gptel-backend
  :custom
  (gptel-default-mode 'org-mode)
  :config
  (gptel-make-perplexity "Perplexity"
    :key (auth-source-pick-first-password
          :host "api.perplexity.ai")
    :stream t)
  (gptel-make-anthropic "Claude"
    :key (auth-source-pick-first-password
          :host "api.anthropic.com")
    :stream t)
  (gptel-make-openai "OpenRouter"
    :host "openrouter.ai"
    :endpoint "/api/v1/chat/completions"
    :key (auth-source-pick-first-password
          :host "openrouter.ai")
    :stream t
    :models '(openai/gpt-4.1-mini
              google/gemini-2.5-flash))
  (setq gptel-backend (gptel-get-backend "Perplexity")))


(use-package claude-code
  :ensure (:type git :host github :repo "stevemolitor/claude-code.el" :branch "main" :depth 1
                   :files ("*.el" (:exclude "images/*")))
  :defer t
  :config
  (claude-code-mode)
  :bind-keymap ("C-c c" . claude-code-command-map))

(provide 'huegli-ai)
;;; huegli-ai.el ends here
