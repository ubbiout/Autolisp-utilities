(defun ltos ( lst / str )
    (setq str (car (ltos lst)))
    (foreach itm (cdr lst) (setq str (strcat str (ltos itm))))
    str
)

(defun elist ( entity / pth fil string dimpath prin1x princx data xdata )
    
    (setq pth (strcat (getvar "logfilepath") "elist.txt")
          fil (open pth "w") 
          string "Thing:\n" )
    
    (defun prin1x ( x i ) (repeat i (strcat string "  ")) (strcat string (ltos x)))
    (defun princx ( x i ) (repeat i (strcat string "  ")) (strcat string x))
    
    (cond
        (   (or
                (and
                    (eq 'ENAME (type entity))
                    (setq data (entget entity))
                )
                (and
                    (listp entity)
                    (setq data entity)
                    (setq entity (cdr (assoc -1 data)))
                )
            )
            (strcat string "\n\n  (\n")
            (foreach pair data
                (prin1x pair 2)
                (strcat string "\n")
            )
            (if (setq xdata (assoc -3 (entget entity '("*"))))
                (progn
                    (princx "(" 2)
                    (strcat string  (car xdata))
                    (strcat string "\n")
                    (foreach app (cdr xdata)
                        (princx "(" 3)
                        (strcat string "\n")
                        (foreach pair app (prin1x pair 4) (strcat string "\n"))
                        (princx ")" 3)
                        (strcat string "\n")
                    )
                    (princx ")" 2)
                    (strcat string "\n")
                )
            )
            (strcat string "  )")
            (if (= 1 (cdr (assoc 66 data)))
                (while
                    (progn
                        (elist (setq entity (entnext entity)))
                        (not (eq "SEQEND" (cdr (assoc 0 (entget entity)))))
                    )
                )
            )
        )
        (   (print entity)   )
    )
    (write-line string fil)
    (write-line "\n\nentity:\n" fil)
    (write-line entity fil)
    (close fil)
    (princ)
)
 
(defun c:eef  nil (elist (car (entsel))))
(defun c:eefx nil (elist (car (nentsel))))