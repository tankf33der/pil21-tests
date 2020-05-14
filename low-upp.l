# Original test code from PicoLisp
# copy-paste
#
### low? ###
(test "a" (low? "a"))
(test NIL (low? "A"))
(test NIL (low? 123))
(test NIL (low? "."))


### upp? ###
(test "A" (upp? "A"))
(test NIL (upp? "a"))
(test NIL (upp? 123))
(test NIL (upp? "."))


### lowc ###
(test "abc" (lowc "ABC"))
(test "äöü" (lowc "ÄÖÜ"))
(test "äöü" (lowc "äöü"))
(test 123 (lowc 123))


### uppc ###
(test "ABC" (uppc "abc"))
(test "ÄÖÜ" (uppc "äöü"))
(test "ÄÖÜ" (uppc "ÄÖÜ"))
(test 123 (lowc 123))

### fold ###
(test "1a2b3" (fold " 1A 2-b/3"))
(test "1a2" (fold " 1A 2-B/3" 3))
