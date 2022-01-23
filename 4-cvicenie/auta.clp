(deffacts auta
    (auta peugeot citroen)
    (auta skoda audi volkswagen seat)
    (auta toyota suzuki subaru)
    (auta volvo)
)

;vypise cely zoznam aut
;(defrule vypis_znaciek_aut1
;    (auta $?moje_auta)
;=>
;    (printout t "----" crlf)
;    (printout t "Cely zoznam: " ?moje_auta crlf)
;)

;vypise prve a druhe auto
;(defrule prve_dva
;    (auta ?prve ?druhe $?ostatne)
;=>
;    (printout t ?prve " " ?druhe "----" crlf)
;)

;vypise prve a posledne auto
(defrule prve_posledny
    (auta ?prvy $?ostatne ?posledny)
=>
    (printout t ?prvy ", " ?posledny crlf)
)