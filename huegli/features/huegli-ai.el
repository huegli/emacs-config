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

(use-package shell-maker
  :ensure t)

(use-package acp
  :vc (:url "https://github.com/xenodium/acp.el"))

(use-package agent-shell
  :vc (:url "https://github.com/xenodium/agent-shell")
  :commands (agent-shell-google-make-authentication agent-shell-anthropic-make-authentication)
  :config
  (setq agent-shell-google-authentication
        (agent-shell-google-make-authentication :login t))
  (setq agent-shell-anthropic-authentication
        (agent-shell-anthropic-make-authentication :login t)))


(provide 'huegli-ai)
;;; huegli-ai.el ends here
