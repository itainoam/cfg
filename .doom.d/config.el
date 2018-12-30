(setq mac-command-modifier 'super)
(setq mac-option-modifier 'meta)
(setq auto-save-visited-mode t)
(set-frame-font "Source Code Pro 14" nil t)

(setq org-startup-indented t
          org-bullets-bullet-list '("› ")
          org-ellipsis "  ⌄  "
          org-pretty-entities t
          org-hide-emphasis-markers t
)

;; sets so documentation pops on the right side
(set-popup-rule! "^\\*info\\*$" :width 80 :side 'right)
(set-popup-rule! "^\\*[Hh]elp" :width 120 :side 'right :slot 3)
(set-popup-rule! "^\\*Man " :width 80 :side 'right)
(set-popup-rule! "^\\*Customize" :width 80 :side 'right)

'(org-level-1 ((t (:foreground "#444444" :weight bold :height 1.5))))
'(org-level-2 ((t (:foreground "#444444" :weight bold :height 1.35))))
'(org-level-3 ((t (:foreground "#444444" :weight bold :height 1.2))))

(add-hook 'text-mode-hook 'turn-on-visual-line-mode)
(add-hook 'org-mode-hook
          (lambda ()
            (set-window-margins nil 3) ;;requires setting org-mode to apply everytime
            (hl-line-mode -1)
            (setq smartparens-mode nil)
            (setq indicate-empty-lines nil)
            (setq line-spacing 0.5)))
