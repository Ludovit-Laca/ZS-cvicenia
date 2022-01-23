(deffacts cisla
    (cislo 1 2 8 3 5)
)

;vypise cely zoznam
;(defrule vypis_celeho_zoznamu
;    (cislo $?vsetky)
;=>
;    (printout t "Zoznam: " ?vsetky crlf)
;)

;vypise prvky zoznamu po jednom
;(defrule vypis_po_jednom
;    (cislo $?zacatek ?cislo $?konec)
;=>
;    (printout t "Číslo: " ?cislo crlf)
;)

;vypise zoznam prvkov podla poradia
(defrule vypis_podla_poradia
    ?cislo_faktu<-(cislo ?prvy_prvok $?ostatne)
=>
    (printout t "Prvok v poradi: " ?prvy_prvok crlf)
    (retract ?cislo_faktu)
    (assert (cislo ?ostatne))
)