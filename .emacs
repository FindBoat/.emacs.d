            (add-hook 'before-save-hook 'gofmt-before-save)
            (setq tab-width 2)
            (setq indent-tabs-mode 1)))


;;--------------------SETTINGS FOR Jade & Stylus--------------------
(require 'sws-mode)
(require 'stylus-mode)
(require 'jade-mode)    
(add-to-list 'auto-mode-alist '("\\.styl$" . stylus-mode))
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
