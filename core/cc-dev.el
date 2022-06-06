(use-package
  magit
  :custom (magit-clone-set-remote.pushDefault t)
  :bind ("C-x g" . magit-status))

(use-package
  projectile
  :init (require 'subr-x)
  :bind-keymap ("C-c p" . projectile-command-map)
  :delight '(:eval (concat " proj:" (projectile-project-name)))
  :config (projectile-mode +1)
  (add-to-list 'projectile-globally-ignored-directories "elpa")
  (add-to-list 'projectile-globally-ignored-directories "savefile")
  (add-to-list 'projectile-globally-ignored-directories ".mypy_cache")
  (which-key-add-key-based-replacements "C-c p" "projectile"))

(use-package
  autorevert
  :config (global-auto-revert-mode +1)
  :delight auto-revert-mode)

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

(use-package
  hideshow
  :hook (prog-mode . hs-minor-mode)
  :bind (("C-c h f" . narrow-to-defun)
     ("C-c h w" . widen)
     :map hs-minor-mode-map ("C-c @" . nil)
     ("C-c h H" . hs-hide-all)
     ("C-c h S" . hs-show-all)
     ("C-c h h" . hs-hide-block)
     ("C-c h s" . hs-show-block)
     ("C-c h l" . hs-hide-level)
     ("C-c h t" . hs-toggle-hiding))
  :config (which-key-add-keymap-based-replacements hs-minor-mode-map "C-c h" "hs"))

(use-package
  linum
  :hook prog-mode)

(provide 'cc-dev)
