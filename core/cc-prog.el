;;; cc-prog.el

;; Author: Chris Chen
;; Maintainer: Chris Chen

;; This file is not part of GNU Emacs

;; This file is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 3, or (at your option)
;; any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; For a full copy of the GNU General Public License
;; see <http://www.gnu.org/licenses/>.

;;; Code:


(use-package
  magit
  :custom (magit-clone-set-remote.pushDefault t)
  :bind ("C-x g" . magit-status))

;; (use-package
;;   tldr
;;   :commands tldr
;;   :bind ("C-c t" . tldr))

(use-package
  projectile
  :init (require 'subr-x)
  :bind-keymap ("C-c p" . projectile-command-map)
  :delight '(:eval (concat " proj:" (projectile-project-name)))
  :config (projectile-mode +1)
  (add-to-list 'projectile-globally-ignored-directories "elpa")
  (add-to-list 'projectile-globally-ignored-directories "savefile")
  (add-to-list 'projectile-globally-ignored-directories ".mypy_cache"))
(which-key-add-key-based-replacements "C-c p" "projectile")

(use-package
  whole-line-or-region
  :defer nil
  :config (whole-line-or-region-global-mode +1)
  :delight whole-line-or-region-local-mode)

(use-package
  which-func
  :custom (which-func-unknown "n/a")
  :hook (prog-mode . which-function-mode))

(use-package
  elisp-format
  :bind (:map emacs-lisp-mode-map
	      ("C-c f" . elisp-format-buffer)))

(use-package
  whitespace
  :hook (before-save . whitespace-cleanup))

(use-package
  company

  :delight
  :config (global-company-mode +1)
  (add-to-list 'company-backends 'company-ispell))



(use-package
  eldoc
  :delight)

(use-package
  autorevert
  :config (global-auto-revert-mode +1)
  :delight auto-revert-mode)

(use-package
  smartparens-config
  :ensure smartparens)

(use-package
  paren
  :defer nil
  :config (show-paren-mode +1))

(use-package
  rainbow-mode

  :delight
  :hook prog-mode)

(use-package
  rainbow-delimiters

  :delight
  :hook (prog-mode . rainbow-delimiters-mode))

(use-package
  flyspell
  :init (setq ispell-extra-args '("--sug-mode=ultra"))
  :delight
  :bind (:map flyspell-mode-map
	      ("C-c $" . nil)
	      ("C-c ! s" . flyspell-buffer))
  :hook ((prog-mode . flyspell-prog-mode)
	 (test-mode . flyspell-mode)))

(use-package
  flycheck
  :hook (prog-mode . flycheck-mode)
  :custom (flycheck-emacs-lisp-load-path 'inherit))

;; flycheck & flyspell
(which-key-add-key-based-replacements "C-c !" "fly")

(use-package
  ace-jump-mode
  :bind (("C-c j" . ace-jump-word-mode)
	 ("C-c l" . ace-jump-line-mode)))

(use-package
  yasnippet
  :delight yas-minor-mode
  :hook ((prog-mode . yas-minor-mode-on)
	 (org-mode . yas-minor-mode-on)
	 (hippie-expand-try-functions-list . yas-hippie-try-expand))
  :bind (:map yas-minor-mode-map
	      ("C-c &" . nil)
	      ("C-c y n" . yas-new-snippet)
	      ("C-c y r" . yas-reload-all)
	      ("C-c y v" . yas-visit-snippet-file)
	      ("M-/" . yas-expand))
  :config (which-key-add-key-based-replacements "C-c y" "yas"))

(use-package
  company-yasnippet
  :ensure company
  :after yasnippet
  :defer t)

(use-package
  hideshow
  :hook (prog-mode . hs-minor-mode)
  :bind (:map hs-minor-mode-map
	      ("C-c @" . nil)
	      ("C-c h H" . hs-hide-all)
	      ("C-c h S" . hs-show-all)
	      ("C-c h h" . hs-hide-block)
	      ("C-c h s" . hs-show-block)
	      ("C-c h l" . hs-hide-level)
	      ("C-c h t" . hs-toggle-hiding))
  :config (which-key-add-key-based-replacements "C-c h" "hs"))

(use-package
  linum
  :hook (prog-mode . linum-mode))

(use-package
  git-gutter+

  :delight
  :config (global-git-gutter+-mode +1))

(use-package
  mwim
  :bind (:map prog-mode-map
	      ("C-a" . mwim-beginning-of-code-or-line)
	      ("C-e" . mwim-end-of-code-or-line)))

(use-package
  auto-highlight-symbol
  :delight
  :hook (prog-mode . auto-highlight-symbol-mode))

(use-package
  hl-todo
  :config (global-hl-todo-mode +1))

(use-package
  json-mode
  :defer t)

(use-package
  yaml-mode
  :defer t)

(use-package
  markdown-mode
  :defer t)

(use-package
  dockerfile-mode
  :defer t)

(use-package
  protobuf-mode
  :defer t)

(provide 'cc-prog)
;;; cc-prog.el ends here
