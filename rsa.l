# http://rosettacode.org/wiki/RSA_code

(seed (time))

# Generate long random number
(de longRand (N)
   (use (R D)
      (while (=0 (setq R (abs (rand)))))
      (until (> R N)
         (unless (=0 (setq D (abs (rand))))
            (setq R (* R D)) ) )
      (% R N) ) )

# X power Y modulus N
(de **Mod (X Y N)
   (let M 1
      (loop
         (when (bit? 1 Y)
            (setq M (% (* M X) N)) )
         (T (=0 (setq Y (>> 1 Y)))
            M )
         (setq X (% (* X X) N)) ) ) )

# Probabilistic prime check
(de prime? (N)
   (and
      (> N 1)
      (bit? 1 N)
      (let (Q (dec N)  K 0)
         (until (bit? 1 Q)
            (setq
               Q  (>> 1 Q)
               K  (inc K) ) )
         (do 50
            (NIL (_prim? N Q K))
            T ) ) ) )

# (Knuth Vol.2, p.379)
(de _prim? (N Q K)
   (use (X J Y)
      (while (> 2 (setq X (longRand N))))
      (setq
         J 0
         Y (**Mod X Q N) )
      (loop
         (T
            (or
               (and (=0 J) (= 1 Y))
               (= Y (dec N)) )
            T )
         (T
            (or
               (and (> J 0) (= 1 Y))
               (<= K (inc 'J)) )
            NIL )
         (setq Y (% (* Y Y) N)) ) ) )

# Find a prime number with `Len' digits
(de prime (Len)
   (let P (longRand (** 10 (*/ Len 2 3)))
      (unless (bit? 1 P)
         (inc 'P) )
      (until (prime? P)  # P: Prime number of size 2/3 Len
         (inc 'P 2) )
      # R: Random number of size 1/3 Len
      (let (R (longRand (** 10 (/ Len 3)))  K (+ R (% (- P R) 3)))
         (when (bit? 1 K)
            (inc 'K 3) )
         (until (prime? (setq R (inc (* K P))))
            (inc 'K 6) )
         R ) ) )

# Generate RSA key
(de rsaKey (N)  #> (Encrypt . Decrypt)
   (let (P (prime (*/ N 5 10))  Q (prime (*/ N 6 10)))
      (cons
         (* P Q)
         (/
            (inc (* 2 (dec P) (dec Q)))
            3 ) ) ) )

# Encrypt a list of characters
(de encrypt (Key Lst)
   (let Siz (>> 1 (size Key))
      (make
         (while Lst
            (let N (char (pop 'Lst))
               (while (> Siz (size N))
                  (setq N (>> -16 N))
                  (inc 'N (char (pop 'Lst))) )
               (link (**Mod N 3 Key)) ) ) ) ) )

# Decrypt a list of numbers
(de decrypt (Keys Lst)
   (mapcan
      '((N)
         (let Res NIL
            (setq N (**Mod N (cdr Keys) (car Keys)))
            (until (=0 N)
               (push 'Res (char (& `(dec (** 2 16)) N)))
               (setq N (>> 16 N)) )
            Res ) )
      Lst ) )

# Generate 200-digit keys (private . public)
(setq Keys (rsaKey 200))
# Encrypt
(setq CryptText
   (encrypt (car Keys)
      (chop "The quick brown fox jumped over the lazy dog's back") ) )
# Decrypt
(test
   "The quick brown fox jumped over the lazy dog's back"
   (pack (decrypt Keys CryptText)) )

(msg 'rsa-OK)
