;;; cc-elisp.el

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

(delight 'emacs-lisp-mode "ELisp"
     :major)

(defun cc-elisp/set-company-backends ()
  (set (make-local-variable 'company-backends)
       '((company-elisp company-yasnippet))))

(use-package
  elisp-mode
  :ensure nil
  :hook (emacs-lisp-mode . smartparens-mode)
  (emacs-lisp-mode . cc-elisp/set-company-backends))

(provide 'cc-elisp)

;;; cc-elisp.el ends here
