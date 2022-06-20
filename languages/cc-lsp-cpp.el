;;; cc-lsp-cpp.el --- lsp-mode configuration for C++

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
;; TODO: may add company-cmake, company-clang, company-gtags
(defun cc-lsp-cpp/set-company-backends ()
  (setq-local company-backends '(company-capf company-ispell)))

(defun cc-lsp-cpp/compile ()
  (interactive)
  (unless (file-exists-p "Makefile")
    (set (make-local-variable 'compile-command)
         (let ((file (file-name-nondirectory buffer-file-name)))
           (format "%s -std=c++20 -Wall -g -o %s %s" (if  (equal
                                                           (file-name-extension
                                                            file) "cpp") "g++"
                                                       "gcc" )
                   (file-name-sans-extension file) file)))
    (compile compile-command)))

(use-package
  cc-mode
  :ensure nil
  :custom (indent-tabs-mode nil)
  (tab-width 4)
  ;; (gdb-many-windows t)
  ;; (gdb-show-main t)
  :hook ((c-mode-common . lsp-deferred)
         (c-mode-common . cc-lsp-cpp/set-company-backends))
  :bind (:map c-mode-base-map
              ("C-c m c" . cc-lsp-cpp/compile)
              ("C-c m d" . gdb)))

;; TODO: to use dap-mode
;; (use-package
;;   gud
;;   :config (which-key-add-keymap-based-replacements gud-mode-map "C-c m"
;;             "gud-mode tools")
;;   :bind (:map gud-mode-map
;;               ("C-c m d" . gdb-display-disassembly-buffer)
;;               ("C-c m D" . gdb-frame-disassembly-buffer)
;;               ("C-c m m" . gdb-display-memory-buffer)
;;               ("C-c m M" . gdb-frame-memory-buffer)))


(provide 'cc-lsp-cpp)

;;; cc-lsp-cpp.el ends here
