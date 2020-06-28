(load "ed25519.l")
(de _r NIL
   (make
      (do 32
         (link (rand 0 32)) ) ) )
(let
   (S (_r)
      P (publickey S)
      Sig (signature P S P) )
   (test
      T
      (checkvalid
         (signature P S P)
         P
         P ) ) )
(msg 'ed25519-OK)
