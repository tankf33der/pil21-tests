# Based on Rosetta Code
(de 2list @
   (let Prev NIL
      (let L
         (make
            (while (args)
               (setq Prev (chain (list (next) Prev))) ) )
         (cons L Prev) ) ) )
# Print the elements a doubly-linked list
(de 2print (DLst)
   (for (L (car DLst) L (cddr L))
      (printsp (car L)) )
   (prinl) )

# Print the elements a doubly-linked list in reverse order
(de 2printReversed (DLst)
   (for (L (cdr DLst) L (cadr L))
      (printsp (car L)) )
   (prinl) )

(setq *DLst (2list 'was 'it 'a 'cat 'I 'saw))
(2print *DLst)
(2printReversed *DLst)
#(println *DLst)


(msg 'double-OK)

