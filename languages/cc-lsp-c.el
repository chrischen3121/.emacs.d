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
;;
;; Install lldb-vscode first
;; mkdir -p ~/.vscode/extensions/llvm-org.lldb-vscode-0.1.0/bin
;; curl https://github.com/llvm/llvm-project/tree/main/lldb/tools/lldb-vscode/package.json --output

;;; Code:

(use-package
  cc-mode
  :ensure nil
  :init (add-hook 'dap-mode-hook (lambda ()
                                   (require 'dap-lldb)))
  :hook (c-mode . lsp-deferred))

(provide 'cc-lsp-c)

;;; cc-lsp-c.el ends here
