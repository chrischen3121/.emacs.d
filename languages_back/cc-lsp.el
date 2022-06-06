;;; cc-lsp.el

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
  lsp-mode
  :init (setq lsp-keymap-prefix "C-c l")
  :hook (python-mode . lsp-deferred)
         ;; (c-mode-common . cc-lsp/set-company-backends)
         ;; if you want which-key integration
         (lsp-mode . lsp-enable-which-key-integration)
  :commands (lsp lsp-deferred))

(use-package
  lsp-ui
  :commands lsp-ui-mode)

(use-package
  lsp-ivy
  :commands lsp-ivy-workspace-symbol)

(use-package
  lsp-treemacs
  :commands lsp-treemacs-errors-list)

;; debugger
;; (use-package
;;   dap-mode
;;   :after lsp-mode
;;   :config (require 'dap-cpptools))
;TODO:

;; (use-package
;;   dap-cpptools
;;   :after dap-mode)
;; (use-package dap-cpptools) to load the dap adapter for your language

(require 'cc-lsp-cpp)
(provide 'cc-lsp)

;;; cc-lsp.el ends here
