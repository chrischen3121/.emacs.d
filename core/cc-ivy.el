;;; cc-ivy.el

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

;;; Code:

(use-package
  ivy
  :defer nil
  :ensure counsel
  :config (ivy-mode 1)
  :custom (ivy-use-virtual-buffers t)
  (ivy-count-format "(%d/%d) ")
  :bind (("C-s" . swiper-isearch)
	 ("M-x" . counsel-M-x)
	 ("C-x C-f" . counsel-find-file)
	 ("C-x f" . counsel-recentf)
	 ("M-y" . counsel-yank-pop)
	 ("C-h f" . counsel-describe-function)
	 ("C-h v" . counsel-describe-variable)
	 ("C-h l" . counsel-find-library)
	 ("C-x b" . ivy-switch-buffer)
	 ("C-c v" . ivy-push-view)
	 ("C-c V" . ivy-pop-view)
	 :map ivy-minibuffer-map
	 ("C-l" . ivy-backward-delete-char))
  :delight)

(use-package
  ivy-rich
  :init (ivy-rich-mode +1))

(use-package
  all-the-icons-ivy-rich
  :after (all-the-icons ivy-rich)
  :init (all-the-icons-ivy-rich-mode +1))

(use-package
  which-key
  :config (which-key-mode 1)
  (which-key-add-key-based-replacements "C-x ESC" "repeat-command")
  (which-key-add-key-based-replacements "C-c ESC" "n/a")
  (which-key-add-key-based-replacements "C-x RET" "coding-system")
  (which-key-add-key-based-replacements "C-x 8" "strange-chars")
  (which-key-add-key-based-replacements "C-x @" "event-apply")
  (which-key-add-key-based-replacements "C-x a" "abbrev")
  (which-key-add-key-based-replacements "C-x n" "narrow")
  (which-key-add-key-based-replacements "C-x r" "register")
  :delight)

(provide 'cc-ivy)

;;; cc-ivy.el ends here
