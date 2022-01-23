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
  (vhodny_pozdrav rano cesky "Dobré jitro preji")
  (vhodny_pozdrav rano anglicky "Good morning")
  (vhodny_pozdrav rano nemecky "Guten Morgen")	

  (vhodny_pozdrav den cesky "Dobrý den")
  (vhodny_pozdrav den anglicky "Hello")
  (vhodny_pozdrav den nemecky "Guten Tag")

  (vhodny_pozdrav vecer "Hezký vecer")
  (vhodny_pozdrav vecer anglicky "Good evening")
  (vhodny_pozdrav vecer nemecky "Guten nacht")
)


;***************************************************

;PRAVIDLA
;Zde budeme od uživatele požadovat zadání jeho jména, denní doby a jazyka, ve kterém požaduje oslovení. 
;Všechny tyto informace si uložíme príkazem assert do báze faktu, abychom s nimi mohli dále pracovat - 
;vybrat konkrétní oslovení z báze faktù.

(defrule nacteni_dat
=>
  (printout t "-----------------------------" crlf)	
  (printout t "Zadejte prosím, Vaše jméno: " crlf)
  (bind ?jmeno_uzivatele (read))
  (assert (uzivatel ?jmeno_uzivatele))
  	
  (printout t "-----------------------------" crlf)
  (printout t "Zadejte prosím denní dobu " crlf)
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

;Toto pravidlo vypíše už konkrétní pozdrav vzhledem k požadavkum uživatele.

(defrule pozdrav_na_miru
  (uzivatel ?jmeno)
  (prave_je ?doba)
  (chci_jazyk ?jazyk)
  (vhodny_pozdrav ?doba ?jazyk ?pozdrav)
  
=>
  (printout t ?pozdrav ", " ?jmeno "!" crlf)
)