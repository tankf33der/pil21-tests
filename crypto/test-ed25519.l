(load "ed25519.l")
(let
   (S (range 1 32)
      P (publickey S)
      D (range 1 128)
      Sig (signature D S P) )
   (test
      T
      (checkvalid
         (signature D S P)
         D
         P ) ) )
(msg 'ed25519-OK)
