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

;TODO: add irony-mode support

(use-package
  google-c-style
  :hook (c-mode-common . google-set-c-style)
  (c-mode-common . google-make-newline-indent))

(use-package
  clang-format
  :after cc-mode
  :bind (:map c-mode-base-map
              ("C-c f" . clang-format-buffer)))

(use-package
  modern-cpp-font-lock
  :ensure t)

(use-package
  ggtags
  :hook (c-mode-common . ggtags-mode)
  (c-mode-common . smartparens-mode)
  :bind (:map ggtags-mode-map
              ("C-c t s" . ggtags-find-other-symbol)
              ("C-c t h" . ggtags-view-tag-history)
              ("C-c t r" . ggtags-find-reference)
              ("C-c t c" . ggtags-create-tags)
              ("C-c t u" . ggtags-update-tags)
              ("C-c t p" . pop-tag-mark)))
;; TODO: ivy-gtags

(defun cc-c++/set-company-backends ()
  (set (make-local-variable 'company-backends)
       '((company-clang company-yasnippet) company-cmake  company-gtags)))

(defun cc-c++/compile ()
  (interactive)
  (unless (file-exists-p "Makefile")
    (set (make-local-variable 'compile-command)
         (let ((file (file-name-nondirectory buffer-file-name)))
           (format "%s -g -o %s %s" (if  (equal (file-name-extension file) "cpp") "g++" "gcc" )
                   (file-name-sans-extension file) file)))
    (compile compile-command)))

(use-package
  cc-mode
  :custom (indent-tabs-mode nil)
  (tab-width 4)
  (gdb-many-windows t)
  (gdb-show-main t)
  :hook (c++-mode . cc-c++/set-company-backends)
  :config (which-key-add-keymap-based-replacements c-mode-base-map "C-c m" "cc-mode tools")
  :bind (:map c-mode-base-map
              ("C-c m c" . cc-c++/compile)
              ("C-c m d" . gdb)))

(use-package
  gud
  :config (which-key-add-keymap-based-replacements gud-mode-map "C-c m" "gud-mode tools")
  :bind (:map gud-mode-map
              ("C-c m d" . gdb-display-disassembly-buffer)
              ("C-c m D" . gdb-frame-disassembly-buffer)
              ("C-c m m" . gdb-display-memory-buffer)
              ("C-c m M" . gdb-frame-memory-buffer)))

(provide 'cc-cpp)
;;; cc-cpp.el ends here
