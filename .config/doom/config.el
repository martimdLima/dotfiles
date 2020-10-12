;; FONTS
(setq doom-font (font-spec :family "Fira Mono Nerd Font" :size 15)
      doom-variable-pitch-font (font-spec :family "SauceCodePro Nerd Font" :size 15)
      doom-big-font (font-spec :family "SauceCodePro Nerd Font" :size 24)
)

(eval-after-load "org"
  '(require 'ox-gfm nil t))

;; SauceCodePro Nerd Font
	
;; THEMES
(setq doom-theme 'doom-solarized-dark)

;; ORG
(after! org
  (setq org-directory "~/Documents/org/")
  (setq org-agenda-files '("~/Documents/org/agenda.org"))
  ;;(setq org-log-done 'time)
  (setq org-log-done 'note)
  (setq org-todo-keywords '((sequence "TODO(t)" "PROJ(p)" "VIDEO(v)" "WAIT(w)" "|" "DONE(d)" "CANCELLED(c)" )))
;;  (require 'org-bullets)
;;  (add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))
)

;; NEO-TREE
(setq neo-window-fixed-size nil)

;; SPLITS
(defun prefer-horizontal-split ()
  (set-variable 'split-height-threshold nil t)
  (set-variable 'split-width-threshold 40 t)) ; make this as low as needed
(add-hook 'markdown-mode-hook 'prefer-horizontal-split)

;; FILE MANAGER
(map!
  (:after dired
    (:map dired-mode-map
     "C-x i" #'peep-dired
     )))
(evil-define-key 'normal peep-dired-mode-map (kbd "j") 'peep-dired-next-file
                                             (kbd "k") 'peep-dired-prev-file)
(add-hook 'peep-dired-hook 'evil-normalize-keymaps)


;; USER FOR GPG CONF
(setq user-full-name "Martim Lima"
      user-mail-address "martim.d.lima@protonmail.com")

;; LINE SETTINGS
(setq display-line-numbers-type t)
(global-set-key "\C-x\ t" 'toggle-truncate-lines)


