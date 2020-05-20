# dir
(let L (dir "/etc" T)
   (test "." (car L)) )

# info
(test '(T . @) (info "/etc"))
(test 2 (length (info "/etc/passwd")))
# XXX crash, deep bug
#(test T (fully num? (info "/etc/passwd")))

### date time ###
# XXX, time undef
#{
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
}#

(test (2000 7 15) (date 730622))
(test 730622 (date 2000 7 15))
(test 730622 (date (2000 7 15)))
(test NIL (date NIL))

# XXX, time undef
#{
(test (11 17 23) (time 40643))
(test 40643 (time 11 17 23))
(test 40643 (time (11 17 23)))
(test NIL (time NIL))
}#

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

# XXX, no locale yet
#{
(locale "DE" "de")
(test "01.06.2007" (datStr (date 2007 6 1)))
(test "01.06.07" (datStr (date 2007 6 1) T))
(locale)
}#

### strDat ###
(test 733134 (strDat "2007-06-01"))
(test NIL (strDat "01.06.2007"))

# XXX, no locale yet
#{
(locale "DE" "de")
(test 733134 (strDat "01.06.2007"))
(test 733134 (strDat "1.6.2007"))
(locale)
}#

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

# XXX, no locale yet
#{
(locale "DE" "de")
(test 733133 (expDat "31.5.7"))
(locale)
}#


### day ###
(test "Friday" (day (date 2007 6 1)))

# XXX, no locale yet
#{
(locale "DE" "de")
(test "Freitag" (day (date 2007 6 1)))
(test "Fr"
   (day (date 2007 6 1) '("Mo" "Tu" "We" "Th" "Fr" "Sa" "Su")) )
(locale)
}#

### week ###
(test 22 (week (date 2007 6 1)))



(msg 'system-OK)
