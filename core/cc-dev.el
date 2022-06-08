;;; cc-dev.el --- Tools for development

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

;;; Commentary:

;; Tools for development
;;

;;; Code:

(use-package
  magit
  :custom (magit-clone-set-remote.pushDefault t)
  :bind ("C-x g" . magit-status))

;; (use-package
;;   projectile
;;   :init (require 'subr-x)
;;   :bind-keymap ("C-c p" . projectile-command-map)
;;   :delight '(:eval (concat " proj:" (projectile-project-name)))
;;   :config (projectile-mode +1)
;;   (add-to-list 'projectile-globally-ignored-directories "elpa")
;;   (add-to-list 'projectile-globally-ignored-directories "savefile")
;;   (add-to-list 'projectile-globally-ignored-directories ".mypy_cache")
;;   (which-key-add-key-based-replacements "C-c p" "projectile"))

;; (use-package
;;   autorevert
;;   :config (global-auto-revert-mode +1)
;;   :delight auto-revert-mode)

(use-package
  company
  :delight
  :custom (company-transformers '(company-sort-by-backend-importance))
  :hook (after-init . global-company-mode)
  :bind (:map company-mode-map
              ("C-c C-d c" . company-diag)))

(use-package
  yasnippet
  :delight yas-minor-mode
  :hook ((prog-mode . yas-minor-mode-on)
         (org-mode . yas-minor-mode-on))
  :bind (:map yas-minor-mode-map
              ("C-c &" . nil)
              ("C-c C-d y n" . yas-new-snippet)
              ("C-c C-d y r" . yas-reload-all)
              ("C-c C-d y v" . yas-visit-snippet-file)
              ("M-/" . yas-expand))
  :config (which-key-add-keymap-based-replacements yas-minor-mode-map "C-c C-d y" "yasnippet"))



(use-package
  hideshow
  :hook (prog-mode . hs-minor-mode)
  :bind (:map hs-minor-mode-map
              ("C-c @" . nil)
              ("C-c C-d h h" . hs-hide-all)
              ("C-c C-d h <backtab>" . hs-show-all)
              ("C-c C-d h l" . hs-hide-level)
              ("C-c C-d <tab>" . hs-toggle-hiding))
  :config (which-key-add-keymap-based-replacements hs-minor-mode-map "C-c C-d h" "hideshow"))
;; Other useful command
;; C-x n d  narrow-to-defun
;; C-x n w  widen

(use-package
  linum
  :hook (prog-mode . linum-mode))

(provide 'cc-dev)

;;; cc-dev.el ends here
