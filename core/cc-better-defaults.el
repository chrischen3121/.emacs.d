;;; cc-better-defaults.el --- Enhanced default configuration

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

;;; Commentary:

;; Enhanced default configuration
;;

;;; Code:

(defun cc-core/after-init-func ()
  (tool-bar-mode -1)
  ;; (menu-bar-mode -1)
  (toggle-frame-maximized)
  (delete-selection-mode +1)
  (toggle-scroll-bar -1)
  (fset 'yes-or-no-p 'y-or-n-p)
  (display-battery-mode +1)
  (define-key minibuffer-local-completion-map " " 'self-insert-command))

;; Change default window dividers
(setq window-divider-default-places t window-divider-default-bottom-width 1
      window-divider-default-right-width 1)
(window-divider-mode)

(use-package
  emacs

  :delight
  :custom ((inhibit-startup-screen t)
           (make-backup-files nil)
           (tab-width 4)
           (indent-tabs-mode nil)
           (truncate-lines nil)
           (auto-save-default nil))
           ;;(split-height-threshold nil)
           ;;(split-width-threshold 160))
  :hook ((after-init . cc-core/after-init-func)
         (after-save . executable-make-buffer-file-executable-if-script-p))
  :bind (("S-SPC" . set-mark-command)
         ("C-h w" . woman)))

;; use gruvbox-theme
(use-package
  gruvbox-theme
  :init (if (daemonp)
            (add-hook 'after-make-frame-functions (lambda (frame)
                                                    (select-frame frame)
                                                    (load-theme 'gruvbox-light-medium t)))
          (load-theme 'gruvbox-light-medium t)))

;; helpful
(defun cc-elisp/helpful-current-mode ()
  "replace builtin describe-mode"
  (interactive)
  (helpful-command major-mode))

(use-package
  helpful
  :custom (helm-describe-function-function 'helpful-function)
  (helm-describe-variable-function 'helpful-variable)
  :bind (([remap describe-function] . helpful-callable)
         ([remap describe-variable] . helpful-variable)
         ([remap describe-key] . helpful-key)
         ("C-h c" . helpful-command)
         ([remap describe-mode] . cc-elisp/helpful-current-mode)
         :map emacs-lisp-mode-map ("C-c C-d" . helpful-at-point)))

;; which-key
(use-package
  which-key

  :demand
  :config (which-key-mode 1)
  (which-key-add-key-based-replacements "C-x ESC" "repeat-command")
  (which-key-add-key-based-replacements "C-x p" "project")
  (which-key-add-key-based-replacements "C-x t" "tab")
  (which-key-add-key-based-replacements "C-x x" "buffer")
  (which-key-add-key-based-replacements "C-x RET" "coding-system")
  (which-key-add-key-based-replacements "C-x 8" "strange-chars")
  (which-key-add-key-based-replacements "C-x @" "event-apply")
  (which-key-add-key-based-replacements "C-x a" "abbrev")
  (which-key-add-key-based-replacements "C-x n" "narrow")
  (which-key-add-key-based-replacements "C-x r" "register")
  (which-key-add-key-based-replacements "M-s h" "highlight")
  ;; dev
  (which-key-add-key-based-replacements "C-c d" "dev-tools")
  (which-key-add-key-based-replacements "C-c m" "mode-commands")
  (which-key-add-key-based-replacements "C-c g" "goto-commands")
  :delight)

(use-package
  whole-line-or-region
  :hook (after-init . whole-line-or-region-global-mode)
  :delight whole-line-or-region-local-mode)


(use-package
  edebug
  :commands edebug-mode
  :config (which-key-add-keymap-based-replacements edebug-mode-map "C-x C-a" "edebug"))

;; Builtin highlight
(use-package
  hi-lock
  :config (which-key-add-keymap-based-replacements hi-lock-map "C-x w" "highlight"))

;; smartparens
;; use M-x sp-cheat-sheet show all commands
(use-package
  smartparens
  :init (require ' smartparens-config)
  :hook ((org-mode . smartparens-mode)
         (prog-mode . smartparens-mode))
  :delight smartparens-mode)

;; Notifing changes made by other program
(use-package
  autorevert
  :hook (after-init . global-auto-revert-mode)
  :delight auto-revert-mode)

;; Easy shortcut to switch windows
(use-package
  ace-window
  :bind (([remap other-window] . ace-window)
         ("C-x w" . ace-swap-window)))

;; all-the-icons
(use-package
  all-the-icons
  :config (unless (member "all-the-icons" (font-family-list))
            (all-the-icons-install-fonts t)))

(use-package
  all-the-icons-dired
  :after all-the-icons
  :hook (dired-mode . all-the-icons-dired-mode))

;; TODO: too much ~undotree~ files
;; Attention: queue-0.2 sig issue
;; (use-package
;;   undo-tree
;;   :init (which-key-add-key-based-replacements "C-x u" "undo-tree")
;;   :delight
;;   :custom ((undo-tree-visualizer-timestamps t)
;;            (undo-tree-visualizer-diff t))
;;   :config (global-undo-tree-mode +1)
;;   :bind (("C-/" . undo-tree-undo)
;;          ("M-_" . undo-tree-redo)))

(use-package
  nyan-mode
  :hook (prog-mode text-mode))

(use-package
  whitespace
  :hook (before-save . whitespace-cleanup)
  :bind (("C-c C-w" . whitespace-mode)))

(use-package
  eldoc
  :defer t
  :delight)

(use-package
  hl-todo
  :hook (after-init . global-hl-todo-mode))

;; flyspell & flycheck
(use-package
  flycheck
  :init (which-key-add-key-based-replacements "C-c !" "flycheck")
  :commands flycheck-mode
  :delight
  :hook ((prog-mode . flycheck-mode)
         (text-mode . flycheck-mode))
  :bind (:map flycheck-mode-map
              ("C-c ! ?" . nil)
              ("C-c ! h" . nil)
              ("C-c ! V" . nil)
              ("C-c ! C-w" . nil)
              ("C-c ! C" . nil)
              ("C-c ! x" . nil)
              ("C-c ! e" . nil)
              ("C-c ! H" . nil)))

(use-package
  flyspell
  :delight
  :bind (:map flyspell-mode-map
              ("C-c $" . nil)
              ("C-c ! s" . flyspell-buffer)
              ("C-c ! i" . flyspell-correct-word-before-point))
  :hook ((prog-mode . flyspell-prog-mode)
         (org-mode . flyspell-mode)))


;; TODO: should be toggled manually
;; (use-package
;;   flycheck-grammarly
;;   :custom (flycheck-grammarly-check-time 20)
;;   :after flycheck
;;   :hook (flycheck-mode . flycheck-grammarly-setup))


;; It can help you to move your cursor to ANY position in emacs
;; by using only 3 times key press.
(use-package
  ace-jump-mode
  :bind ("C-x j" . ace-jump-mode))


(provide 'cc-better-defaults)


;;; cc-better-defaults.el ends here
