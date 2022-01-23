(deffacts miestnosti
    (miestnost A)
    (miestnost B)
    (miestnost C)
    (miestnost D)
    (miestnost E)
    (miestnost F)
)

(deffacts evidencia_poctu
    (pocet 0)
)

(defrule pocet_miestnosti
    (miestnost ?x)
    (pocet ?pocet)
    (not (mam_evidovanu_miestnost ?x))
    (not (stary_pocet ?pocet))
=>
    (bind ?novy_pocet (+ 1 ?pocet 1))
    (assert (pocet ?novy_pocet))
    (assert (mam_evidovanu_miestnost ?x))
    (assert (stary_pocet ?pocet)) 
)

(defrule vypis_pocet
    (pocet ?pocet)
    (not (stary_pocet ?pocet))
=>
    (printout t "Finaly pocet miestnosti je: " ?pocet crlf)
)