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

;; early init
;; to prevent any garbage collection from happening during load time.
(defconst 1mb 1048576)
(defconst 20mb 20971520)
(defconst 30mb 31457280)
(defconst 50mb 52428800)

(defun cc-init/defer-garbage-collection ()
  (setq gc-cons-threshold most-positive-fixnum))

(defun cc-init/restore-garbage-collection ()
  (run-at-time 1 nil (lambda ()
                       (setq gc-cons-threshold 30mb))))

(add-hook 'emacs-startup-hook 'cc-init/restore-garbage-collection 100)
(add-hook 'minibuffer-setup-hook 'cc-init/defer-garbage-collection)
(add-hook 'minibuffer-exit-hook 'cc-init/restore-garbage-collection)

(setq read-process-output-max 1mb)  ;; lsp-mode's performance suggest

;; Resizing the Emacs frame can be a terribly expensive part of changing the
;; font. By inhibiting this, we easily halve startup times with fonts that are
;; larger than the system default.
(setq frame-inhibit-implied-resize t)

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
 '(package-selected-packages '(queue helm-icons helm nyan-mode undo-tree all-the-icons-dired
                                     all-the-icons ace-window smartparens whole-line-or-region
                                     which-key gruvbox-theme cnfonts auto-package-update delight
                                     use-package-ensure-system-package use-package)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
