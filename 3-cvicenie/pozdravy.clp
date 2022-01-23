(deffacts denni_doby
  (denni_doba rano)
  (denni_doba den)
  (denni_doba vecer)
)
	
(deffacts jazyky
	(pozdrav cesky)
	(pozdrav anglicky)
	(pozdrav nemecky))


(deffacts pozdravy
  (vhodny_pozdrav rano cesky "Dobr� jitro preji")
  (vhodny_pozdrav rano anglicky "Good morning")
  (vhodny_pozdrav rano nemecky "Guten Morgen")	

  (vhodny_pozdrav den cesky "Dobr� den")
  (vhodny_pozdrav den anglicky "Hello")
  (vhodny_pozdrav den nemecky "Guten Tag")

  (vhodny_pozdrav vecer "Hezk� vecer")
  (vhodny_pozdrav vecer anglicky "Good evening")
  (vhodny_pozdrav vecer nemecky "Guten nacht")
)


;***************************************************

;PRAVIDLA
;Zde budeme od u�ivatele po�adovat zad�n� jeho jm�na, denn� doby a jazyka, ve kter�m po�aduje osloven�. 
;V�echny tyto informace si ulo��me pr�kazem assert do b�ze faktu, abychom s nimi mohli d�le pracovat - 
;vybrat konkr�tn� osloven� z b�ze fakt�.

(defrule nacteni_dat
=>
  (printout t "-----------------------------" crlf)	
  (printout t "Zadejte pros�m, Va�e jm�no: " crlf)
  (bind ?jmeno_uzivatele (read))
  (assert (uzivatel ?jmeno_uzivatele))
  	
  (printout t "-----------------------------" crlf)
  (printout t "Zadejte pros�m denn� dobu " crlf)
  (printout t "rano---den---vecer" crlf)
  (printout t "=============================" crlf)
  (bind ?denni_doba (read))
  (assert (prave_je ?denni_doba))

  (printout t "-----------------------------" crlf)
  (printout t "Zadejte jazyk pozdravu" crlf)
  (printout t "cesky--anglicky--nemecky:"crlf)
  (printout t "=============================" crlf)
  (bind ?jazyk (read))
  (assert (chci_jazyk ?jazyk))
)

;Toto pravidlo vyp�e u� konkr�tn� pozdrav vzhledem k po�adavkum u�ivatele.

(defrule pozdrav_na_miru
  (uzivatel ?jmeno)
  (prave_je ?doba)
  (chci_jazyk ?jazyk)
  (vhodny_pozdrav ?doba ?jazyk ?pozdrav)
  
=>
  (printout t ?pozdrav ", " ?jmeno "!" crlf)
)