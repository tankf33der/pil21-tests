# dir
(let L (dir "/etc" T)
   (test "." (car L)) )

# info
(test '(T . @) (info "/etc"))
(test 2 (length (info "/etc/passwd")))
# XXX crash, deep bug
#(test T (fully num? (info "/etc/passwd")))

(msg 'system-OK)
