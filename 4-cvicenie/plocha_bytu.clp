(deffacts miestnosti
	(izba A 5 5)
	(izba B 6 6)
	(izba C 4 7)
	(izba D 3 4)
	(izba E 6 5)
	(izba F 4 3)
)

(deffacts pocet_miestnosti
	(pocet2 0)
)

(defrule plocha_izby
    (izba ?nazov ?x ?y)
=>
    (bind ?plocha (* ?x ?y))
    (assert (plocha_izby ?nazov ?plocha))
)

(defrule plocha_bytu
	(plocha_izby ?nazov ?plocha)
	(pocet2 ?pocet)
	(not(mam_evidovanu_miestnost_bytu ?nazov))	
	(not(stary_pocet_plocha ?pocet))
=>
	(bind ?novy_pocet (+ ?pocet ?plocha))
	(assert (pocet2 ?novy_pocet))
	(assert (mam_evidovanu_miestnost_bytu ?nazov))
	(assert (stary_pocet_plocha ?pocet))
)

(defrule vypis_bytu
    (pocet2 ?x)
    (not (stary_pocet_plocha ?x))
=>
    (printout t "Plocha bytu je: " ?x crlf)
)