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

;; load files
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

(message "Loading language modules...")
(add-to-list 'load-path languages-dir)
(require 'cc-langs)

(message "Happy Hacking!🌅🚣🏝️")

;;; init.el ends here
