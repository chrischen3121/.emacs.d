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

;; (defun cc-lsp/remap-goto-prefix ()
;;   (define-key lsp-mode-map (kbd "C-c g")
;;     (lookup-key lsp-mode-map (kbd "C-c l g"))))

(use-package
  lsp-mode
  :init (setq lsp-keymap-prefix "C-c l")
  :custom (lsp-modeline-diagnostics-scope :workspace)
  :hook (lsp-mode  . lsp-enable-which-key-integration)
  ;; (python-mode . lsp-deferred)
  ;; (c-mode-common . cc-lsp/set-company-backends)
  :commands (lsp lsp-deferred)
  :bind (:map lsp-mode-map
              ("C-c f" . lsp-format-buffer)
              ("C-c g d" . lsp-find-declaration)
              ("C-c g t" . lsp-find-type-definition)
              ("C-c g g" . lsp-ui-peek-find-definitions)
              ("C-c g r" . lsp-ui-peek-find-references)
              ("C-c g i" . lsp-ui-peek-find-implementation)))

(use-package
  lsp-ui
  :after lsp-mode
  :commands lsp-ui-mode
  :bind (:map lsp-ui-mode-map
              ("C-c m d" . lsp-ui-doc-show)
              ("C-c m D" . lsp-ui-doc-hide)))


(use-package
  lsp-treemacs
  :after (treemacs lsp-mode)
  :hook (lsp-mode . lsp-treemacs-sync-mode)
  :bind (:map lsp-mode-map
              ("C-c t e" . lsp-treemacs-errors-list)
              ("C-c t s" . lsp-treemacs-symbols)
              ("C-c t r" . lsp-treemacs-references)
              ("C-c t c" . lsp-treemacs-call-hierarchy)
              ("C-c t p" . lsp-treemacs-type-hierarchy)))


(use-package
  helm-lsp
  :demand
  :after (helm lsp-mode helm-projectile)
  :commands helm-lsp-workspace-symbol
  :bind (:map lsp-mode-map
              ("C-c g a" . helm-lsp-workspace-symbol)
              ("C-c g e" . helm-lsp-diagnositics)
              ("C-c g m" . helm-imenu)
              ("C-c p P" . helm-lsp-switch-project)))

(use-package
  dap-mode
  :init (add-hook 'dap-stopped-hook (lambda (arg)
                                      (call-interactively #'dap-hydra)))
  :hook (lsp-mode . dap-mode)
  :custom (dap-auto-configure-features '(sessions locals controls tooltip))
  :bind (:map dap-mode-map
              ("C-c l d d" . dap-debug)
              ("<f5>" . dap-debug)
              ("C-c l d e" . dap-debug-edit-template)
              ("C-c m g" . dap-debug))
  :config (which-key-add-keymap-based-replacements dap-mode-map "C-c l d" "debug"))


(provide 'cc-lsp)

;;; cc-lsp.el ends here
