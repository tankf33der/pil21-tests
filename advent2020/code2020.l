--- Day 1: Report Repair ---
(setq Inp (in "data/01.txt" (till NIL T)))
(setq List (filter 'and (mapcar '((X) (format (pack X))) (split (chop Inp) "\n"))))
# 1a
(test
   319531
   (for I List
      (T
         (for J List
            (T (= 2020 (+ I J)) (* I J)) )
         @ ) ) )

# 1b
(test
   244300320
   (for I List
      (T
         (for J List
            (T
               (for K List
                  (T (= 2020 (+ I J K)) (* I J K)) )
               @ ) )
         @ ) ) )

--- Day 2: Password Philosophy ---
(setq Inp (in "data/02.txt" (till NIL T)))
(setq List (filter 'and (mapcar '((X) (pack X)) (split (chop Inp) "\n"))))

# 2a
(de parse (S)
  (let ((LowToHigh Letter Password) (split (chop S) " ")
        (Low High) (split LowToHigh "-"))
    (list (format (pack Low)) (format (pack High)) (car Letter) Password)))
(de check (L)
  (let ((Low High Letter Password) L
        Occurs (length (filter '((X) (= Letter X)) Password)))
    (and (>= Occurs Low) (<= Occurs High))))
(test
   506
   (length (filter 'and (mapcar '((S) (check (parse S))) List))) )

# 2b
(de check2 (L)
  (let ((P1 P2 Letter Password) L)
    (xor (= Letter (car (nth Password P1)))
         (= Letter (car (nth Password P2))))))
(test
   443
   (length (filter 'and (mapcar '((S) (check2 (parse S))) List))) )


--- Day 3: Toboggan Trajectory ---
(setq Inp (in "data/03.txt" (till NIL T)))
(setq List (filter 'and (mapcar '((X) (apply 'circ X)) (split (chop Inp) "\n"))))

# 3a
(de count-tree (Row+ Pos+)
  (let (Row 1 Pos 1 Trees 0)
    (while (car (nth List Row))
      (setq Line @)
      (when (= "#" (car (nth Line Pos))) (setq Trees (+ 1 Trees)))
      (setq Row (+ Row+ Row) Pos (+ Pos+ Pos)))
    Trees))
(test 193 (count-tree 1 3))

# 3b
(setq Results
  (make
    (for P '((1 . 1) (1 . 3) (1 . 5) (1 . 7) (2 . 1))
      (link (count-tree (car P) (cdr P))))))
(test 1355323200 (apply * Results))


# --- Day 4: Passport Processing ---
(setq Inp (in "data/04.txt" (till NIL T)))
(setq List (filter 'and (split (split (chop Inp) "\n") NIL)))
(de group-card (L)
  (filter 'and (split (mapcan '((X) (insert (inc (length X)) X " ")) L) " ")))
(de parse-pair (S)
  (let ((K V) (split S ":"))
    (cons (pack K) (pack V))))
(de parse4 (L)
  (mapcar 'parse-pair (group-card L)))
(setq List2 (mapcar 'parse4 List))

# 4a
(de valid? (Card)
  (or (= 8 (length Card))
      (and (= 7 (length Card)) (not (assoc "cid" Card)))))
(test 210 (length (filter 'valid? List2)))

# 4b
(de digit? (X) (member X '`(chop "0123456789")))
(de hexa? (X) (member X '`(chop "0123456789abcdef")))
(de meas? (X) (member X '`(chop "cmin")))
(de height-check (V)
  (let (S (chop V)
        N (pack (filter 'digit? S))
        D (format N)
        M (pack (filter 'meas? S)))
    (and (= V (pack N M))
         (cond
           ((= M "cm") (and (>= D 150) (<= D 193)))
           ((= M "in") (and (>= D 59) (<= D 76)))
           (T NIL)))))
(setq Rules '(
 ("byr" . ((X) (let N (format X) (and (>= N 1920) (<= N 2002)))))
 ("iyr" . ((X) (let N (format X) (and (>= N 2010) (<= N 2020)))))
 ("eyr" . ((X) (let N (format X) (and (>= N 2020) (<= N 2030)))))
 ("hgt" . height-check)
 ("hcl" . ((X) (let (S (chop X) D (cdr S))
                  (and (= "#" (car S))
                       (= 6 (length D))
                       (fully 'hexa? D)))))
 ("ecl" . ((X) (member X '("amb" "blu" "brn" "gry" "grn" "hzl" "oth"))))
 ("pid" . ((X) (let S (chop X)
                  (and (= 9 (length S))
                       (fully 'digit? S)))))
 ("cid" . ((X) T))
 ))
(de check4 (Pair)
  (let ((K . V) Pair
        Fn (cdr (assoc K Rules)))
    (if Fn (Fn V) NIL)))
(de valid2? (Card)
  (and (or (= 8 (length Card))
           (and (= 7 (length Card)) (not (assoc "cid" Card))))
       (fully 'check4 Card)))
(test 131 (length (filter 'valid2? List2)))

--- Day 5: Binary Boarding ---
(setq Inp (in "data/05.txt" (till NIL T)))
(setq List (filter 'and (split (chop Inp) "\n")))

(de parse5 (Pass)
  (let (Row (head 7 Pass)
        Col (tail 3 Pass)
        RG (range 0 127)
        CG (range 0 7))
    (for R Row
      (setq RG ((if (= R "F") 'head 'tail) (/ (length RG) 2) RG)))
    (for C Col
      (setq CG ((if (= C "L") 'head 'tail) (/ (length CG) 2) CG)))
    (list (car RG) (car CG) (+ (car CG) (* 8 (car RG))))))

(test '(70 7 567) (parse5 (chop "BFFFBBFRRR")))
(test '(14 7 119) (parse5 (chop "FFFBBBFRRR")))
(test '(102 4 820) (parse5 (chop "BBFFBBFRLL")))

(setq List2 (mapcar 'parse5 List))

# 5a
(test 890 (apply 'max (mapcar 'last List2)))

# 5b
(de check5 (S1 S2)
  (unless (= 1 (- S2 S1))
    (test 651 (dec S2))))
(let (Ids (sort (mapcar 'last List2))
      L1 (head (dec (length Ids)) Ids)
      L2 (tail (dec (length Ids)) Ids))
  (mapcar 'check5 L1 L2))

--- Day 6: Custom Customs ---
(setq Inp (in "data/06.txt" (till NIL T)))
(setq List (filter 'and (split (split (chop Inp) "\n") NIL)))

# 6a
(de anyone (G)
  (length (uniq (fish 'atom G))))
(test 6430 (apply + (mapcar 'anyone List)))

# 6b
(de everyone (G)
  (let (Len (length G)
        Grouped (by name group (fish 'atom G)))
    (length (filter '((L) (= Len (length L))) Grouped))))
(test 3125 (apply + (mapcar 'everyone List)))

--- Day 7: Handy Haversacks ---
(setq Inp (in "data/07.txt" (till NIL T)))
(setq List (filter 'and (split (chop Inp) "\n")))

# 7a
(de parse7 (Line)
  (filter '((X) (not (member X '("bag" "bags" "bag," "bags," "bag." "bags." "contain"))))
          (mapcar pack (split Line " "))))

(de to-data (Line)
  (make
    (link (pack (car Line)" " (cadr Line)))
    (let Cont (tail -2 Line)
      (while Cont
        (let Piece (cut 3 'Cont)
          (if (format (car Piece))
            (link (cons (pack (cadr Piece) " " (caddr Piece)) @))))))))

(test '("dark beige" ("posh lime" . 2) ("striped black" . 3))
      (to-data '("dark" "beige" "2" "posh" "lime" "3" "striped" "black")))
(test '("shiny indigo")
      (to-data '("shiny" "indigo" "no" "other")))

(setq List2 (mapcar 'to-data (mapcar 'parse7 List)))

(de content (Entry)
  (make
    (link (car Entry))
    (expand7 (cdr Entry) 1)))

(de expand7 (Bags N)
  (for B Bags
    (let ((Name . Count) B
          NewN (* Count N)
          SubBags (cdr (assoc Name List2)))
    (link (cons Name NewN))
    (expand7 SubBags NewN))))

(setq TestList '(("shiny gold" ("dull magenta" . 2)) ("dull magenta" ("drab purple" . 3)) ("drab purple")))
(test '("shiny gold" ("dull magenta" . 2) ("drab purple" . 6))
      (let List2 TestList (content (car TestList))))

(setq List3 (mapcar 'content List2))

(test 265 (length (filter '((X) (assoc "shiny gold" X)) List3)))

# 7b
(test 14177 (apply '+ (mapcar 'cdr (cdr (content (assoc "shiny gold" List2))))))

--- Day 8: Handheld Halting ---
(setq Inp (in "data/08.txt" (till NIL T)))
(setq List (filter 'and (split (chop Inp) "\n")))

# 8a
(de parse8 (List)
  (mapcar '((L) (let ((Op Val) (split L " "))
            (cons (pack Op) (format (pack Val)))))
          List))
(setq List2 (parse8 List))

(de upd-counters (Row)
  (setq Counters (place Row Counters 1)))

(de runit (Lst)
  (let (Row 1 Acc 0 Counters (need (length Lst) 0))
    (while (=0 (car (nth Counters Row)))
      (let ((Op . Val) (car (nth Lst Row)))
        #(prin "Row: " Row " ") (print Op Val) (prinl " " (car (nth Counters Row)))
        (case Op
          ("acc" (upd-counters Row) (setq Row (inc Row)) (setq Acc (+ Acc Val)))
          ("jmp" (upd-counters Row) (setq Row (+ Row Val)))
          (T     (upd-counters Row) (setq Row (inc Row))))))
    Acc
    # (when (> Row (length Lst)) (println "program terminated!") (quit))
))
(test 1797 (runit List2))

--- Day 9: Encoding Error ---
(setq Inp (in "data/09.txt" (till NIL T)))
(setq List (mapcar 'format (filter 'and (split (chop Inp) "\n"))))

# 9a
(setq Preamble (head 25 List))
(setq Numbers (tail -25 List))

(setq TestList (35 20 15 25 47 40 62 55 65 95 102 117 150 182 127 219 299 277 309 576))
(setq TestPreamble (head 5 TestList))
(setq TestNumbers (tail -5 TestList))

(de sums (Lst)
  (make
    (for (I . L) Lst Lst (pop 'Lst)
      (mapcar '((X) (link (+ L X))) Lst))))

(de check9 (Lst Pre)
  (for (I . L) Lst Lst (pop 'Lst)
    #(println L Pre (if (member L (sums Pre)) T NIL))
    # (NIL (member L (sums Pre)) (prinl "number: " L)
    (NIL (member L (sums Pre)) L)
    (setq Pre (remove 1 Pre))
    (setq Pre (append Pre (list L)))
    ))
(out "/dev/null" (test 127 (check9 TestNumbers TestPreamble)))
(setq Target (check9 Numbers Preamble))
(test 756008079 Target)

# 9b
(de scanit (Target Lst)
  (for I (range 2 (length Lst))
    (setq Res (maplist '((L) (list (apply '+ (head I L)) (head I L))) Lst))
    # (T (assoc Target Res) (let Set (cadr @) (prinl "value: "(+ (apply 'min Set) (apply 'max Set)))))
    (T (assoc Target Res) (let Set (cadr @) (+ (apply 'min Set) (apply 'max Set))))
  ))
(out "/dev/null" (test 62 (scanit 127 TestList)))
(test 93727241 (scanit Target List))


--- Day 10: Adapter Array ---
(setq Inp (in "data/10.txt" (till NIL T)))
(setq List (mapcar 'format (filter 'and (split (chop Inp) "\n"))))

# 10a
(setq TList1 (16 10 15 5 1 11 7 19 6 12 4))
(setq TList2 (28 33 18 42 31 14 46 20 48 47 24 23 49 45 19 38 39 11 1 32 25 35 8 17 7 9 4 2 34 10 3))

(de compute (List)
  (let (SList (sort (copy List))
        ExtList (insert 0 (insert (inc (length SList)) SList (+ 3 (last SList))) 0)
        Diffs (mapcar - (tail -1 ExtList) (head -1 ExtList))
        Jolts (by format group Diffs))
    (* (length (assoc 1 Jolts)) (length (assoc 3 Jolts)))))
(test 35 (compute TList1))
(test 220 (compute TList2))
(test 2482 (compute List))

# 10b
(de combine (List)
  (let (SList (sort (copy List))
        Sol '((0 . 1)))
    (for I SList
      (push 'Sol (cons I 0))
      (if (assoc (- I 1) Sol)
        (push 'Sol (cons I (+ (cdr (assoc I Sol)) (cdr (assoc (- I 1) Sol))))))
      (if (assoc (- I 2) Sol)
        (push 'Sol (cons I (+ (cdr (assoc I Sol)) (cdr (assoc (- I 2) Sol))))))
      (if (assoc (- I 3) Sol)
        (push 'Sol (cons I (+ (cdr (assoc I Sol)) (cdr (assoc (- I 3) Sol)))))))
    (assoc (last SList) Sol)))
(test 8 (cdr (combine TList1)))
(test 19208 (cdr (combine TList2)))
(test 96717311574016 (cdr (combine List)))



(msg '10-ok)
(bye)
