;;; cc-dev.el --- Tools for development

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

;; Tools for development
;;

;;; Code:
(use-package
  projectile
  :init (which-key-add-key-based-replacements "C-x p" "projectile")
  :custom ((projectile-completion-system 'helm)
           (projectile-enable-caching t))
  :bind-keymap ("C-x p" . projectile-command-map)
  :delight '(:eval (concat " P[" (projectile-project-name) "]"))
  :hook (after-init . projectile-mode)
  :config (add-to-list 'projectile-globally-ignored-directories "elpa")
  (add-to-list 'projectile-globally-ignored-directories "savefile")
  (add-to-list 'projectile-globally-ignored-directories ".mypy_cache"))

(use-package
  helm-projectile
  :init (which-key-add-key-based-replacements "C-c p" "helm-proj")
  :after (helm projectile)
  :hook (projectile-mode . helm-projectile-on)
  :bind (("C-c p h" . helm-projectile)
         ("C-c p p" . helm-projectile-switch-project)
         ("C-c p f" . helm-projectile-find-file)
         ("C-c p F" . helm-projectile-find-file-in-known-projects)
         ("C-c p m" . helm-projectile-find-file-dwim)
         ("C-c p d" . helm-projectile-find-dir)
         ("C-c p e" . helm-projectile-find-recentf)
         ("C-c p b" . helm-projectile-switch-to-buffer)
         ("C-c p g" . helm-projectile-grep)
         ("C-c p a" . helm-projectile-ag)
         ("C-c p r" . helm-projectile-rg)))


(use-package
  magit
  :custom (magit-clone-set-remote.pushDefault t)
  :bind ("C-x g" . magit-status))

;; highlight changes
(use-package
  git-gutter+

  :delight
  :hook (after-init . global-git-gutter+-mode))



(defun cc-dev/set-text-backends ()
  (setq-local company-backends '((company-yasnippet company-dabbrev company-ispell
                                                    :separate) company-files)))
(defun cc-dev/set-prog-backends ()
  (setq-local company-backends '((company-yasnippet company-capf company-dabbrev-code
                                                    company-keywords
                                                    :separate) company-ispell)))


(use-package
  company
  ;; :delight
  :custom (company-transformers '(company-sort-by-backend-importance))
  :hook ((after-init . global-company-mode)
         (text-mode . cc-dev/set-text-backends)
         (prog-mode . cc-dev/set-prog-backends))
  :bind (:map company-mode-map
              ("C-c C-/" . company-other-backend)))

;; (use-package
;;   orderless
;;   :init (add-hook 'company-mode-hook (lambda ()
;;                                        (require 'orderless)))
;;   :custom (completion-styles '(helm basic))
;;   (completion-category-overrides '((file (styles basic partial-completion)))))


(use-package
  yasnippet
  :delight yas-minor-mode
  :config (which-key-add-keymap-based-replacements yas-minor-mode-map "C-c d y" "yasnippet")
  :hook ((prog-mode . yas-minor-mode-on)
         (org-mode . yas-minor-mode-on))
  :bind (:map yas-minor-mode-map
              ("C-c &" . nil)
              ("C-c d y n" . yas-new-snippet)
              ("C-c d y r" . yas-reload-all)
              ("C-c d y v" . yas-visit-snippet-file)
              ("M-/" . company-yasnippet)))


(use-package
  hideshow
  :hook (prog-mode . hs-minor-mode)
  :bind (:map hs-minor-mode-map
              ("C-c @" . nil)
              ("C-c d <backtab>" . hs-show-all)
              ("C-c d l" . hs-hide-level)
              ("C-c d <tab>" . hs-toggle-hiding))
  :config (which-key-add-keymap-based-replacements hs-minor-mode-map "C-c d h" "hideshow")
  :delight hs-minor-mode)
;; Other useful command
;; C-x n d  narrow-to-defun
;; C-x n w  widen

(use-package
  linum
  :hook (prog-mode . linum-mode))

(use-package
  prog-mode
  :ensure nil
  :config (which-key-add-keymap-based-replacements prog-mode-map "C-c m t" "term")
  :bind (:map prog-mode-map
              ("C-c m t t" . term)
              ("C-c m t r" . shell-command-on-region)
              ("C-c m t a" . async-shell-command)
              ("C-c m r" . shell-command)))


;; "Move Where I Mean"
(use-package
  mwim
  :bind (:map prog-mode-map
              ("C-a" . mwim-beginning-of-code-or-line)
              ("C-e" . mwim-end-of-code-or-line)))

;; Visualizing Color Codes
(use-package
  rainbow-mode
  :delight
  :hook prog-mode)

;; Colorize parens
(use-package
  rainbow-delimiters

  :delight
  :hook (prog-mode . rainbow-delimiters-mode))

(provide 'cc-dev)

;;; cc-dev.el ends here
