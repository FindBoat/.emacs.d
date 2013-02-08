;;--------------------COLOR THEME--------------------
(add-to-list 'load-path
"~/.emacs.d/color-theme-6.6.0")
(require 'color-theme)
(color-theme-initialize)
;(color-theme-dark-laptop)
(set-face-foreground 'default "white")
;;(set-face-background 'default "#772953")
(set-face-background 'default "#000000")
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(font-lock-function-name-face ((((class color) (min-colors 88) (background dark)) (:foreground "Red" :weight bold))))
 '(font-lock-keyword-face ((((class color) (min-colors 88) (background dark)) (:foreground "#3399ff"))))
 '(font-lock-type-face ((((class color) (min-colors 88) (background dark)) (:foreground "#ccff00"))))
 '(font-lock-variable-name-face ((((class color) (min-colors 88) (background dark)) (:foreground "white"))))
 '(my-long-line-face ((((class color)) (:background "red"))) t)
 '(my-tab-face ((((class color)) (:background "green"))) t)
 '(my-trailing-space-face ((((class color)) (:background "green"))) t))

; default_font
(set-default-font "Comic Sans MS-11")
;(set-default-font "Courier 10 Pitch-11")

(setq tramp-default-method "ssh")

;;--------------------BASIC SETTINGS--------------------
;; Max 80 columns per line.

  (add-hook 'font-lock-mode-hook
            (function
             (lambda ()
               (setq font-lock-keywords
                     (append font-lock-keywords
                             '(("\t+" (0 'my-tab-face t))
                               ("^.\\{81,\\}$" (0 'my-long-line-face t))
                               ("[ \t]+$"      (0 'my-trailing-space-face t))))))))

;; Save all backup file in this directory.
(setq backup-directory-alist (quote ((".*" . "~/.emacs_backups/"))))

;;indent
(setq-default indent-tabs-mode nil)
(setq standard-indent 4)
(setq tab-width 4)

;;full screen
(defun fullscreen ()
      (interactive)
	        (set-frame-parameter nil 'fullscreen
			                           (if (frame-parameter nil 'fullscreen) nil 'fullboth)))

;window maximized
(defun my-maximized ()
  (interactive)
  (x-send-client-message
   nil 0 nil "_NET_WM_STATE" 32
   '(2 "_NET_WM_STATE_MAXIMIZED_HORZ" 0))
  (x-send-client-message
   nil 0 nil "_NET_WM_STATE" 32
   '(2 "_NET_WM_STATE_MAXIMIZED_VERT" 0))
)
;maxmize when start
;(my-maximized)
(fullscreen)

;;settings
;;(tool-bar-mode nil)
;;(menu-bar-mode -1)
;;(set-scroll-bar-mode nil)

;;close startup message
(setq inhibit-startup-message t)

;;parentheses settings
(show-paren-mode t)
(setq show-paren-style 'parentheses)

;;show row#
;;(global-linum-mode t)
;;change title format
(setq frame-title-format "Hang@%b")

;;copy outside
(setq x-select-enable-clipboard t)

;;return indent
(global-set-key "\C-m" 'newline-and-indent)
(global-set-key (kbd "C-<return>") 'newline)

;;Not auto save
(setq make-backup-files nil)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Fast Copy & Fast Del
(global-set-key (kbd "M-w") 'huangq-save-line-dwim)
;;;###autoload
(defun huangq-save-one-line (&optional arg)
  "save one line. If ARG, save one line from first non-white."
  (interactive "P")
  (save-excursion
    (if arg
        (progn
          (back-to-indentation)
          (kill-ring-save (point) (line-end-position)))
      (kill-ring-save (line-beginning-position) (line-end-position)))))
(setq standard-indent 4)
(setq tab-width 4)

;;full screen
(defun fullscreen ()
      (interactive)
	        (set-frame-parameter nil 'fullscreen
			                           (if (frame-parameter nil 'fullscreen) nil 'fullboth)))

;window maximized
;; (defun my-maximized ()
;;  (interactive)
;;  (x-send-client-message
;;   nil 0 nil "_NET_WM_STATE" 32
;;   '(2 "_NET_WM_STATE_MAXIMIZED_HORZ" 0))

;;;###autoload
(defun huangq-kill-ring-save (&optional n)
  "If region is active, copy region. Otherwise, copy line."
  (interactive "p")
  (if (and mark-active transient-mark-mode)
      (kill-ring-save (region-beginning) (region-end))
    (if (> n 0)
        (kill-ring-save (line-beginning-position) (line-end-position n))
      (kill-ring-save (line-beginning-position n) (line-end-position)))))

;;;###autoload
(defun huangq-save-line-dwim (&optional arg)
  "If region is active, copy region.
If ARG is nil, copy line from first non-white.
If ARG is numeric, copy ARG lines.
If ARG is non-numeric, copy line from beginning of the current line."
  (interactive "P")
  (if (and mark-active transient-mark-mode)
      ;; mark-active, save region
      (kill-ring-save (region-beginning) (region-end))
    (if arg
        (if (numberp arg)
            ;; numeric arg, save ARG lines
            (huangq-kill-ring-save arg)
          ;; other ARG, save current line
          (huangq-save-one-line))
      ;; no ARG, save current line from first non-white
      (huangq-save-one-line t))))

;;--------------------TEMPLATE--------------------
(setq load-path (cons (expand-file-name "~/.emacs.d/lisp")
                      load-path))
(require 'template)
(template-initialize)
(setq template-default-directories (cons "~/.emacs.d/templates/" template-default-directories))

;;--------------------SETTINGS FOR JDEE--------------------
(add-to-list 'load-path "~/.emacs.d/cedet-1.1/eieio")
(add-to-list 'load-path "~/.emacs.d/cedet-1.1/semantic")
(add-to-list 'load-path (expand-file-name "~/.emacs.d/jdee-2.4.0.1/lisp"))
(add-to-list 'load-path (expand-file-name "~/.emacs.d/cedet-1.1/common"))
(load-file (expand-file-name "~/.emacs.d/cedet-1.1/common/cedet.el"))
(add-to-list 'load-path (expand-file-name "~/.emacs.d/elib-1.0"))

;;Not loading JDE until open a java file
(setq defer-loading-jde t)
(if defer-loading-jde
    (progn
      (autoload 'jde-mode "jde" "JDE mode." t)
      (setq auto-mode-alist
	    (append
	     '(("\\.java\\'" . jde-mode))
	     auto-mode-alist)))
  (require 'jde))

;;auto fill using menu
;;set sourcepath
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(jde-complete-function (quote jde-complete-menu))
 '(jde-sourcepath (quote ("~/Documents/Java/TopCoder")))
 '(scroll-bar-mode nil)
 '(tool-bar-mode nil))

;;--------------------SETTINGS FOR C++--------------------
;;c mode default

(add-hook 'c-mode-common-hook ( lambda()
            ( c-set-style "bsd" )
            (setq c-basic-offset 4) ) )
;;c++ mode default
(add-hook 'c++-mode-common-hook ( lambda()
              ( c-set-style "bsd" )
              (setq c-basic-offset 4) ) )

;;auto complete
(require 'cedet)
(semantic-load-enable-code-helpers)
(global-set-key [(control tab)] 'semantic-ia-complete-symbol-menu)

;;---------------------------Settings for Octave------------------------
(setq auto-mode-alist
      (cons
       '("\\.m$" . octave-mode)
       auto-mode-alist))
(setq octave-block-offset 4)
