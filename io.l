(let S 0
   (in "test-.txt"
      (from ":")
      (do 2
         (read) )
      (inc 'S (read))
      (char)
      (char)
      (inc 'S (read))
      (test 579 S) ) )
(in "test-.txt"
   (do 3 (from ":"))
   (test 456 (read)) )
(test
   ":."
   (pipe (in "test-.txt" (echo 2)) (line T)) )
(test
   "89"
   (pipe (in "test-.txt" (line) (echo 1 2)) (line T)) )


# Original PicoLisp test code
# copy-paste

### read ###
(test (1 2 3) (~(1 2) 3))
(test (1 3) (~(1 . 2) 3))
(test (1 2 3 4) (1 ~(2 3) 4))
(test (1 2 4) (1 ~(2 . 3) 4))
(test (1 2 3) [1 2 3])
(test (1 2 3) (1 2 3]
(test (1 2 3) (1 2 3)]
(test (1 (2 3)) (1 (2 3]
(test (quote 1 (2 (3))) '(1 (2 (3]
(test (quote 1 (2 (3))) '[1 (2 (3])
(test (1 abc (d e f))
   (pipe (prinl "(1 abc (d e f))")
      (read) ) )
(test '(abc "=" def_ghi "(" ("x" "y" "z") "+" "-" 123 ")")
   (pipe (prinl "abc = def_ghi(\"xyz\"+-123) # Comment")
      (make
         (while (read "_" "#")
            (link @) ) ) ) )

### skip ###
(test "a"
   (pipe (prinl "# Comment^Ja")
      (skip "#") ) )
(test "#"
   (pipe (prinl "# Comment^Ja")
      (skip) ) )


### eof ###
(test T (pipe NIL (eof)))
(test NIL (pipe (prin "a") (eof)))
(test T (pipe (prin "a") (eof T) (eof)))


### from till ###
(test "cd"
   (pipe (prin "ab.cd:ef")
      (from ".")
      (till ":" T) ) )


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
(out (tmp "file")
   (println 123)
   (println 'abc)
   (println '(d e f)) )
(in (tmp "file")
   (test 123 (read))
   (in (tmp "file")
      (test 123 (read))
      (test 'abc (in -1 (read))) )
   (test '(d e f) (read)) )
(let Err (tmp "err")
   (test 1 (err Err (msg 1)))
   (test 2 (err (pack "+" Err) (msg 2)))
   (test "1^J2^J" (in Err (till NIL T))) )

### pipe ###
(test 123 (pipe (println 123) (read)))
(test "ABC DEF GHI"
   (pipe
      (out '(tr "[a-z]" "[A-Z]") (prinl "abc def ghi"))
      (line T) ) )

### echo ###
(out (tmp "echo")
   (in (tmp "file")
      (echo) ) )
(in (tmp "echo")
   (test 123 (read))
   (test 'abc (read))
   (test '(d e f) (read)) )
(let F (tmp "file")
   (test "12"
      (pipe (in F (echo 2))
         (line T) ) )
   (test "23"
      (pipe (in F (echo 1 2))
         (line T) ) ) )


### prin prinl space print printsp println ###
(out (tmp "prin")
   (prin 1)
   (prinl 2)
   (space)
   (print 3)
   (printsp 4)
   (println 5) )
(test (12 "^J" " " 34 5)
   (in (tmp "prin")
      (list (read) (char) (char) (read) (read)) ) )

(msg 'io-OK)
