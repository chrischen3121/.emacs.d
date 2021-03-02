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

(use-package
  whole-line-or-region
  :config (whole-line-or-region-global-mode +1)
  (add-hook 'prog-mode-hook (lambda ()
			      (delight 'whole-line-or-region-local-mode))))

(use-package
  which-func
  :config (which-func-mode +1)
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
  ;; :delight
  :config (global-company-mode +1))

(use-package
  eldoc
  :delight)

(provide 'cc-prog)
;;; cc-prog.el ends here
