;;; UI Configuration

; Start maximised
(defun toggle-fullscreen ()
  (interactive)
  (x-send-client-message nil 0 nil "_NET_WM_STATE" 32
    '(2 "_NET_WM_STATE_MAXIMIZED_VERT" 0))
  (x-send-client-message nil 0 nil "_NET_WM_STATE" 32
    '(2 "_NET_WM_STATE_MAXIMIZED_HORZ" 0))
)
(toggle-fullscreen)

; Disable the toolbar
(custom-set-variables '(tool-bar-mode nil))

; Disable the splash screen
(setq inhibit-splash-screen t)

; Black background, white foreground
(when window-system
  (add-to-list 'default-frame-alist '(background-color . "black"))
  (add-to-list 'default-frame-alist '(foreground-color . "wheat")))


;;; General editing settings

; Save temporary and backup files in a different location to play well with git
(defvar user-temporary-file-directory
  "~/.emacs-backup/")
(make-directory user-temporary-file-directory t)
(setq backup-by-copying t)
(setq backup-directory-alist
  `(("." . ,user-temporary-file-directory)
  (,tramp-file-name-regexp nil)))
(setq auto-save-list-file-prefix
  (concat user-temporary-file-directory ".auto-saves-"))
(setq auto-save-file-name-transforms
  `((".*" ,user-temporary-file-directory t)))

; Insert spaces instead of tabs
(setq-default indent-tabs-mode nil)

; Tab-width
(setq-default tab-width 2)

; Line wrapping (auto fill) at 100 characters
(add-hook 'text-mode-hook 'turn-on-auto-fill)
(setq-default fill-column 100)

; Spell check as you type in text mode
(add-hook 'text-mode-hook 'turn-on-flyspell)

; Show line and column number in mode line
(line-number-mode 1)
(column-number-mode 1)

; Highlight trailing whitespace
(setq-default show-trailing-whitespace t)

; Draw tabs with the same color as trailing whitespace
(add-hook 'font-lock-mode-hook
  (lambda ()
    (font-lock-add-keywords
      nil
      '(("\t" 0 'trailing-whitespace prepend)))))

; Highlight long lines
(require 'whitespace)
(setq whitespace-line-column 100)
(setq whitespace-style '(face lines-tail))
(add-hook 'prog-mode-hook 'whitespace-mode)


;;; Language Settings

; C tab width
(setq-default c-basic-offset 2)

; C identing style and tab width
(setq c-default-style "linux" c-basic-offset 2)

; scons scripts
(setq auto-mode-alist
  (cons '("SConstruct" . python-mode) auto-mode-alist))
(setq auto-mode-alist
  (cons '("SConscript" . python-mode) auto-mode-alist))

; waf scripts
(setq auto-mode-alist
  (cons '("wscript" . python-mode) auto-mode-alist))

; bazel scripts
(setq auto-mode-alist
  (cons '("BUILD" . python-mode) auto-mode-alist))
(setq auto-mode-alist
  (cons '("*.bzl" . python-mode) auto-mode-alist))

; webppl
(add-to-list 'auto-mode-alist '("\\.wppl\\'" . js2-mode))

; cmake
(setq auto-mode-alist
  (append
    '(("CMakeLists\\.txt\\'" . cmake-mode))
    '(("\\.cmake\\'" . cmake-mode))
    auto-mode-alist))
(load-file "~/local/share/cmake-3.6/editors/emacs/cmake-mode.el")

; nova
(load-file "~/workspaces/nova/tools/emacs/nova-mode.el")
(load-file "~/workspaces/nova/tools/emacs/rlang-mode.el")
