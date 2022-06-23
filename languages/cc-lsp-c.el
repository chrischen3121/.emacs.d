;;; cc-lsp-c.el --- lsp-mode for c configuration

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

;;; Code:

(defun cc-lsp-c/compile ()
  (interactive)
  (unless (file-exists-p "Makefile")
    (set (make-local-variable 'compile-command)
         (let ((file (file-name-nondirectory buffer-file-name)))
           (format "gcc -Wall -g -o %s %s" (file-name-sans-extension file) file)))
    (compile compile-command)))


(use-package
  cc-mode
  :ensure nil
  :commands c-mode
  :hook (c-mode . lsp-deferred)
  :config (require 'dap-gdb-lldb)
  (dap-gdb-lldb-setup)
  :bind (:map c-mode-map
              ("C-c m c" . cc-lsp-c/compile)
              ("<f7>" . cc-lsp-c/compile)
              ("C-c m g" . dap-debug)
              ("C-c m e" . dap-debug-edit-template)))

(provide 'cc-lsp-c)

;;; cc-lsp-c.el ends here
