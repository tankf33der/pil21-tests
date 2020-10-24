(load "kangaroo12.l")

(test
   "1AC2D450FC3B4205D19DA7BFCA1B37513C0803577AC7167F06FE2CE1F0EF39E5"
   (kangaroo12_hex NIL NIL 32) )
(setq Tests
   (make
      (do 20
         (chain (range 0 `(hex "FA")) ) ) ) )
(test
   "2BDA92450E8B147F8A7CB629E784A058EFCA7CF7D8218E02D345DFAA65244A1F"
   (kangaroo12_hex (head (** 17 0) Tests) NIL 32) )
(test
   "6BF75FA2239198DB4772E36478F8E19B0F371205F6A9A93A273F51DF37122888"
   (kangaroo12_hex (head (** 17 1) Tests) NIL 32) )
(test
   "CEC21190C33A30ED2A1A7956530FEDC2CABD6812309C7AE518E730D16D08A23F"
   (kangaroo12_hex
      (need 2600 0)
      (mapcar char (chop "abc"))
      32 ) )
(test
   "E7812ACA81EEC0B1DD975E410B992F1EEDB523B620DD5F8D55B5E63D2F9E7B2D"
   (kangaroo12_hex
      (need 16000 0)
      (mapcar char (chop "abc"))
      32 ) )
(msg 'kangaroo12-OK)
