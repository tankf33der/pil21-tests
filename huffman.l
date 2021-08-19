(de prio (Idx)
   (while (cadr Idx) (setq Idx @))
   (car Idx) )
(test
   '("n" (0 0 0) "m" (0 1 0 0) "o" (1 1 0 0) "s" (0 0 1 0)
      "c" (0 1 0 1 0) "d" (1 1 0 1 0) "g" (0 0 1 1 0)
      "l" (1 0 1 1 0) "p" (0 1 1 1 0) "r" (1 1 1 1 0)
      "t" (0 0 0 0 1) "u" (1 0 0 0 1) "a" (1 0 0 1)
      " " (1 0 1) "e" (0 0 1 1) "f" (1 0 1 1)
      "i" (0 1 1 1) "x" (0 1 1 1 1) "h" (1 1 1 1 1) )
   (let (A NIL  P NIL  L NIL)
      (for C (chop "this is an example for huffman encoding")
         (accu 'A C 1) )                  # Count characters
      (for X A                            # Build index tree as priority queue
         (idx 'P (cons (cdr X) (car X)) T) )
      (while (or (cadr P) (cddr P))       # Remove entries, insert as nodes
         (let (A (car (idx 'P (prio P) NIL))  B (car (idx 'P (prio P) NIL)))
            (idx 'P (cons (+ (car A) (car B)) A B) T) ) )
      (setq P (car P))
      (make
         (recur (P L)
            (if (atom (cdr P))
               (link (cdr P) L)
               (recurse (cadr P) (cons 0 L))
               (recurse (cddr P) (cons 1 L)) ) ) ) ) )
(msg 'huffman-OK)
