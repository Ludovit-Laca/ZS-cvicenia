(deffacts cisloA
    (cisla 3 7 9 -10 0 4)
)

;utried ciselny zoznam
(defrule utriedit
    ?cl_faktu<-(cisla $?pred ?cislo1 ?cislo2 $?za)
    (test (> ?cislo1 ?cislo2))
=>
    (retract ?cl_faktu)
    (assert (cisla $?pred ?cislo2 ?cislo1 $?za))
)

;vypis usporiadany zoznam
(defrule vypis
    (cisla $?cely_zoznam)
=>
    (printout t $?cely_zoznam crlf)
)