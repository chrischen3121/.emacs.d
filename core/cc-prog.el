;;; cc-prog.el

;; Author: chrischen
;; Maintainer: chrischen

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
  :bind ("C-x g" . magit-status))

(use-package
  projectile
  :init (require 'subr-x)
  :bind-keymap ("C-c p" . projectile-command-map)
  :delight '(:eval (concat " [" (projectile-project-name) "]"))
  :config (projectile-mode +1)
  (add-to-list 'projectile-globally-ignored-directories "elpa")
  (add-to-list 'projectile-globally-ignored-directories "savefile")
  (add-to-list 'projectile-globally-ignored-directories ".mypy_cache"))
(which-key-add-key-based-replacements "C-c p" "projectile")

(use-package
  whole-line-or-region
  :config (whole-line-or-region-global-mode +1)
  :delight whole-line-or-region-local-mode)

(use-package
  which-func
  :config (which-function-mode +1)
  (setq which-func-unknown "n/a"))

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
  :config (global-company-mode +1))

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
  :custom-face
  :config (show-paren-mode +1))

(use-package
  rainbow-mode
  :delight
  :hook prog-mode)

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

(which-key-add-key-based-replacements "C-c !" "fly")

(use-package
  ace-jump-mode
  :bind (("C-c j" . ace-jump-word-mode)
	 ("C-c l" . ace-jump-line-mode)))

(provide 'cc-prog)
;;; cc-prog.el ends here
