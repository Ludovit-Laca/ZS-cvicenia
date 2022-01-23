(deffacts farby
    (farby cervena modra ruzova)
)

;pridaj ako samostatny fakt
(defrule pridaj_fakt
    (farby $?zaciatokA ?farba $?konecA)
=>
    (printout t "Nova farba pridana: " ?farba crlf)
    (assert (farba ?farba))
)