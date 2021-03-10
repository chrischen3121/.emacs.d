;;; cc-org.el

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

(setq org-todo-keywords '((sequence "TODO(t)" "INPROGRESS(i)" "WAITING(w)" "REVIEW(r)" "|" "DONE(d)"
				    "CANCELED(c)")))

(setq org-todo-keyword-faces '(("TODO" . org-warning)
			       ("INPROGRESS" . "yellow")
			       ("WAITING" . "purple")
			       ("REVIEW" . "orange")
			       ("DONE" . "green")
			       ("CANCELED" .  "red")))

(use-package
  graphviz-dot-mode
  :defer t)

(use-package
  plantuml-mode
  :custom (plantuml-executable-path "plantuml")
  (plantuml-default-exec-mode 'executable))

(use-package
  htmlize
  :defer t)

(use-package
  org-bullets
  :hook (org-mode . org-bullets-mode))

(use-package
  org-alert
  :defer t
  :custom (alert-default-style 'libnotify))

(require 'ox-md)

(use-package
  org
  :hook (org-mode . flyspell-mode)
  (org-mode . smartparens-mode))

(provide 'cc-org)

;;; cc-org.el ends here
