# Based on group of Rosetta Code tasks (modified)
# http://rosettacode.org/wiki/Doubly-linked_list/Definition#PicoLisp
(de 2list @
   (let Prev NIL
      (let L
         (make
            (while (args)
               (setq Prev (chain (list (next) Prev))) ) )
         (cons L Prev) ) ) )
# Print the elements a doubly-linked list
(de 2print (DLst)
   (make
      (for (L (car DLst) L (cddr L))
         (link (car L)) ) ) )
# Print the elements a doubly-linked list in reverse order
(de 2printReversed (DLst)
   (make
      (for (L (cdr DLst) L (cadr L))
         (yoke (car L)) ) ) )
(de 2tail (X DLst)
   (let L (cdr DLst)
      (con DLst (cons X L NIL))
      (if L
         (con (cdr L) (cdr DLst))
         (set DLst (cdr DLst)) ) ) )
(de 2head (X DLst)
   (let L (car DLst)                  # Get current data list
      (set DLst (cons X NIL L))       # Prepend two new cons pairs
      (if L                           # Unless DLst was empty
         (set (cdr L) (car DLst))     # set new 'prev' link
         (con DLst (car DLst)) ) ) )  # otherwise set 'end' link
(let Lst (2list 1 2 3 4)
   (2head 0 Lst)
   (2tail 5 Lst)
   (test
      (2print Lst)
      (2printReversed Lst) ) )
(msg 'double-OK)
