;;; init.el

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

(defvar username (getenv (if (equal system-type 'windows-nt) "USERNAME" "USER")))

(when (version< emacs-version "25.3")
  (error "requires GNUEmacs 25.3 or newer"))

(defvar core-dir (expand-file-name "core" user-emacs-directory))
(defvar modules-dir (expand-file-name "modules" user-emacs-directory))
(defvar languages-dir (expand-file-name "languages" user-emacs-directory))
(defvar savefile-dir (expand-file-name "savefile" user-emacs-directory))
(customize-set-variable 'custom-file (expand-file-name "custom.el" user-emacs-directory))

(unless (file-exists-p savefile-dir)
  (make-directory savefile-dir))

(add-to-list 'load-path core-dir)
(message "Loading core modules...")
(require 'cc-core)
(require 'cc-better-defaults)
(require 'cc-ivy)
(require 'cc-packages)
(require 'cc-prog)
(require 'cc-global-bindings)

(add-to-list 'load-path languages-dir)
(message "Loading language modules...")
(require 'cc-elisp)

(add-to-list 'load-path modules-dir)

(message "Happy Hacking!🌅🚣🏝️")

;;; init.el ends here

