# Original PicoLisp test code
# copy-paste

### read ###
(test (1 2 3) (~(1 2) 3))
(test (1 3) (~(1 . 2) 3))
(test (1 2 3 4) (1 ~(2 3) 4))
(test (1 2 4) (1 ~(2 . 3) 4))
#(test (1 2 3) [1 2 3])
(test (1 2 3) (1 2 3]
(test (1 2 3) (1 2 3)]
(test (1 (2 3)) (1 (2 3]
(test (quote 1 (2 (3))) '(1 (2 (3]
#(test (quote 1 (2 (3))) '[1 (2 (3])
(test (1 abc (d e f))
   (pipe (prinl "(1 abc (d e f))")
      (read) ) )
# XXX, bug

# (test '(abc "=" def_ghi "(" ("x" "y" "z") "+" "-" 123 ")")
   # (pipe (prinl "abc = def_ghi(\"xyz\"+-123) # Comment")
      # (make
         # (while (read "_" "#")
            # (link @) ) ) ) )

### line ###
(test '("a" "b" "c")
   (pipe (prin "abc^J") (line)) )
(test "abc"
   (pipe (prin "abc") (line T)) )
(test '("abc" "def")
   (pipe (prin "abc^Jdef")
      (list (line T) (line T)) ) )
(test '("abc" "def")
   (pipe (prin "abc^Mdef")
      (list (line T) (line T)) ) )
(test '("abc" "def")
   (pipe (prin "abc^M^Jdef")
      (list (line T) (line T)) ) )
(test '("a" "bc" "def")
   (pipe (prin "abcdef")
      (line T 1 2 3) ) )


### any ###
(test '(a b c d) (any "(a b # Comment^Jc d)"))
(test "A String" (any "\"A String\""))


### sym ###
(test "(abc \"Hello\" 123)"
   (sym '(abc "Hello" 123)) )


### str ###
(test '(a (1 2) b)
   (str "a (1 2) b") )
(test '(a (1 2))
   (str "a (1 2) # b") )
(test "a \"Hello\" DEF"
   (str '(a "Hello" DEF)) )

### load ###
(test 6 (load "-* 1 2 3"))


### in out err ###
# XXX, call undef
# (out (tmp "file")
   # (println 123)
   # (println 'abc)
   # (println '(d e f)) )
# (in (tmp "file")
   # (test 123 (read))
   # (in (tmp "file")
      # (test 123 (read))
      # (test 'abc (in -1 (read))) )
   # (test '(d e f) (read)) )
#
# (let Err (tmp "err")
   # (test 1 (err Err (msg 1)))
   # (test 2 (err (pack "+" Err) (msg 2)))
   # (test "1^J2^J" (in Err (till NIL T))) )

### pipe ###
(test 123 (pipe (println 123) (read)))
(test "ABC DEF GHI"
   (pipe
      (out '(tr "[a-z]" "[A-Z]") (prinl "abc def ghi"))
      (line T) ) )

### prin prinl space print printsp println ###
# XXX, call undef
# (out (tmp "prin")
   # (prin 1)
   # (prinl 2)
   # (space)
   # (print 3)
   # (printsp 4)
   # (println 5) )
# (test (12 "^J" " " 34 5)
   # (in (tmp "prin")
      # (list (read) (char) (char) (read) (read)) ) )


(msg 'io-OK)