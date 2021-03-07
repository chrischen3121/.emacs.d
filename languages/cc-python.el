;;; cc-python.el

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

;; set python max line length

(defcustom python-max-line-length 100
  "Line length to enforce."
  :type 'integer
  :safe 'integerp
  :group 'cc-python)

;; pyenv config
(defun cc-python/pyenv-mode-set-local-version ()
  "Set pyenv version from \".python-version\" by looking in parent directories."
  (interactive)
  (let ((root-path (locate-dominating-file default-directory ".python-version")))
    (message root-path)
    (if root-path (let* ((file-path (expand-file-name ".python-version" root-path))
			 (version (with-temp-buffer (insert-file-contents-literally file-path)
						    (buffer-substring-no-properties
						     (line-beginning-position)
						     (line-end-position)))))
		    (if (member version (pyenv-mode-versions))
			(pyenv-mode-set version)
		      (message "pyenv: version `%s' is not installed (set by %s)" version
			       file-path)))
      (pyenv-mode-unset))))

(use-package
  pyenv-mode
  :commands pyenv-mode-versions
  :custom (pyenv-mode-mode-line-format
	   '(:eval (when (pyenv-mode-version)
		     (concat " venv:" (pyenv-mode-version) " "))))
  :hook (python-mode . pyenv-mode)
  (projectile-after-switch-project . cc-python/pyenv-mode-set-local-version)
  :config (cc-python/pyenv-mode-set-local-version)
  (which-key-add-key-based-replacements "C-c e" "pyenv")
  :bind ((:map pyenv-mode-map)
	 ("C-c C-s" . nil)
	 ("C-c C-u" . nil)
	 ("C-c e s" . pyenv-mode-set)
	 ("C-c e u" . pyenv-mode-unset)))

(use-package
  anaconda-mode
  :delight " Ana"
  :hook (python-mode . anaconda-mode)
  (python-mode . anaconda-eldoc-mode))
(use-package
  company-anaconda
  :after (company anaconda-mode)
  :delight
  :config (set (make-local-variable 'company-backends)
	       '((company-anaconda company-yasnippet))))

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
  :custom (blacken-line-length python-max-line-length))

(use-package
  py-isort
  :commands py-isort-buffer
  :custom (py-isort-options `(,(format "-l %d" python-max-line-length))))

(defun cc-python/format-buffer ()
  (interactive)
  (blacken-buffer)
  (py-isort-buffer))

(defun cc-python/set-flycheck-checkers ()
  (flycheck-add-next-checker 'python-flake8 'python-pylint)
  (flycheck-disable-checker 'python-pycompile)
  (flycheck-select-checker 'python-flake8))

(use-package
  python
  :hook (python-mode . smartparens-mode)
  (python-mode . cc-python/set-flycheck-checkers)
  :bind (:map python-mode-map
	      ("C-c f" .  cc-python/py-format-buffer)
	      ("C-c d" .  anaconda-mode-show-doc)
	      ("C-c C-t" . nil)))

;; TODO: ein for notebook
;; TODO: pytest
;; TODO: pipel?


(provide 'cc-python)

;;; cc-python.el ends here
