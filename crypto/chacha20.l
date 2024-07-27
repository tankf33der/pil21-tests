(seed (in "/dev/urandom" (rd 8)))
(de randL (N)
   (make (do N (link (rand 0 255)))) )
(de _set (Var Val)
   (co '_set
      (co Var T)
      (yield Val Var) ) )
(de _get (Var)
   (co '_get
      (co Var T)
      (yield NIL Var) ) )
(de start (Var)
   (co Var
      (yield)
      (let A 0
         (loop
            (if (num? (yield))
               (yield (setq A @))
               (yield A) ) ) ) ) )
(co "_plus"
   (yield)
   (loop
      (yield (+ (yield) (yield))) ) )
(de _plus (A B)
   (co '_plus
      (co '"_plus" T)
      (yield A "_plus")
      (yield B "_plus") ) )
(co "_minus"
   (yield)
   (loop
      (yield (- (yield) (yield))) ) )
(de _minus (A B)
   (co '_minus
      (co "_minus" T)
      (yield A "_minus")
      (yield B "_minus") ) )
(co "_mod32"
   (yield)
   (loop
      (yield (& (yield) `(hex "FFFFFFFF"))) ) )
(de _mod32 (N)
   (co '_mod32
      (co "_mod32" T)
      (yield N "_mod32") ) )
(co "_shift"
   (yield)
   (loop
      (yield (>> (yield) (yield))) ) )
(de _shift (C N)
   (co '_shift
      (co "_shift" T)
      (yield C "_shift")
      (yield N "_shift") ) )
(co "_or"
   (yield)
   (loop
      (yield (| (yield) (yield))) ) )
(de _or (A B)
   (co '_or
      (co "_or" T)
      (yield A "_or")
      (yield B "_or") ) )
(co "_xor"
   (yield)
   (loop
      (yield (x| (yield) (yield))) ) )
(de _xor (A B)
   (co '_xor
      (co "_xor" T)
      (yield A "_xor")
      (yield B "_xor") ) )
(co "_32"
   (yield)
   (loop (yield 32)) )
(co "_16"
   (yield)
   (loop (yield 16)) )
(co "_12"
   (yield)
   (loop (yield 12)) )
(co "_8"
   (yield)
   (loop (yield 8)) )
(co "_7"
   (yield)
   (loop (yield 7)) )
(de _rol32 (X C)
   (co '_rol32
      (start 'X)
      (start 'C)
      (_set 'X X)
      (_set 'C C)
      (prog1
         (_or
            (_mod32 (_shift (- (_get 'C)) (_get 'X)))
            (_shift (_minus (co "_32" T) (_get 'C)) (_get 'X)) )
         (co 'X)
         (co 'C) ) ) )
(de _quarter (A B C D)
   (co '_quarter
      (_set A (_mod32 (_plus (_get A) (_get B))))                   # a += b;
      (_set D (_rol32 (_xor  (_get D) (_get A)) (co "_16" T)))      # d = rotl32(d ^ a, 16);
      (_set C (_mod32 (_plus (_get C) (_get D))))                   # c += d;
      (_set B (_rol32 (_xor  (_get B) (_get C)) (co "_12" T)))      # b = rotl32(b ^ c, 12);
      (_set A (_mod32 (_plus (_get A) (_get B))))                   # a += b;
      (_set D (_rol32 (_xor  (_get D) (_get A)) (co "_8" T)))       # d = rotl32(d ^ a, 8);
      (_set C (_mod32 (_plus (_get C) (_get D))))                   # c += d;
      (_set B (_rol32 (_xor  (_get B) (_get C)) (co "_7" T))) ) )   # b = rotl32(b ^ c, 7);
(de chacha20_h (Key Data)
   (let
      (C (circ 0 8 16 24)
         Lst (conc (mapcar char '`(chop "expand 32-byte k")) Key Data)
         In
         (make
            (do 16
               (link
                  (apply
                     |
                     (mapcar >> (0 -8 -16 -24) (cut 4 'Lst)) ) ) ) ) )
      (co 'workit
         (for (I . N) In
            (let C (intern (pack 't (dec I)))
               (start C)
               (_set C N) ) )
         (do 10
            (_quarter 't0 't4 't8 't12)
            (_quarter 't1 't5 't9 't13)
            (_quarter 't2 't6 't10 't14)
            (_quarter 't3 't7 't11 't15)
            (_quarter 't0 't5 't10 't15)
            (_quarter 't1 't6 't11 't12)
            (_quarter 't2 't7 't8 't13)
            (_quarter 't3 't4 't9 't14) )
      (prog1
         (make
            (for N
               (make
                  (for I '(t0 t1 t2 t3 t12 t13 t14 t15)
                     (link (_get I)) ) )
               (do 4
                  (link (& (>> (pop 'C) N) 255)) ) ) )
         (for I 16
            (co (intern (pack 't (dec I)))) ) ) ) ) )
(test
   (23 91 25 239 23 223 133 162 86 90 166 239 136 98 205 220 217 62 240 104 187 99 233 25 243 209 76 21 248 89 40 56)
   (chacha20_h (range 1 32) (range 1 16)) )
(test
   (114 179 176 109 54 82 144 145 235 51 148 178 22 172 244 48 247 79 64 91 234 133 243 113 140 223 70 131 234 107 231 73)
   (chacha20_h (need 32 255) (need 16 255)) )
(in "vectors/chacha20.dat"
   (setq Lst (read))
   (while Lst
      (test (++ Lst) (chacha20_h (++ Lst) (++ Lst)) ) ) )
(msg 'chacha20-OK)
