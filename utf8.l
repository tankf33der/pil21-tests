(let S 0
   (in "UTF-8-demo.txt"
      (while (char)
         (inc 'S (char @)) ) )
   (test S 20832567) )
(msg 'UTF8-OK)
