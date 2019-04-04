(defun c:sslook ( / selectionlength selection i)
  ;;highlight the pipe so user can see it
  (setq selection (ssget "_X" '((-4 . "<AND")(0 . "LWPOLYLINE")(8 . "TFS-FW-TXT")(-3 ("PE_URL"))(-4 . "AND>"))) ;;(102 . "{ACAD_REACTORS")
        selectionlength (sslength selection) )
  (repeat (setq i selectionlength)
    (redraw (ssname selection (setq i (- i 1))) 3 )
  )
  (alert "(-4 . \"<AND\")(0 . \"LWPOLYLINE\")(8 . \"TFS-FW-TXT\")(-3 (\"PE_URL\"))(-4 . \"AND>\")")
  ;;unhighlight the pipe
  (repeat (setq i selectionlength)
    (redraw (ssname selection (setq i (- i 1))) 4 )
  )
)