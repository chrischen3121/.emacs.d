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
;; TODO: clang-refactor
;; TODO: clang-rename
;; TODO: clang-tidy
;;; Code:

;;; Hints:
;; https://emacs-lsp.github.io/lsp-mode/tutorials/CPP-guide/

(defun cc-lsp-cpp/compile ()
  (interactive)
  (unless (file-exists-p "Makefile")
    (set (make-local-variable 'compile-command)
         (let ((file (file-name-nondirectory buffer-file-name)))
           (format "g++ -std=c++20 -Wall -g -o %s %s" (file-name-sans-extension file) file))))
  (compile compile-command))

(use-package
  cc-mode
  :ensure nil
  :commands c++-mode
  ;; TODO: :custom (lsp-clients-clangd-args '("--header-insertion-decorators=0" "--clang-tidy"))
  :hook (c++-mode . lsp-deferred)
  :config (require 'dap-gdb-lldb)
  (require 'dap-cpptools)
  :bind (:map c++-mode-map
              ("C-c m c" . cc-lsp-cpp/compile)
              ("<f7>" . cc-lsp-cpp/compile)
              ("C-c m g" . dap-debug)
              ("C-c m e" . dap-debug-edit-template)))

(provide 'cc-lsp-cpp)

;;; cc-lsp-cpp.el ends here
