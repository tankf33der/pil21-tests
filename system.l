(prog1
   (mapcan '((N) (later (cons) (* N N))) (1 2 3 4))
      (wait NIL (full @)) )

# up
(test
   1
   (let N 1
      ((quote (N) (up N)) 2) ) )
(test
   (2 1 . 7)
   (let N 1 ((quote (N) (cons N (up N) (up N 7))) 2)) )

# copy-paste PicoLisp original code

# adr
(de adr1 (Lst)
   (adr Lst) )
(let (L1 (range 1 3)  L2 (range 1 3))
   (test T (not (= (adr L1) (adr L2))))
   (test (adr L1) (adr1 L1))
   (seek '((Lst) (test (adr Lst) (adr1 Lst))) L1) )

# dir
(let L (dir "/etc" T)
   (test
      T
      (bool (num? (index ".." L))) ) )

# info
(test '(T . @) (info "/etc"))
(test 2 (length (info "/etc/passwd")))
(test T (fully num? (info "/etc/passwd")))

### date time ###
(use (Dat1 Tim1 Dat2 Tim2 D1 T1 D2 T2)
   (until
      (=
         (setq Dat1 (date)  Tim1 (time T))
         (prog
            (setq
               Dat2 (date T)
               Tim2 (time T)
               D1 (in '(date "+%Y %m %d") (list (read) (read) (read)))
               T1 (in '(date "+%H %M %S") (list (read) (read) (read)))
               D2 (in '(date "-u" "+%Y %m %d") (list (read) (read) (read)))
               T2 (in '(date "-u" "+%H %M %S") (list (read) (read) (read))) )
            (time) ) ) )
   (test Tim1 (time T1))
   (test Tim1 (apply time T1))
   (test Tim2 (time T2))
   (test Dat1 (date D1))
   (test Dat1 (apply date D1))
   (test Dat2 (date D2)) )

(test (2000 7 15) (date 730622))
(test 730622 (date 2000 7 15))
(test 730622 (date (2000 7 15)))
(test NIL (date NIL))

(test (11 17 23) (time 40643))
(test 40643 (time 11 17 23))
(test 40643 (time (11 17 23)))
(test NIL (time NIL))

### dat$ ###
(test "20070601" (dat$ (date 2007 6 1)))
(test "2007-06-01" (dat$ (date 2007 6 1) "-"))


### $dat ###
(test 733134 ($dat "20070601"))
(test 733134 ($dat "2007-06-01" "-"))


### datSym ###
(test "01jun07" (datSym (date 2007 6 1)))


### datStr ###
(test "2007-06-01" (datStr (date 2007 6 1)))

(locale "DE" "de")
(test "01.06.2007" (datStr (date 2007 6 1)))
(test "01.06.07" (datStr (date 2007 6 1) T))
(locale)

### strDat ###
(test 733134 (strDat "2007-06-01"))
(test NIL (strDat "01.06.2007"))

(locale "DE" "de")
(test 733134 (strDat "01.06.2007"))
(test 733134 (strDat "1.6.2007"))
(locale)

### expDat ###
(test 733133 (date 2007 5 31))
(test 733133 (expDat "31057"))
(test 733133 (expDat "310507"))
(test 733133 (expDat "2007-05-31"))
(test 733133 (expDat "7-5-31"))

(let D (date)
   (test D (expDat "."))
   (test (inc D) (expDat "+1"))
   (test (dec D) (expDat "-1")) )

(locale "DE" "de")
(test 733133 (expDat "31.5.7"))
(locale)

### day ###
(test "Friday" (day (date 2007 6 1)))

(locale "DE" "de")
(test "Freitag" (day (date 2007 6 1)))
(test "Fr"
   (day (date 2007 6 1) '("Mo" "Tu" "We" "Th" "Fr" "Sa" "Su")) )
(locale)

### week ###
(test 22 (week (date 2007 6 1)))

### rc ###
(let F (tmp "rc")
   (rc F 'a 123)
   (rc F 'b "test"  'c (1 2 3))
   (test '((c 1 2 3) (b . "test") (a . 123))
      (in F (read)) )
   (test 123 (rc F 'a))
   (test "test" (rc F 'b))
   (test (1 2 3) (rc F 'c)) )

(msg 'system-OK)
