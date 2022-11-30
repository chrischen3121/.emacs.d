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


(use-package
  elisp-mode
  :ensure nil
  :delight (emacs-lisp-mode "ELisp"
                            :major)
  :bind (:map emacs-lisp-mode-map
              ("C-c C-c" . eval-buffer)))

(use-package
  elisp-format
  :config (add-to-list 'elisp-format-newline-keyword-addons-list "let")
  (add-to-list 'elisp-format-newline-keyword-addons-list "if")
  :custom (elisp-format-column 100)
  (elisp-format-indent-comment nil)
  :bind (:map emacs-lisp-mode-map
              ("C-c f" . elisp-format-buffer)))


(provide 'cc-elisp)

;;; cc-elisp.el ends here
