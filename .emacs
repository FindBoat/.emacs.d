;;--------------------COLOR THEME--------------------

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; For emacs23
(add-to-list 'load-path "~/.emacs.d/color-theme-6.6.0")
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/")
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/replace-colorthemes-master")
(require 'color-theme)

;;(load-file "~/.emacs.d/monokai-theme.el")
;;(load-theme `whateveryouwant t)
;;(load-theme `andreas t)
(load-theme `scintilla t)
;;(custom-set-faces '(default ((t (:background "#1A1A1A")))))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(add-to-list 'load-path "~/.emacs.d/cedet-1.1/eieio")
(add-to-list 'load-path "~/.emacs.d/cedet-1.1/semantic")
(add-to-list 'load-path (expand-file-name "~/.emacs.d/jdee-2.4.0.1/lisp"))
(add-to-list 'load-path (expand-file-name "~/.emacs.d/cedet-1.1/common"))
(load-file (expand-file-name "~/.emacs.d/cedet-1.1/common/cedet.el"))
(add-to-list 'load-path (expand-file-name "~/.emacs.d/elib-1.0"))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; For emacs24

(require 'package)
(add-to-list 'package-archives
                 '("marmalade" .
                         "http://marmalade-repo.org/packages/"))
(package-initialize)

;; (load-file "~/.emacs.d/color-theme-molokai.el")
;; (color-theme-molokai)

;;;;;;;;;;;;;;;;;
;; Install
;; (progn
;;     (package-refresh-contents)
;;     (package-install 'monokai-theme))

;; (load-theme 'monokai t)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Format checking.
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(my-tab-face ((((class color)) (:background "green"))) t))
;; '(my-trailing-space-face ((((class color)) (:background "green"))) t))
;;'(my-long-line-face ((((class color)) (:background "red"))) t))

; default_font
;;(set-face-attribute 'default nil :family "Anonymous Pro" :height 115)
;;(set-default-font "monospace-10.8")

;(set-default-font "Courier 10 Pitch-11")

;;(set-default-font "Monaco-12")
(set-default-font "andale mono-12")
;;(set-default-font "Anonymous Pro-11.5:bold")
;;(set-default-font "Anonymous Pro-10.5")

(setq tramp-default-method "ssh")

;;--------------------BASIC SETTINGS--------------------
;; Yes or no question.
(fset 'yes-or-no-p 'y-or-n-p)

(global-set-key (kbd "C-x j") 'windmove-left)          ; move to left windnow
(global-set-key (kbd "C-x l") 'windmove-right)        ; move to right window

;; Max 80 columns per line.
(add-hook 'font-lock-mode-hook
           (function
            (lambda ()
              (setq font-lock-keywords
                    (append font-lock-keywords
                            '(("\t+" (0 'my-tab-face t))
                              ("^.\\{81,\\}$" (0 'my-long-line-face t))
("[ \t]+$"      (0 'my-tratrailing-space-face t))))))))

;; save all backup file in this directory.
(setq backup-directory-alist (quote ((".*" . "~/.emacs_backups/"))))

;;indent
(setq-default indent-tabs-mode nil)
(setq standard-indent 2)
(setq tab-width 2)

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
;;(fullscreen)

;;settings
;;(tool-bar-mode nil)
(menu-bar-mode -1)
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
 '(custom-safe-themes (quote ("39a854967792547c704cbff8ad4f97429f77dfcf7b3b4d2a62679ecd34b608da" "bb6b64bfb2f63efed8dea1ca03691c07c851a8be6f21675fe4909289d68975d9" "8d1baba3bbafc11628972b5b0a4453b5120be4fb8d30ad0ca4b35d114422dd65" "0ff3aeed353697992d100ddf8a94d065a58ffbde5a40afefa605f211757c8ab0" "8e997c790c6b22c091edb8a866f545857eaae227a0c41df402711f6ebc70326c" "98e5e942303b4f356d6573009c96087f9b872f2fa258c673188d913f6faf17ea" "9a3c51c59edfefd53e5de64c9da248c24b628d4e78cc808611abd15b3e58858f" "0f0adcd1352b15a622afd48fcff8232169aac4b5966841e506f815f81dac44ea" "09feeb867d1ca5c1a33050d857ad6a5d62ad888f4b9136ec42002d6cdf310235" "70b9e0d0b857d6497c6623bb360a3a7f915251c4a6233c30b65f9005eb9f4256" "cc2f32f5ee19cbd7c139fc821ec653804fcab5fcbf140723752156dc23cdb89f" "7a83132ecb08e86c63d3cbf4b677d4cb1bcfcfb47f4942f2b8ecc7f6ebc2004c" "9dc64d345811d74b5cd0dac92e5717e1016573417b23811b2c37bb985da41da2" "f831c1716ebc909abe3c851569a402782b01074e665a4c140e3e52214f7504a0" "6cf0e8d082a890e94e4423fc9e222beefdbacee6210602524b7c84d207a5dfb5" "68769179097d800e415631967544f8b2001dae07972939446e21438b1010748c" "471877df61bcd989ba4c0a5097654684fcfe918e124d46f811b533e44df34f53" default)))
 '(jde-complete-function (quote jde-complete-menu))
 '(jde-sourcepath (quote ("~/Documents/Java/TopCoder")))
 '(scroll-bar-mode nil)
 '(tool-bar-mode nil))

;;---------------------------Settings for Octave------------------------
(setq auto-mode-alist
      (cons
       '("\\.m$" . octave-mode)
       auto-mode-alist))
(setq octave-block-offset 4)


;;--------------------SETTINGS FOR C++--------------------
;;c mode default
(add-to-list 'load-path
"~/.emacs.d/")
(require 'google-c-style)

;; (add-hook 'c-mode-common-hook ( lambda()
;;             ( c-set-style "bsd" )
;;             (setq c-basic-offset 2)
;;             (c-set-offset 'access-label '--)
;;             (c-set-offset 'topmost-intro '--)
;;             (c-set-offset 'arglist-intro '+)
;;             (c-set-offset 'arglist-close 0)))
;; (add-hook 'c-mode-common-hook 'google-set-c-style)
;; (add-hook 'c-mode-common-hook 'google-make-newline-indent)

;; ;;c++ mode default
;; (add-hook 'c++-mode-common-hook ( lambda()
;;               ( c-set-style "bsd" )
;;               (setq c-basic-offset 2)
;;               (c-set-style "google"))
;;               ))
;; (add-hook 'c++-mode-common-hook 'google-set-c-style)
;; add-hook 'c++-mode-common-hook 'google-make-newline-indent)

;;auto complete
(require 'cedet)
(semantic-load-enable-code-helpers)
(global-set-key [(control tab)] 'semantic-ia-complete-symbol-menu)


;;--------------------SETTINGS FOR CoffeeScript--------------------
(require 'coffee-mode)
(custom-set-variables '(coffee-tab-width 2))

;;--------------------SETTINGS FOR Jade & Stylus--------------------
(require 'sws-mode)
(require 'jade-mode)    
(add-to-list 'auto-mode-alist '("\\.styl$" . sws-mode))
(add-to-list 'auto-mode-alist '("\\.jade$" . jade-mode))

;;--------------------SETTINGS FOR Less & CSS--------------------
(require 'less-css-mode)
(add-hook 'css-mode-hook 
      '(lambda() 
        (setq css-indent-offset 2) 
        (setq indent-tabs-mode nil))) 

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;Comment things below if working locally;;;;;;;;;;;;;;;;;;;;;;;

;; (add-to-list 'load-path "~/.emacs.d/google")

;; (defun my-c-mode-common-hook ()
;;  (c-set-style "google")
;;  (setq c-basic-offset 2))
;; ;;google sytle is defined in above function
;; (add-hook 'c-mode-common-hook 'my-c-mode-common-hook)
;; (add-hook 'c++-mode-common-hook 'my-c-mode-common-hook)


;; (require 'google)
