;;; cc-lsp-python.el --- lsp-mode configuration for Python

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
;;

;;; Code:

(defcustom cc-lsp-python/python-max-line-length 100
  "Line length to enforce."
  :type 'integer
  :safe 'integerp
  :group 'cc-lsp-python)

(use-package
  lsp-pyright
  :custom (lsp-pyright-venv-path "~/.cache/pypoetry/virtualenvs")
  :hook (python-mode . (lambda ()
                         (require 'lsp-pyright)
                         (lsp-deferred))))

(use-package
  sphinx-doc

  :delight
  :hook (python-mode . sphinx-doc-mode)
  :bind (:map python-mode-map
              ("C-c M-d" . nil)
              ("C-c C-d" . sphinx-doc)))

;; code formatting
(use-package
  blacken
  :commands blacken-buffer
  :custom (blacken-line-length cc-lsp-python/python-max-line-length))

(use-package
  py-isort
  :commands py-isort-buffer
  :custom (py-isort-options `(,(format "-l %d" cc-lsp-python/python-max-line-length))))

(defun cc-lsp-python/format-buffer ()
  (interactive)
  (blacken-buffer)
  (py-isort-buffer))

(use-package
  python
  :custom (python-shell-interpreter "ipython")
  (python-shell-interpreter-args "--simple-prompt -i")
  (tab-width 4)
  :bind (:map python-mode-map
              ([remap lsp-format-buffer] . cc-lsp-python/format-buffer))
  :config (which-key-add-keymap-based-replacements python-mode-map "C-c C-t" "skeleton"))

(use-package
  poetry
  :ensure t
  :config (poetry-tracking-mode)
  :custom (poetry-tracking-strategy 'projectile))
;; (use-package
;;   pipenv
;;   :hook (python-mode . pipenv-mode)
;;   :config (which-key-add-keymap-based-replacements pipenv-mode-map "C-c C-p" "pipenv")
;;   :custom (pipenv-projectile-after-switch-function #'pipenv-projectile-after-switch-extended))

(provide 'cc-lsp-python)
;;; cc-lsp-python.el ends here
