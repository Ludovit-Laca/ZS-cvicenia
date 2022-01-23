;***********************************
;
;     POUZITÍ PRIKAZU RETRACT (2)
;	     CHUDAK LAMA
;
;	      (MH 2005)
;***********************************

(deffacts zvirata
  (zvire vlk hyena)
  (oblibena_zvirata papousek pes)
  (zvire lama velbloud)
  (zvire pstros_emu lama)
  (zvire slepice kohout kure) )

;-----------------------------------

(defrule smaz_zvirata_z_baze
  ?pryc_s_lamou<-(zvire $?zacatek lama $?konec)
=>
  (retract ?pryc_s_lamou)
  (printout t "-------------------------------"crlf)
  (printout t "Seznam s Lamou byl odstranen !" crlf)
  (printout t "-------------------------------"crlf) )





  