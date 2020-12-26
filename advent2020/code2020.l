
(prin "2020:")

--- Day 1: Report Repair ---
(prin ".")(flush)
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
(prin ".")(flush)
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
(prin ".")(flush)
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
(prin ".")(flush)
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
(prin ".")(flush)
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
(prin ".")(flush)
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
(prin ".")(flush)
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
(prin ".")(flush)
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
(prin ".")(flush)
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
(prin ".")(flush)
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

--- Day 11: Seating System ---
(prin ".")(flush)
(setq Inp (in "data/11.txt" (till NIL)))
(setq List (filter 'and (split Inp "\n")))

# 11a
(setq Demo (filter 'and (split (in "data/demo11.txt" (till)) "\n")))
(de seat-round (Lst)
  (make
    (for (I . R) Lst
      (link (make
        (for (J . C) R
          (let Cnt 0
            # same line
            (when (= (car (nth R (- J 1))) "#") (setq Cnt (inc Cnt)))
            (when (= (car (nth R (+ J 1))) "#") (setq Cnt (inc Cnt)))
            # above
            (when (= (car (nth (car (nth Lst (- I 1))) (- J 1))) "#") (setq Cnt (inc Cnt)))
            (when (= (car (nth (car (nth Lst (- I 1))) (+ J 1))) "#") (setq Cnt (inc Cnt)))
            (when (= (car (nth (car (nth Lst (- I 1))) J)) "#") (setq Cnt (inc Cnt)))
            # below
            (when (= (car (nth (car (nth Lst (+ I 1))) (- J 1))) "#") (setq Cnt (inc Cnt)))
            (when (= (car (nth (car (nth Lst (+ I 1))) (+ J 1))) "#") (setq Cnt (inc Cnt)))
            (when (= (car (nth (car (nth Lst (+ I 1))) J)) "#") (setq Cnt (inc Cnt)))
            # check
            #(println I J C)
            (cond
              ((and (= C "L") (= Cnt 0)) (link "#"))
              ((and (= C "#") (> Cnt 3)) (link "L"))
              (T (link C))))))))))

(de print-seats (Lst)
  (for R Lst
    (for C R
      (prin C))
    (prinl)))
(de compare-seats (OldLst NewLst)
  (= (fish 'atom OldLst) (fish 'atom NewLst)))
(de count-seats (Lst)
  (length (filter '((C) (= C "#")) (fish 'atom Lst))))
(de loop-seats (Lst)
  (let (OldLst Lst
        NewLst (seat-round OldLst))
    (until (compare-seats OldLst NewLst)
      (setq OldLst NewLst)
      (setq NewLst (seat-round OldLst)))
    NewLst))
(test 37 (count-seats (loop-seats Demo)))

# 11b
(de diag+ (Lst I J)
  (let (NI (length Lst)
        NJ (length (car Lst)))
    (by 'cadr 'sort
      (uniq (make
        (let (SI I SJ J)
          (while (and (<= SJ NJ) (> SI 0))
            (link (list SI SJ (car (nth (car (nth Lst SI)) SJ))))
            (setq SI (dec SI) SJ (inc SJ))))
        (let (SI I SJ J)
          (while (and (> SJ 0) (<= SI NI))
            (link (list SI SJ (car (nth (car (nth Lst SI)) SJ))))
            (setq SI (inc SI) SJ (dec SJ))))
        )))))
(de diag- (Lst I J)
  (let (NI (length Lst)
        NJ (length (car Lst)))
    (by 'cadr 'sort
      (uniq (make
        (let (SI I SJ J)
          (while (and (<= SJ NJ) (<= SI NI))
            (link (list SI SJ (car (nth (car (nth Lst SI)) SJ))))
            (setq SI (inc SI) SJ (inc SJ))))
        (let (SI I SJ J)
          (while (and (> SJ 0) (> SI 0))
            (link (list SI SJ (car (nth (car (nth Lst SI)) SJ))))
            (setq SI (dec SI) SJ (dec SJ))))
        )))))
(de seat-round-2 (Lst)
  (make
    (for (I . R) Lst
      (link (make
        (for (J . C) R
          (let (Cnt 0
                Vert  (mapcar '((X) (car (nth X J))) Lst)
                Diag+ (filter '((X) (not (= (caddr X) "."))) (diag+ Lst I J))
                Diag- (filter '((X) (not (= (caddr X) "."))) (diag- Lst I J)))
            # same line
            (when (= "#" (last (filter '((X) (not (= X "."))) (head (- J 1) R)))) (setq Cnt (inc Cnt)))
            (when (= "#" (car  (filter '((X) (not (= X "."))) (tail (- J)   R)))) (setq Cnt (inc Cnt)))
            # diag
            (when (= "#" (last (mapcar 'caddr (filter '((X) (< (cadr X) J)) Diag+)))) (setq Cnt (inc Cnt)))
            (when (= "#" (car  (mapcar 'caddr (filter '((X) (> (cadr X) J)) Diag+)))) (setq Cnt (inc Cnt)))
            (when (= "#" (last (mapcar 'caddr (filter '((X) (< (cadr X) J)) Diag-)))) (setq Cnt (inc Cnt)))
            (when (= "#" (car  (mapcar 'caddr (filter '((X) (> (cadr X) J)) Diag-)))) (setq Cnt (inc Cnt)))
            # vert
            (when (= "#" (last (filter '((X) (not (= X "."))) (head (- I 1) Vert)))) (setq Cnt (inc Cnt)))
            (when (= "#" (car  (filter '((X) (not (= X "."))) (tail (- I)   Vert)))) (setq Cnt (inc Cnt)))
            # check
            #(println I J C)
            (cond
              ((and (= C "L") (= Cnt 0)) (link "#"))
              ((and (= C "#") (> Cnt 4)) (link "L"))
              (T (link C))))))))))
(de loop-seats-2 (Lst)
  (let (OldLst Lst
        NewLst (seat-round-2 OldLst))
    (until (compare-seats OldLst NewLst)
      (setq OldLst NewLst)
      (setq NewLst (seat-round-2 OldLst)))
    NewLst))
(test 26 (count-seats (loop-seats-2 Demo)))

--- Day 12: Rain Risk ---
(prin ".")(flush)
(setq Inp (in "data/12.txt" (till NIL)))
(setq List (mapcar '((X) (cons (car X) (format (pack (cdr X))))) (filter 'and (split Inp "\n"))))

(setq Demo '(("F" . 10) ("N" . 3) ("F" . 7) ("R" . 90) ("F" . 11)))

# 12a
(setq Ship '("E" 0 0))

(de turn (A V)
  (let ((D X Y) Ship
        Rose '("N" "E" "S" "W" .)
        Val (/ V 90)
        Dir (if (= A "L") '- '+)
        Idx (index D Rose)
        N (Dir (+ Idx 4) Val)
        NewD (car (nth Rose N)))
    (setq Ship (list NewD X Y))))

(de move12 (V)
  (let ((D X Y) Ship)
    (case D
      ("N" (setq Ship (list D X (+ Y V))))
      ("S" (setq Ship (list D X (- Y V))))
      ("E" (setq Ship (list D (+ X V) Y)))
      ("W" (setq Ship (list D (- X V) Y))))))

(de act (Action)
  (let ((A . V) Action
        (D X Y) Ship)
    (case A
      ("N" (setq Ship (list D X (+ Y V))))
      ("S" (setq Ship (list D X (- Y V))))
      ("E" (setq Ship (list D (+ X V) Y)))
      ("W" (setq Ship (list D (- X V) Y)))
      ("L" (turn A V))
      ("R" (turn A V))
      ("F" (move12 V)))))

(de manhattan ()
  (let ((D X Y) Ship)
    (+ (abs X) (abs Y))))

(setq Ship '("E" 0 0))
(mapcar 'act Demo)
(test 25 (manhattan))

(setq Ship '("E" 0 0))
(mapcar 'act List)
(test 636  (manhattan))

# 12b
(setq Ship '("E" 0 0))
(setq Way '(10 1))

(de rotate12 (A V)
  (let ((XW YW) Way)
    (case V
      (90  (setq Way (if (= A "R") (list YW (- XW)) (list (- YW) XW))))
      (180 (setq Way (list (- XW) (- YW))))
      (270 (setq Way (if (= A "L") (list YW (- XW)) (list (- YW) XW)))))))

(de act2 (Action)
  (let ((A . V) Action
        (D X Y) Ship
        (XW YW) Way)
    (case A
      ("N" (setq Way (list XW (+ YW V))))
      ("S" (setq Way (list XW (- YW V))))
      ("E" (setq Way (list (+ XW V) YW)))
      ("W" (setq Way (list (- XW V) YW)))
      ("L" (rotate12 A V))
      ("R" (rotate12 A V))
      ("F" (setq Ship (list D (+ X (* V XW)) (+ Y (* V YW))))))))

(setq Ship '("E" 0 0))
(setq Way '(10 1))
(mapcar 'act2 Demo)
(test 286 (manhattan))

(setq Ship '("E" 0 0))
(setq Way '(10 1))
(mapcar 'act2 List)
(test 26841 (manhattan))

--- Day 13: Shuttle Search ---
(prin ".")(flush)
(setq Inp (in "data/13.txt" (till NIL)))
(setq All (filter 'and (split Inp "\n")))

(setq Timestamp (format (pack (car All))))
(setq Buses (filter 'and (mapcar 'format (split (last All) ","))))

(setq DemoTimestamp 939)
(setq DemoBuses (7 13 59 31 19))

# 13a
(de departures (Ts Buses)
  (let f '((B) (if (=0 (% Ts B))
                 Ts
                 (+ B (* B (/ Ts B)))))
    (mapcar 'f Buses)))

(de result (Ts Buses)
  (let (Deps (departures Ts Buses)
        Mins (mapcar '((D) (- D Ts)) Deps)
        Zip (mapcar 'cons Buses Mins)
        Bus (car (by cdr sort Zip)))
    (* (car Bus) (cdr Bus))))

(test 295 (result DemoTimestamp DemoBuses))
(test 3966 (result Timestamp Buses))

# 13b
(setq Buses2 (mapcar 'format (split (last All) ",")))
(setq Offsets (range 0 (length Buses2)))
(setq Pairs (filter 'car (mapcar 'cons Buses2 Offsets)))

(setq DemoPairs1 '((17 . 0) (13 . 2) (19 . 3)))
(setq DemoPairs2 '((67 . 0) (7 . 1) (59 . 2) (61 . 3)))

# brute-force... endless!
(de compute-raw (Pairs)
  (let (f '((P) (=0 (% (+ Ts (cdr P)) (car P))))
        Max (last (by car sort (copy Pairs)))
        Inc (car Max)
        Ts (- (cdr Max)))
    (loop
      (setq Ts (+ Ts Inc))
      (T (fully 'f Pairs))
      (when (=0 (% Ts 10000000)) (prinl Ts)))
    Ts))

# using chinese reminder is fast
# pairs are (m_i . -off_i)
# Timestamp≡-off_i(mod m_i)
(de compute13 (Pairs)
  (let (Sorted (by car sort (copy Pairs))
        M (apply * (mapcar car Sorted))
        Zs (mapcar '((X) (/ M (car X))) Sorted)
         f '((Z P)
            (let (N 0 X (% Z (car P)))
              (loop
                (setq N (inc N))
                (T (= 1 (% (* X N) (car P))) (* N Z)))))
        Ws (mapcar 'f Zs Sorted)
        Cs (mapcar '((W P) (* W (- (cdr P)))) Ws Sorted)
        Sum (apply + Cs))
    (+ M (% Sum M))))
(test 3417 (compute13 DemoPairs1))
(test 754018 (compute13 DemoPairs2))
(test 800177252346225 (compute13 Pairs))

--- Day 14: Docking Data ---
(prin ".")(flush)
(setq Inp (in "data/14.txt" (till NIL)))
(setq All (mapcar 'str (mapcar 'pack (filter 'and (split Inp "\n")))))

(setq Blocks '())

# 14a
(de to-mem (Idx Num Mask)
  (let (N (chop Num)
        M (chop Mask)
        f '((CN CM) (if (= "X" CM) CN CM))
        R (pack (mapcar f N M)))
    (push 'Mem (cons Idx R))))

(setq Mem '())
(for S All
  (cond
    ((match '(mask = @Mask) S)
      (setq Mask (name (car @Mask))))
    ((match '(mem (@Idx) = @Num) S)
      (to-mem (car @Idx) (pad 36 (bin (car @Num))) Mask))))
(setq Set '())
(for M Mem
  (unless (assoc (car M) Set) (push 'Set M)))
(test
   10050490168421
   (apply + (mapcar '((Pair) (let ((Idx . Num) Pair) (bin Num))) Set)))

--- Day 15: Rambunctious Recitation ---
(prin ".")(flush)
(setq Inp (0 5 4 1 10 14 7))
# 15a
(de turn15 ()
  (let Idx (index Next Spoken)
    (push 'Spoken Next)
    (if Idx
      (setq Next Idx)
      (setq Next 0))))

(de game15 (Input N)
  (let (Spoken (flip (copy Input))
        Next 0)
    (for I (- N (length Spoken))
      #(prinl I)
      (turn15))
    (car Spoken)))

(test 436 (game15 (0 3 6) 2020))
(test 1836 (game15 (3 1 2) 2020))
(test 203 (game15 Inp 2020))

# 15b
(class +BTree)
(dm put> (K V)
  (del> This K)
  (idx (:: D) (cons K V) T))
(dm del> (K)
  (if (lup (: D) K)
    (idx (:: D) @ NIL)))
(dm get> (K)
  (cdr (lup (: D) K)))
(dm size> ()
  (length (idx (:: D))))
(dm bal> ()
  (balance (:: D) (idx (:: D))))

# reimplement using binary tree for speed
(de turn15b (I)
  (let Val (get> Spoken Next)
    (put> Spoken Next I)
    (if Val
      (setq Next (- I Val))
      (setq Next 0))))

(de game15b (Input N)
  (let (Spoken (new +BTree)
        Last (last Input)
        I (length Input)
        Next 0)
    (mapcar '((X Y) (put> Spoken X Y)) Input (range 1 (length Input)))
    (while (< I (dec N))
      (setq I (inc I))
      (when (=0 (% I 500000))
        (bal> Spoken))
      #(prinl I)
      (turn15b I))
    Next))
(test 436 (game15b (0 3 6) 2020))
(test 1836 (game15b (3 1 2) 2020))

--- Day 16: Ticket Translation ---
(prin ".")(flush)
(de parse-rule (Str)
  (let ((I1 _ I2) (str Str)
        (@I11 @I12) (mapcar format (split (chop (name I1)) "-"))
        (@I21 @I22) (mapcar format (split (chop (name I2)) "-")))
    (fill '((X) (or (and (>= X @I11) (<= X @I12)) (and (>= X @I21) (<= X @I22)))))))

(setq Inp (in "data/16.txt" (till NIL)))
(setq Blocks (split (split Inp "\n") NIL))
(setq Rules (mapcar '((X) (split X ":")) (car Blocks)))
(setq Rules (mapcar '((X) (mapcar '((Y) (pack Y)) X)) Rules))
(setq Rules (mapcar '((X) (list (car X) (parse-rule (cadr X)))) Rules))
(setq MyTicket (mapcar format (split (cadr (cadr Blocks)) ",")))
(setq NearbyTickets (mapcar '((X) (mapcar format (split X ","))) (tail -1 (caddr Blocks))))

(setq DemoInp (in "data/demo16-1.txt" (till NIL)))
(setq DemoBlocks (split (split DemoInp "\n") NIL))
(setq DemoRules (mapcar '((X) (split X ":")) (car DemoBlocks)))
(setq DemoRules (mapcar '((X) (mapcar '((Y) (pack Y)) X)) DemoRules))
(setq DemoRules (mapcar '((X) (list (car X) (parse-rule (cadr X)))) DemoRules))
(setq DemoMyTicket (mapcar format (split (cadr (cadr DemoBlocks)) ",")))
(setq DemoNearbyTickets (mapcar '((X) (mapcar format (split X ","))) (tail -1 (caddr DemoBlocks))))

(setq Demo2Inp (in "data/demo16-2.txt" (till NIL)))
(setq Demo2Blocks (split (split Demo2Inp "\n") NIL))
(setq Demo2Rules (mapcar '((X) (split X ":")) (car Demo2Blocks)))
(setq Demo2Rules (mapcar '((X) (mapcar '((Y) (pack Y)) X)) Demo2Rules))
(setq Demo2Rules (mapcar '((X) (list (car X) (parse-rule (cadr X)))) Demo2Rules))
(setq Demo2MyTicket (mapcar format (split (cadr (cadr Demo2Blocks)) ",")))
(setq Demo2NearbyTickets (mapcar '((X) (mapcar format (split X ","))) (tail -1 (caddr Demo2Blocks))))

# 16a
(de check-values (Rules Tickets)
  (let Checks (mapcar cadr Rules)
    (mapcar '((Ticket) (check-ticket Ticket Checks)) Tickets)))

(de check-ticket (Ticket Checks)
  (mapcar '((Val) (if (filter =T (mapcar '((Fn) (Fn Val)) Checks)) T Val)) Ticket))

(de error-rate (Rules Tickets)
  (apply + (fish 'num? (check-values Rules Tickets))))

(test 71 (error-rate DemoRules DemoNearbyTickets))
(test 23009 (error-rate Rules NearbyTickets))

# 16b
(de remove-wrong-tickets (Rules Tickets)
  (let (Filter (mapcar '((X) (not (filter num? X))) (check-values Rules Tickets)))
    (filter '((X F) F) Tickets Filter)))

(setq ValidNearbyTickets (remove-wrong-tickets Rules NearbyTickets))

(de find-fields (Rules ValidTickets)
  (let Checks (mapcar cadr Rules)
    (make
      (for I (length (car ValidTickets))
        (link (cons I (check-field (mapcar '((X) (car (nth X I))) ValidTickets) Checks)))))))

(de check-field (Field Checks)
  (mapcar '((Fn) (if (filter not (mapcar '((Val) (Fn Val)) Field)) NIL T)) Checks))

(de order-fields (Rules ValidTickets)
  (let (Map (find-fields Rules ValidTickets)
        Sorted (by '((X) (length (filter =T (cdr X)))) sort Map))
    (make
      (while Sorted
        (let L (pop 'Sorted)
          (link L)
          (setq Sorted (mapcar '((X) (cons (car X) (mapcar 'xor (cdr L) (cdr X)))) Sorted)))))))

(de field-names (Rules ValidTickets)
  (let Map (order-fields Rules ValidTickets)
    (make
      (for L Map
        (link (cons (caar (nth Rules (index T (cdr L)))) (car L)))))))

(test '(("row" . 1) ("class" . 2) ("seat" . 3)) (field-names Demo2Rules Demo2NearbyTickets))

(de solve-pt2 (Shortlist Ticket)
  (let Fields (mapcar cdr (filter '((X) (pre? "departure" (car X))) Shortlist))
    (apply * (mapcar '((X) (car (nth Ticket X))) Fields))))

(test
   10458887314153
   (solve-pt2 (field-names Rules ValidNearbyTickets) MyTicket))


--- Day 17: Conway Cubes ---
(prin ".")(flush)
(setq Inp (in "data/17.txt" (till NIL)))
(setq Blocks (filter 'and (split Inp "\n")))

(setq DemoInp (in "data/demo17.txt" (till NIL)))
(setq DemoBlocks (filter 'and (split DemoInp "\n")))

(class +BTree17)
(dm put> (K V)
  (del> This K)
  (idx (:: D) (cons K V) T))
(dm del> (K)
  (if (lup (: D) K)
    (idx (:: D) @ NIL)))
(dm get> (K)
  (cdr (lup (: D) K)))
(dm size> ()
  (length (list> This)))
(dm bal> ()
  (balance (:: D) (list> This)))
(dm list> ()
  (idx (:: D)))

# 17a
(de prepare-matrix (Blocks)
  (let Matrix (new '(+BTree17))
    (for (I . Row) Blocks
      (for (J . C) Row
        (put> Matrix (list I J 0) (if (= C "#") T NIL))))
    Matrix))

(de render (Matrix)
  (let (Cells (list> Matrix)
        Xs (sort (uniq (mapcar caar Cells)))
        Ys (sort (uniq (mapcar cadar Cells)))
        Zs (sort (uniq (mapcar caddar Cells))))
    (for Z Zs
      (prinl)
      (prinl "Z = " Z)
      (for X Xs
        (for Y Ys
          (prin (if (get> Matrix (list X Y Z)) "#" ".")))
        (prinl)))))

(setq Matrix (prepare-matrix Blocks))
(setq DemoMatrix (prepare-matrix DemoBlocks))

(de neighbors (Cell Matrix)
  (let ((X Y Z) (car Cell))
    (make
      (for I (range (dec X) (inc X))
        (for J (range (dec Y) (inc Y))
          (for K (range (dec Z) (inc Z))
            (let Location (list I J K)
              (when (or (<> I X) (<> J Y) (<> K Z))
                (link (cons Location (get> Matrix Location)))))))))))

(de grow (Matrix)
  (let (Cells (list> Matrix)
        Neighbors (mapcar '((C) (neighbors C Matrix)) Cells))
    (for CNs Neighbors
      (for CN CNs
        (put> Matrix (car CN) (cdr CN))))))

(de cycle17 (Cell Neighbors Matrix)
  (let ((Location . Active) Cell
        ActiveNeighbors (length (filter '((X) (=T (cdr X))) Neighbors)))
    (cond
      ((and Active (or (< ActiveNeighbors 2) (> ActiveNeighbors 3))) (put> Matrix Location NIL))
      ((and (not Active) (= ActiveNeighbors 3)) (put> Matrix Location T)))))

(de cycle-all (Matrix)
  (grow Matrix)
  (let (Cells (list> Matrix)
        Neighbors (mapcar '((Cell) (neighbors Cell Matrix)) Cells))
    (mapcar '((Cell Neighs) (cycle17 Cell Neighs Matrix)) Cells Neighbors))
  Matrix)

(de mcycle (Matrix N)
  (for I N
    (cycle-all Matrix)))

(de count-active (Matrix)
  (length (filter '((X) (=T (cdr X))) (list> Matrix))))

(test 112 (count-active (mcycle DemoMatrix 6)))
(test 202 (count-active (mcycle Matrix 6)))

--- Day 18: Operation Order ---
(prin ".")(flush)
(setq Inp (in "data/18.txt" (till NIL)))
(setq Blocks (filter 'and (split Inp "\n")))
(setq Expressions (mapcar '((X) (str (pack X))) Blocks))

(setq Ex1 '(1 + 2 * 3 + 4 * 5 + 6))
(setq Ex2 '(1 + (2 * 3) + (4 * (5 + 6))))
(setq Ex3 '(2 * 3 + (4 * 5)))
(setq Ex4 '(5 + (8 * 3 + 9 + 3 * 4 * 3)))
(setq Ex5 '(5 * 9 * (7 * 3 * 3 + 9 * 3 + (8 + 6 * 4))))
(setq Ex6 '(((2 + 4 * 9) * (6 + 9 * 8 + 6) + 6) + 2 + 4 * 2))

# 18a
(de process1 (Expr)
  (while (> (length Expr) 1)
    (let (Val1 (pop 'Expr)
          Oper (pop 'Expr)
          Val2 (pop 'Expr))
      (if (and (num? Val1) (num? Val2))
        (push 'Expr (eval (list Oper Val1 Val2)))
        (push 'Expr (eval (list Oper
                                (if (lst? Val1) (process1 Val1) Val1)
                                (if (lst? Val2) (process1 Val2) Val2)))))))
  (car Expr))

(test 71    (process1 Ex1))
(test 51    (process1 Ex2))
(test 26    (process1 Ex3))
(test 437   (process1 Ex4))
(test 12240 (process1 Ex5))
(test 13632 (process1 Ex6))

(de solve-pt1 (Expressions)
  (apply + (mapcar process1 Expressions)))

(test 1408133923393 (solve-pt1 Expressions))

# 18b
# simplified shunting-yard algorithm (https://en.wikipedia.org/wiki/Shunting-yard_algorithm)
(setq Expressions Blocks)

(setq Ex1 (chop "1 + 2 * 3 + 4 * 5 + 6"))
(setq Ex2 (chop "1 + (2 * 3) + (4 * (5 + 6))"))
(setq Ex3 (chop "2 * 3 + (4 * 5)"))
(setq Ex4 (chop "5 + (8 * 3 + 9 + 3 * 4 * 3)"))
(setq Ex5 (chop "5 * 9 * (7 * 3 * 3 + 9 * 3 + (8 + 6 * 4))"))
(setq Ex6 (chop "((2 + 4 * 9) * (6 + 9 * 8 + 6) + 6) + 2 + 4 * 2"))

# (token precedence associativity)
(setq *Tokens
  '(("+" 3 'left)
    ("*" 2 'left)))

(setq *LeftP "(")
(setq *RightP ")")

(de operators ()
  (mapcar car *Tokens))

(de has-precedence (prec T1 T2)
  (prec (cadr (assoc T1 *Tokens)) (cadr (assoc T2 *Tokens))))

(de is-associative (Side "T")
  (= Side (caddr (assoc "T" *Tokens))))

(de process (Expr)
  (use (Out Oper)
    (while Expr
      (let Token (pop 'Expr)
        (cond
          ((num? (format Token))
            (push 'Out Token))
          ((member Token (operators))
            (while (and Oper
                        (or (has-precedence '> (car Oper) Token)
                            (and (has-precedence '= (car Oper) Token)
                                 (is-associative 'left Token)))
                        (<> (car Oper) *LeftP))
              (push 'Out (pop 'Oper)))
            (push 'Oper Token))
          ((= Token *LeftP)
            (push 'Oper Token))
          ((= Token *RightP)
            (while (<> *LeftP (car Oper))
              (push 'Out (pop 'Oper)))
            (if (= *LeftP (car Oper))
              (pop 'Oper))))))
    (while Oper
      (push 'Out (pop 'Oper)))
    (flip Out)))

(de solve-rpn (Expr)
  (use Stack
    (while Expr
      (let Token (pop 'Expr)
        (if (num? (format Token))
          (push 'Stack (format Token))
          (push 'Stack ((intern Token) (pop 'Stack) (pop 'Stack))))))
    (car Stack)))

(test 231    (solve-rpn (process Ex1)))
(test 51     (solve-rpn (process Ex2)))
(test 46     (solve-rpn (process Ex3)))
(test 1445   (solve-rpn (process Ex4)))
(test 669060 (solve-rpn (process Ex5)))
(test 23340  (solve-rpn (process Ex6)))

(de solve-pt2-18 (Expressions)
  (apply + (mapcar '((X) (solve-rpn (process X))) Expressions)))

(test 314455761823725 (solve-pt2-18 Expressions))

--- Day 19: Monster Messages ---
(prin ".")(flush)


(msg 'OK)
