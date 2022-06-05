;;; cc-core.el

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
(require 'cl-lib)

(require 'package)
(setq package-archives '(("gnu"   . "https://elpa.zilongshanren.com/gnu/")
                         ("melpa" . "https://elpa.zilongshanren.com/melpa/")
                         ("org" . "https://elpa.zilongshanren.com/org/")))
(package-initialize)
(unless package-archive-contents (package-refresh-contents))

;; install use-package
(unless (package-installed-p 'use-package)
  (package-install 'use-package))

;; futher reduce load time
(eval-when-compile
  (require 'use-package))

;; globally ensure package installation
(setq use-package-always-ensure t)
(setq use-package-verbose t)

(use-package use-package-ensure-system-package
  :ensure t)

(use-package
  delight
  :defer t)

;; keep package updated
;; (use-package
;;   auto-package-update
;;   :config (setq auto-package-update-delete-old-versions t)
;;   (setq auto-package-update-hide-results t)
;;   (auto-package-update-maybe))

(prefer-coding-system 'utf-8)

(provide 'cc-core)

;;; cc-core.el ends here
