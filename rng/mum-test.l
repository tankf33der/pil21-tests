(load "mum.l")

(mum-start)
(setq
   *MUM-PRIMES
   (quote
      1045525886582774919 8136103064137497703
      4467991496273718166 10320099885548846075
      3652204158256733020 151713105414105658
      18098227363425582228 8491746423542996155
      12148758605418197427 427832072915204837
      14558954315831534781 2243670746741826757
      1473621306817345891 4283033351706511836
      12309653837346549563 3732889600109516124 ) )
(test 
   (quote
      1045525886582774918 8136103064137497702
      4467991496273718167 10320099885548846074
      3652204158256733021 151713105414105659
      18098227363425582229 8491746423542996154
      12148758605418197426 427832072915204836
      14558954315831534780 2243670746741826756
      1473621306817345890 4283033351706511837
      12309653837346549562 3732889600109516125
      12358753734587174088 14501218373274754264
      10635536121967398192 1676879821412533873
      13244575514452235698 14337175275979635007
      14274183802530800540 6713027976228116958
      8471743663912008875 15945528108191161030
      5319678884137586498 7377196369351407823
      15865490866916842817 9541452263075593541
      6635279948356948277 6887624411336788351 )
   (make
      (do 32
         (link (mum-next)) ) ) )

(msg 'ok)
(bye)