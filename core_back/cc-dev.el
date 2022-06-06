(use-package
  company
  :delight
  :config (global-company-mode +1))

(use-package
  yasnippet
  :delight yas-minor-mode
  :hook ((prog-mode . yas-minor-mode-on)
         (org-mode . yas-minor-mode-on))
  ;; TODO: (hippie-expand-try-functions-list . yas-hippie-try-expand))
  :bind (:map yas-minor-mode-map
              ("C-c &" . nil)
              ("C-c y n" . yas-new-snippet)
              ("C-c y r" . yas-reload-all)
              ("C-c y v" . yas-visit-snippet-file)
              ("M-/" . yas-expand))
  :config (which-key-add-keymap-based-replacements yas-minor-mode-map "C-c y" "yasnippet"))

(use-package
  company-yasnippet
  :ensure company
  :after yasnippet
  :defer t)

(provide 'cc-dev)

