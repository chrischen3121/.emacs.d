;;; init.el

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

(defvar username (getenv (if (equal system-type 'windows-nt) "USERNAME" "USER")))

(when (version< emacs-version "27.2")
  (error
   "Requires GNUEmacs 27.2 or newer"))

(setq custom-file (expand-file-name "mycustom.el" user-emacs-directory))
(load custom-file)

(defvar core-dir (expand-file-name "core" user-emacs-directory))
(defvar languages-dir (expand-file-name "languages" user-emacs-directory))
(defvar savefile-dir (expand-file-name "savefile" user-emacs-directory))
(defvar private-dir (expand-file-name "private" user-emacs-directory))


(unless (file-exists-p savefile-dir)
  (make-directory savefile-dir))

(message "Loading core modules...")
(add-to-list 'load-path core-dir)
(require 'cc-core)
;; (require 'cc-prog)
;; (require 'cc-org)
;; (require 'cc-agenda)
;; (require 'cc-org-roam)
;; (require 'cc-org-project)
;; (require 'cc-global-bindings)

(message "Loading language modules...")
(add-to-list 'load-path languages-dir)
(require 'cc-langs)
;; (require 'cc-lsp)
;; ;; (require 'cc-python)
;; ;; (require 'cc-cpp)
;; (require 'cc-scheme)
;; (require 'cc-json)
;; (require 'cc-js)
;; (require 'cc-sml)
;; (require 'cc-html)
;; (require 'cc-css)

(message "Happy Hacking!🌅🚣🏝️")

;;; init.el ends here
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages '(queue helm-icons helm nyan-mode undo-tree
                                     all-the-icons-dired all-the-icons
                                     ace-window smartparens whole-line-or-region
                                     which-key gruvbox-theme cnfonts
                                     auto-package-update delight
                                     use-package-ensure-system-package
                                     use-package)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
