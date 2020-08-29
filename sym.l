# idx
(let (C 0  R)
   (for A (range -128 128)
      (for B (range -128 128)
         (let (X (cons A B)  K (cons (char (hash X)) X))
            (if (idx 'R K)
               (inc 'C)    # collision
               (idx 'R K T) ) ) ) )
   (test 0 C) )

# accu
(let Sum NIL
   (accu 'Sum 'a 1)
   (accu 'Sum 'a 5)
   (accu 'Sum 22 100)
   (test '((22 . 100) (a . 6)) Sum) )

# fifo, single
(let X NIL
   (fifo 'X 1)
   (fifo 'X 2)
   (fifo 'X 3)
   (test 1 (fifo 'X))
   (test 2 (fifo 'X))
   (test 3 (fifo 'X)) )

(de m1 (L)
   (set L 9) )
(de m2 ("L")
   (set (cdr (val "L")) 7) )
(let L (range 1 3)
   (m1 L)
   (test (9 2 3) L)
   (m2 'L)
   (test (9 7 3) L) )


# Original test code from PicoLisp
# copy-paste
#
### name ###
(test "abc" (name 'abc))
(test "A123" (name '{A123}))
(let X (box)
   (test NIL (name X))
   (name X "xxx")
   # XXX, name-bug
   #(test "xxx" (name X))
)

### sp? ###
(test T (sp? " ^I^J"))
(test NIL (sp? " abc"))
(test NIL (sp? 123))



### pat? ###
(test `(char '@) (char (pat? '@)))
(test NIL (pat? "ABC"))
(test NIL (pat? 123))



### fun? ###
(test 1000000000 (fun? 1000000000))
(test NIL (fun? 12345678901234567890))
(test '(A B) (fun? '((A B) (* A B))))
(test NIL (fun? '((A B) (* A B) . C)))
(test NIL (fun? (1 2 3 4)))
(test NIL (fun? '((A 2 B) (* A B))))
(test T (fun? '(NIL (* 3 4))))


### getd ###
(test car (getd 'car))
(test '((File . @) (load File))
   (getd 'script) )
(test NIL (getd 1))


### all ###
(test '(test)
   (filter '((S) (= S "test")) (all)) )


### symbols nsp ###
(when symbols
   (test T (bool (pair pico)))
   (test '(pico) (symbols 'myLib 'pico)) )

(when symbols
   (one Foo)
   (test 'pico (nsp 'symbols))
   (test 'myLib (nsp 'Foo))
   (test '(myLib pico) (symbols 'pico)) )

(when symbols
   (test 1 myLib~Foo)
   (test NIL (nsp 'myLib~Foo)) )

### intern ###
(test car (val (intern (pack "c" "a" "r"))))


### extern ###
(test NIL (extern (box)))
# XXX, undef
#(test *DB (extern "1"))


### box? ###
(let X (box)
   (test X (box? X)) )
(test NIL (box? 123))
(test NIL (box? 'a))
(test NIL (box? NIL))


### str? ###
(test NIL (str? 123))
(test NIL (str? '{A123}))
(test NIL (str? 'abc))
(test "abc" (str? "abc"))


# XXX, undef
#{
### ext? ###
(test *DB (ext? *DB))
(test NIL (ext? 'abc))
(test NIL (ext? "abc"))
(test NIL (ext? 123))

### touch ###
(test *DB (touch *DB))
(rollback)
}#

### zap ###
(test "abc" (str? (zap 'abc)))


### chop ###
(test '("c" "a" "r") (chop 'car))
(test '("H" "e" "l" "l" "o") (chop "Hello"))
(test '("1" "2" "3") (chop 123))
(test (1 2 3) (chop (1 2 3)))
(test NIL (chop NIL))


### pack ###
(test "car is 1 symbol name"
   (pack 'car " is " 1 '(" symbol " name)) )


### glue ###
# XXX, glue-bug
#(test 1 (glue NIL 1))
(test "a" (glue NIL '(a)))
(test "ab" (glue NIL '(a b)))
(test "a,b" (glue "," '(a b)))
(test "a8b" (glue 8 '(a b)))
(test "a123b123c" (glue (1 2 3) '(a b c)))



### text ###
(test "abc XYZ def 123" (text "abc @1 def @2" 'XYZ 123))
(test "aXYZz" (text "a@3z" 1 2 '(X Y Z)))
(test "a@bc.de" (text "a@@bc.@1" "de"))
(test "10.11.12" (text "@A.@B.@C" 1 2 3 4 5 6 7 8 9 10 11 12))
(test "1 2 3 4 5 6 7 8 9 10 11 12"
   (text "@1 @2 @3 @4 @5 @6 @7 @8 @9 @A @B @C" 1 2 3 4 5 6 7 8 9 10 11 12) )


### pre? ###
(test "abcdefg" (pre? "" "abcdefg"))
(test NIL (pre? "abc" ""))
(test "abcdefg" (pre? "abc" "abcdefg"))
(test NIL (pre? "def" "abcdefg"))
(test "abcdefg" (pre? "" "abcdefg"))
(test "7fach" (pre? (+ 3 4) "7fach"))



### sub? ###
(test "abcdefg" (sub? "" "abcdefg"))
(test NIL (sub? "abc" ""))
(test "abcdefg" (sub? "cde" "abcdefg"))
(test "abcdefg" (sub? "def" "abcdefg"))
(test NIL (sub? "abb" "abcdefg"))
(test "abcdefg" (sub? "" "abcdefg"))


### val ###
(let L '(a b c)
   (test '(a b c) (val 'L))
   (test 'b (val (cdr L))) )



### set ###
(use L
   (test '(a b c) (set 'L '(a b c)))
   (test 999 (set (cdr L) 999))
   (test '(a 999 c) L) )


### setq ###
(use (A B)
   (test (123 123)
      (setq  A 123  B (list A A)) )
   (test 123 A)
   (test (123 123) B) )


### swap ###
(let (A 1  L (1 2 3))
   (test 1 (swap 'A 7))
   (test 7 (swap 'A 'xyz))
   (test 3 (swap (cddr L) A))
   (test (1 2 xyz) L) )


### xchg ###
(let (A 1  B 2  C '(a b c))
   (test 2 (xchg 'A C  'B (cdr C)))
   (test 'a A)
   (test 'b B)
   (test (1 2 c) C) )


### on off onOff zero one ###
(use (A B)
   (test T (on A B))
   (test T A)
   (test T B)
   (test NIL (off A))
   (test NIL A)
   (test NIL (onOff B))
   (test NIL B)
   (test T (onOff A B))
   (test T A)
   (test T B)
   (test 0 (zero A B))
   (test 0 A)
   (test 0 B)
   (test 1 (one A B))
   (test 1 A)
   (test 1 B) )


### default ###
(let (A NIL  B NIL)
   (test 2 (default A 1  B 2))
   (test A 1)
   (test B 2)
   (test 2 (default A 7  B 8))
   (test A 1)
   (test B 2) )


### push push1 pop ++ cut ###
(let L NIL
   (test 1 (push 'L 4 3 2 1))
   (test L (1 2 3 4))
   (test 0 (push1 'L 0))
   (test 1 (push1 'L 1))
   (test L (0 1 2 3 4))
   (test 0 (pop 'L))
   (test 1 (++ L))
   (test (2 3) (cut 2 'L))
   (test (4) L) )


### push1q ###
(let L NIL
   (test (2) (push1q 'L 'a (1) 'b (2)))
   (test (1) (push1q 'L 'b (1)))
   (test '((1) (2) b (1) a) L) )


### del ###
# XXX, new undef
# lets comment all
(let (L '((a b c) (d e f))  S (new))
   (put S 'lst L)
   (test '((a b c)) (del '(d e f) 'L))
   (test '(a b c) (del 'x L))
   (test '(a c) (del 'b L))
   (with S
      (test '((a b c)) (del '(d e f) (:: lst)))
      (test NIL (del '(a b c) (:: lst)))
      (test NIL (: lst)) ) )
(let L (1 1 2 3 1 2 3)
   (test (2 3 2 3) (del 1 'L T)) )

### queue ###
(let A NIL
   (test 1 (queue 'A 1))
   (test 2 (queue 'A 2))
   (test 3 (queue 'A 3))
   (test (1 2 3) A) )


### fifo ###
(let X NIL
   (test 1 (fifo 'X 1))
   (test 3 (fifo 'X 2 3))
   (test 1 (fifo 'X))
   (test 2 (fifo 'X))
   (test 3 (fifo 'X)) )

### idx lup ###
(let X NIL
   (test NIL (idx 'X 'd T))
   (test NIL (idx 'X (2 . f) T))
   (test NIL (idx 'X (3 . g) T))
   (test NIL (idx 'X '(a b c) T))
   (test NIL (idx 'X 17 T))
   (test NIL (idx 'X 'A T))
   (test '(d . @) (idx 'X 'd T))
   (test NIL (idx 'X T T))
   (test '(A) (idx 'X 'A))
   (test '(17 A d (2 . f) (3 . g) (a b c) T)
      (idx 'X) )
   (test (2 . f) (lup X 2))
   (test '((2 . f) (3 . g)) (lup X 1 4))
   (test '(17 . @) (idx 'X 17 NIL))
   (test '(A d (2 . f) (3 . g) (a b c) T)
      (idx 'X) )
   (off X)
   (for N '((4 . D) 3 (2 . B) Y (3 . C) Z (6 . F) 7 (7 . G) X (1 . A) T (5 . E) 5)
      (idx 'X N T) )
   (test '(3 5 7 X Y Z (1 . A) (2 . B) (3 . C) (4 . D) (5 . E) (6 . F) (7 . G) T)
      (idx 'X) )
   (test '((3 . C) (4 . D) (5 . E))
      (lup X 3 5) )
   (test '((1 . A) (2 . B) (3 . C) (4 . D) (5 . E) (6 . F) (7 . G))
         (lup X 0 9) ) )

# XXX
# [sym.l:405] !? (set *DB (1 2 3 4))
# {1} -- Protected symbol
# ?
#{
(set *DB (1 2 3 4))
(put *DB 'a 1)
(put *DB 'b 2)
(test (1 2 3 4) (val *DB))
(test '((2 . b) (1 . a)) (getl *DB))
(wipe *DB)
(test (1 2 3 4) (val *DB))
(test '((2 . b) (1 . a)) (getl *DB))
(rollback)
(test NIL "W")
(test NIL (getl '"W"))
}#

(msg 'sym-OK)
