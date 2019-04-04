(defun c:dump  nil (LM:dump (car (entsel))))

(defun c:dumpn ( / osm poi ss e)
  (setq osm (getvar 'osmode ))
  (setvar 'osmode 8) ;;force osmode to node
  (setq poi (getpoint "\nPick a node\n"))
  (setq ss (ssget poi)
	      e (list (ssname ss 0) p) )
  (setq objName (vlax-Ename->Vla-Object (car e)));; get object name objName
  (prompt "\nename: ")(princ e)(terpri)
  (LM:dump objName)
  (setvar 'osmode osm);; put it back
)

(defun c:dumpename ( / osm poi ss e)
	(setq e (car (entsel)) )
  (prompt "\nename: ")(princ e)(terpri)
  (princ)
)


(defun LM:dump ( obj )
    (cond
        ((or (= 'ename (type obj)) (and (listp obj) (= 'ename (type (setq obj (cdr (assoc -1 obj))))) ) )
            (vlax-dump-object (vlax-ename->vla-object obj) t)
        )
        ((= 'vla-object (type obj))
            (vlax-dump-object obj t)
        )
    )
    (princ)
)