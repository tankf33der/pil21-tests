# Based on group of Rosetta Code tasks
http://rosettacode.org/wiki/Doubly-linked_list/Definition#PicoLisp

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

(setq *DLst (2list 'was 'it 'a 'cat 'I 'saw))
(2head 'not *DLst)

(2print *DLst)
(2printReversed *DLst)

(msg 'double-OK)

