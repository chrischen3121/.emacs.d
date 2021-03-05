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

(use-package
  anaconda-mode
  :delight " Ana"
  :hook (python-mode . anaconda-mode)
  (python-mode . anaconda-eldoc-mode))

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


;; pyenv config
(defun cc-python/pyenv-mode-set-local-version ()
  "Set pyenv version from \".python-version\" by looking in parent directories."
  (interactive)
  (let ((root-path (locate-dominating-file default-directory ".python-version")))
    (when root-path (let* ((file-path (expand-file-name ".python-version" root-path))
			   (version (with-temp-buffer (insert-file-contents-literally file-path)
						      (buffer-substring-no-properties
						       (line-beginning-position)
						       (line-end-position)))))
		      (if (member version (pyenv-mode-versions))
			  (pyenv-mode-set version)
			(message "pyenv: version `%s' is not installed (set by %s)" version
				 file-path))))))

(use-package
  pyenv-mode
  :commands pyenv-mode-versions
  :hook (python-mode . pyenv-mode)
  (python-mode . cc-python/pyenv-mode-set-local-version)
  (projectile-after-switch-project-hook . cc-python/pyenv-mode-set-local-version)
  :bind ((:map pyenv-mode-map)
	 ("C-c C-s" . nil)
	 ("C-c C-u" . nil)))


(defun cc-python/py-format-buffer ()
  (interactive)
  (blacken-buffer)
  (py-isort-buffer))

(use-package
  python
  :config (flycheck-add-next-checker 'python-flake8 'python-pylint)
  :bind (:map python-mode-map
	      ("C-c f" .  cc-python/py-format-buffer)
	      ("C-c ?" .  anaconda-mode-show-doc)))

(add-hook 'python-mode-hook (lambda ()
			      (smartparens-mode +1)
			      ;; (set (make-local-variable 'company-backends)
			      ;;	   '((company-anaconda company-yasnippet)))
			      ))

;; TODO: ein for notebook
;; TODO: pytest
;; TODO: pipel?


(provide 'cc-python)

;;; cc-python.el ends here
