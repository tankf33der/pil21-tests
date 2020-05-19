# dir
(let L (dir "/etc" T)
   (test "." (car L)) )

(msg 'system-OK)
