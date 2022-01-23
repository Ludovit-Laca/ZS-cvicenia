(deffacts miestnosti
	(izba A 5 5)
	(izba B 6 6)
	(izba C 4 7)
	(izba D 3 4)
	(izba E 6 5)
	(izba F 4 3)
)

(deffacts pocet_miestnosti
	(pocet 0)
)

(defrule pocet
	(izba ?x ?y ?y)
	(pocet ?pocet)
	(not(mam_evidovanu_miestnost ?x))	
	(not(stary_pocet ?pocet))
=>
	(bind ?novy_pocet (+ ?pocet 1))
	(assert (pocet ?novy_pocet))
	(assert (mam_evidovanu_miestnost ?x))
	(assert (stary_pocet ?pocet))
)

(defrule vypis
    (pocet ?x)
    (not(stary_pocet ?x))
=>
    (printout t "Pocet štvorcových izieb je: " ?x crlf)
)