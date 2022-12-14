(de ggg @
   (rest) )
(de fff @
   (pass ggg (next)) )
(test (1 2 3) (fff 1 2 3))

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


### Evaluation ###
(test 2
   (when 1
      ('((N) N) (and 2))
      @ ) )

### alarm ###
(let N 6
   (alarm 1 (inc 'N))
   (test 6 N)
   (wait 2000)
   (test 7 N)
   (alarm 0) )


### sigio ###
(unless (member *OS '("SunOS" "OpenBSD" "Cygwin" "AIX" "HP-UX" "IRIX64"))
   (sigio (setq "SigSock" (port T 0 "SigPort"))
      (setq "SigVal" (udp "SigSock")) )
   (udp "localhost" "SigPort" '(a b c))
   (wait 200)
   (test '(a b c) "SigVal")
   (close "SigSock") )


### kids ###
(test
   (make
      (do 7
         (link (or (fork) (wait 2000) (bye))) ) )
   (flip (kids)) )

### protect ###
(test NIL (pipe (prog (kill *Pid) (pr 7)) (rd)))
(test 7 (pipe (protect (kill *Pid) (pr 7)) (rd)))


### quit ###
(test "Quit" (catch '("Quit") (quit "Quit")))


### byte ###
(test (18 18)
   (let A (adr (81064793292668929))  # cnt 1200000000000012
      (list (byte A) (byte (+ A 7))) ) )
(test "ABC"
   (let P (native "@" "malloc" 'N 8)
      (byte P (char "A"))
      (byte (inc P) (char "B"))
      (byte (+ P 2) (char "C"))
      (byte (+ P 3) 0)
      (prog1
         (native "@" "strdup" 'S P)
         (native "@" "free" NIL P) ) ) )

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

### sys ###
(test "PicoLisp" (sys "TEST" "PicoLisp"))
(test "PicoLisp" (sys "TEST"))


### args next arg rest ####
(test '(T 1 3 (2 3 4))
   (let foo '(@ (list (args) (next) (arg 2) (rest)))
      (foo 1 2 3 4) ) )

(test (7 NIL)
   ((quote @ (list (next) (next))) 7) )


### usec ###
(let U (usec)
   (wait 400)
   (test 4 (*/ (- (usec) U) 100000)) )


### pwd ###
(test
   (in '(pwd) (line T))
   (pwd) )


### cd ###
(chdir "/"
   (test "/" (pwd)) )


### file ###
(test (cons (tmp) "file" 1)
   (out (tmp "file") (println '(file)))
   (load (tmp "file")) )


### cmd ###
(setq *CMD (cmd))
(cmd "test")
(test "test" (cmd))


### argv ###
(test '("abc" "123")
   (pipe
      (call *CMD "-prog (println (argv)) (bye)" "abc" 123)
      (read) ) )
(test '("abc" "123")
   (pipe
      (call *CMD "-prog (argv A B) (println (list A B)) (bye)" "abc" 123)
      (read) ) )


### opt ###
(test '("abc" "123")
   (pipe
      (call *CMD "-prog (println (list (opt) (opt))) (bye)" "abc" 123)
      (read) ) )
(test "abc"
   (pipe
      (call *CMD "-de f () (println (opt))" "-f" "abc" "-bye")
      (read) ) )


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
