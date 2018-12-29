(setq mac-command-modifier 'super)
(setq mac-option-modifier 'meta)
(setq auto-save-visited-mode t)

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

(add-hook 'text-mode-hook 'turn-on-visual-line-mode)
(add-hook 'org-mode-hook
          (lambda ()
            (variable-pitch-mode 1)
            (hl-line-mode -1)
            (setq line-spacing 0.5)))
