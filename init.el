(setq inhibit-startup-message t)
(tool-bar-mode -1)

(require 'package)
(setq package-enable-at-startup nil)

(add-to-list 'package-archives
	     '("melpa" . "https://melpa.org/packages/"))

(package-initialize)
;; bootstrap "use-package"
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(use-package try
	     :ensure t)
(use-package which-key
	     :ensure t
	     :config
	     (which-key-mode))



;;=======================================================================

(use-package org-bullets
  :ensure t
  :config
  (add-hook 'org-mode-hook (lambda ()(org-bullets-mode 1))))

;;;===========================
;;buffers
;(setq ido-enable-flex-matching t)
;(setq ido-everywhere t)
;(ido-mode 1)

;;(defalias 'list-buffers 'ibuffer) ; make ibuffer default
(defalias 'list-buffers 'ibuffer-other-window) ; make ibuffer default

;; (use-package tabbar
;;   :ensure t
;;   :config (tabbar-mode 1)
;; )
;;===================================
;;windows
;;
;
;;key	what it does
;;C-x 2	split-window-below (vertically)
;;C-x 3	split-window-right (horizontally)
;;C-x 0	delete-window (this one)
;;C-x 1	delete-other-windows
;;C-x o	other-window (moves foxus to the next window;
(windmove-default-keybindings)
;;S-arrow -> <-
; add this to init.el
(use-package ace-window
  :ensure t
  :init
  (progn
    (global-set-key [remap other-window] 'ace-window)
    (custom-set-faces
     '(aw-leading-char-face
       ((t (:inherit ace-jump-face-foreground :height 3.0))))) 
    ))
;;
(winner-mode 1)
;;Which will allow you to use C-c left or right to move through past window configurations 
;;
					;=================================================
;;search swiper

(use-package counsel
  :ensure t
  )

(use-package swiper
  :ensure try
  :config
  (progn
    (ivy-mode 1)
    (setq ivy-use-virtual-buffers t)
    (global-set-key "\C-s" 'swiper)
    (global-set-key (kbd "C-c C-r") 'ivy-resume)
    (global-set-key (kbd "<f6>") 'ivy-resume)
    (global-set-key (kbd "M-x") 'counsel-M-x)
    (global-set-key (kbd "C-x C-f") 'counsel-find-file)
    (global-set-key (kbd "<f1> f") 'counsel-describe-function)
    (global-set-key (kbd "<f1> v") 'counsel-describe-variable)
    (global-set-key (kbd "<f1> l") 'counsel-load-library)
    (global-set-key (kbd "<f2> i") 'counsel-info-lookup-symbol)
    (global-set-key (kbd "<f2> u") 'counsel-unicode-char)
    (global-set-key (kbd "C-c g") 'counsel-git)
    (global-set-key (kbd "C-c j") 'counsel-git-grep)
    (global-set-key (kbd "C-c k") 'counsel-ag)
    (global-set-key (kbd "C-x l") 'counsel-locate)
    (global-set-key (kbd "C-S-o") 'counsel-rhythmbox)
    (define-key read-expression-map (kbd "C-r") 'counsel-expression-history)
    ))
;; using swiper so ido no longer needed
;;(setq ido-enable-flex-matching t)
;;(setq ido-everywhere t)
;;(ido-mode 1)
;;;===================================
(use-package avy
  :ensure t
  :bind ("M-s" . avy-goto-char))

;;You can check the avy home page for their recommended configuration which you get by configuring this way instead:

(use-package avy
:ensure t
:init (avy-setup-default)
:config (progn
;; Makes it easier to see the candidates
(setq avy-background t)
;; Shows both the candidates over the text
(setq avy-styles-alist '((avy-goto-char-2 . at-full))))
:bind (;; Search by 2 chars
("C-'" . avy-goto-char-2)
;; Search by first char of a word
("C-\"" . avy-goto-word-1)))
;(use-package avy
;:ensure t
;:bind (("H-a" . avy-goto-word-1)
;("M-g M-g" . avy-goto-line)
;("M-g g" . avy-goto-line)
;("H-A" . avy-goto-char))
;:config (setq avy-all-windows nil))

;;=====================================
;;;;complete with auto-complete
;; (use-package auto-complete
;;   :ensure t
;;   :init
;;   (progn
;;     (ac-config-default)
;;     (global-auto-complete-mode t)
;;     ))

;;;;=====================================
;;;themes
(use-package zenburn-theme
  :ensure t
  :config (load-theme 'zenburn t))
;;;==============================================
;; use org manage config

;;(org-babel-load-file (expand-file-name "~/.emacs.d/myinit.org"))

;; add this about yes y no n
(fset 'yes-or-no-p 'y-or-n-p)
(global-set-key (kbd "<f5>") 'revert-buffer)
;;===============================

;;;;===============================
;;for pyhton
(use-package python
  :ensure t
  :mode ("\\.py" . python-mode)
  :config
  (use-package elpy
    :ensure t
    :commands elpy-enable
    :config
    (setq elpy-rpc-python-command "python3"
	  elpy-modules (dolist (elem '(elpy-module-highlight-indentation
				       elpy-module-yasnippet))
			 (remove elem elpy-modules)))
    (elpy-use-ipython))
  (elpy-enable)
  (require 'smartparens-python)
  (add-hook 'python-mode-hook #'smartparens-strict-mode))
(use-package flycheck
  :ensure t
  :init
  (global-flycheck-mode -1))
;; (use-package epc
;;   :ensure t)
;; (use-package jedi
;;   :ensure t
;;   :init
;;   (add-hook 'python-mode-hook 'jedi:setup)
;;   (add-hook 'python-mode-hook 'jedi:ac-setup))

;;===============================
;;yasnippet
(use-package yasnippet
  :ensure t
  :init
    (yas-global-mode 1))
;;=================================
(defvar myPackages
  '(better-defaults
    ein ;; add the ein package (Emacs ipython notebook)
    py-autopep8))
(setq ein:use-auto-complete t)
;; Or, to enable "superpack" (a little bit hacky improvements):
;; (setq ein:use-auto-complete-superpack t)


;;;===========================
;;pairs
(use-package smartparens
  :ensure t
  :commands (smartparens-mode
	     smartparens-strict-mode)
  :bind (:map smartparens-strict-mode-map
	      ("C-}" . sp-forward-slurp-sexp)
	      ("M-s" . sp-backward-unwrap-sexp)
	      ("C-c [" . sp-select-next-thing)
	      ("C-c ]" . sp-select-next-thing-exchange))
  :config
  (require 'smartparens-config))

(use-package smart-mode-line
  :ensure t
  :init
  (setq-default sml/vc-mode-show-backend t
	;;	sml/theme 'respectful
		sm/name-with 30)
  (sml/setup)
  :config
  (add-to-list 'sml/replacer-regexp-list '("^~/workspace/" ":WS:") t))
;;========================
(use-package company               
  :ensure t
  :defer t
  :init (global-company-mode -1)
  :config
  (progn
    ;; Use Company for completion
    (bind-key [remap completion-at-point] #'company-complete company-mode-map)

    (setq company-tooltip-align-annotations t
          ;; Easy navigation to candidates with M-<n>
          company-show-numbers t)
    (setq company-dabbrev-downcase nil))
  :diminish company-mode)


(use-package company-quickhelp          ; Documentation popups for Company
  :ensure t
  :defer t
  :init (add-hook 'global-company-mode-hook #'company-quickhelp-mode))

(use-package company-go
  :ensure t
  :defer t
  :init
  (with-eval-after-load 'company
    (add-to-list 'company-backends 'company-go)))


;;=====last=====================
;;;;;;;;;;;;;;;;lisp-mode
;; (use-package lisp-mode
;;   :config
;;   (use-package elisp-slime-nav
;;     :ensure t
;;     :commands elisp-slime-nav-mode)
;;   (use-package macrostep
;;     :ensure t
;;     :bind ("C-c e" . macrostep-expand))

;;   (use-package slime
;;     :ensure t
;;     :commands (slime slime-lisp-mode-hook)
;;     :config
;;     (add-to-list 'slime-contribs 'slime-fancy)

;;     (slime-setup)
;;     (add-hook 'slime-repl-mode-hook #'smartparens-strict-mode))

;;   (add-hook 'emacs-lisp-mode-hook #'smartparens-strict-mode)
;;   (add-hook 'emacs-lisp-mode-hook #'turn-on-eldoc-mode)
;;   (add-hook 'emacs-lisp-mode-hook #'elisp-slime-nav-mode)
;;   (add-hook 'ielm-mode-hook #'elisp-slime-nav-mode)
;;   (add-hook 'ielm-mode-hook #'turn-on-eldoc-mode)
;;   (add-hook 'lisp-interaction-mode-hook #'turn-on-eldoc-mode)

;;   (add-hook 'lisp-mode-hook #'smartparens-strict-mode)
;;   (add-hook 'lisp-mode-hook #'slime-lisp-mode-hook)

;;   (setq inferior-lisp-program "sbcl --dynamic-space-size 1024"))


;;=========================================
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("c74e83f8aa4c78a121b52146eadb792c9facc5b1f02c917e3dbb454fca931223" default)))
 '(package-selected-packages
   (quote
    (neotree haskell-mode smart-mode-line elpy smartparens ein zenburn-theme auto-complete counsel ace-window tabbar which-key try use-package))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(aw-leading-char-face ((t (:inherit ace-jump-face-foreground :height 3.0)))))
;;==============================test ========================
 ;;;;;;;;;;;;;;;;;;;;;;;company;;;;;;;;;;;;;;;;;;  
  (add-hook 'after-init-hook #'global-company-mode)
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;flycheck;;;;;;;;;;;;;;;;  
  ;;(add-hook 'after-init-hook #'global-flycheck-mode)  
  ;;;;;;;;;;;;;;;;;;;emacs-ycmd;;;;;;;;;;;;;;;;;;;  
  (require 'ycmd)  
  (add-hook 'after-init-hook #'global-ycmd-mode)  
  ;;(ycmd-force-semantic-completion t)  
  ;; (ycmd-global-config nil)
  (set-variable 'ycmd-server-command '("python" "/home/lixu/ycmd/ycmd"))
;;(set-variable 'ycmd-global-config "/home/lixu/ycmd/.ycm_extra_conf.py.1")  
  (require 'company-ycmd)  
  (company-ycmd-setup)  
  (require 'flycheck-ycmd)  
  (flycheck-ycmd-setup) 
  
