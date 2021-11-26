;;; cc-cpp.el

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
  google-c-style
  :hook (c-mode-common . google-set-c-style)
  (c-mode-common . google-make-newline-indent))

(use-package
  ggtags
  :hook (c-mode-common . ggtags-mode)
  (c-mode-common . smartparens-mode)
  :bind (:map ggtags-mode-map
              ("C-c g s" . ggtags-find-other-symbol)
              ("C-c g h" . ggtags-view-tag-history)
              ("C-c g r" . ggtags-find-reference)
              ("C-c g c" . ggtags-create-tags)
              ("C-c g u" . ggtags-update-tags)
              ("C-c g p" . pop-tag-mark)))
;; TODO: ivy-gtags

(defun cc-c++/set-company-backends ()
  (set (make-local-variable 'company-backends)
       '((company-clang company-yasnippet) company-cmake  company-gtags)))

(use-package
  cc-mode
  :custom (indent-tabs-mode nil)
  (tab-width 4)
  (gdb-many-windows t)
  (gdb-show-main t)
  :hook (c++-mode . cc-c++/set-company-backends))

(provide 'cc-cpp)
;;; cc-cpp.el ends here
