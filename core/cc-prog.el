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
  :defer nil
  :delight '(:eval (concat " Proj[" (projectile-project-name) "]"))
  :bind ("C-c p" . projectile-command-map)
  :config (projectile-mode 1)
  (which-key-add-key-based-replacements "C-c p" "projectile"))

(use-package
  which-func
  :config (which-function-mode 1)
  (setq which-func-unknown "n/a"))

(use-package
  elisp-format
  :no-require t
  :bind (:map emacs-lisp-mode-map
	      ("C-c f" . elisp-format-buffer)))
(require 'elisp-format)

;; (use-package company-mode
;;   :no-require t
;;   )

(provide 'cc-prog)
;;; cc-prog.el ends here
