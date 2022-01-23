(deffacts krvne_skupiny
	  (skupina A)
	  (skupina B)
	  (skupina AB)
	  (skupina 0)
)

(deffacts osoby_a_krv
	  (osoba Jan 0)
	  (osoba Eva B)
	  (osoba Karol B)
	  (osoba Mirka A)
)

(deffacts kompatibilne_krvne_skupiny
	  (kompatibilita 0 A)
	  (kompatibilita B AB)
	  (kompatibilita A AB)
)



(defrule vseky_osoby_a_krv
	(osoba ?osobaX ?krvX)
=>
	(printout t "Osoba: " ?osobaX " ma skupinu " ?krvX crlf)
)

(defrule vypis_skupin
	(skupina ?x)
=> 
	(printout t "Poznam skupinu: " ?x crlf)
)

(defrule vypis_osoby_B
	(osoba ?x B)
=>
	(printout t "Osoba so skupinou B je: " ?x crlf)
)

(defrule vypis_osoby_AB
	(osoba ?x AB)
=>
	(printout t "Osoba so skupinou AB je: " ?x crlf)
)

(defrule vypis_osoba_nie_je_AB
	(not(osoba ?x AB))
=>
	(printout t "Žiadna osoba s AB nie je" crlf)
)

(defrule vypis_osoba_kompatibilita
	(osoba ?osobaX ?krvX)
	(osoba ?osobaY ?krvY)
	(kompatibilita ?krvX ?krvY)
=>
	(printout t "Osoba " ?osobaX " s krvnou skupinou " ?krvX " môže darovať krv osobe " ?osobaY " s krvnou skupinou " ?krvY crlf)
)