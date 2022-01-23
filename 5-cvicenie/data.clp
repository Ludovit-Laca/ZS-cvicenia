(deffacts data
    (zoznam_A a b c d e f)
    (zoznam_B c d j k a)
)

;vypise spolocne prvky
(defrule spolocne_prvky
    (zoznam_A $?zaciatokA ?prvok $?konecA)
    (zoznam_B $?zaciatokB ?prvok $?konecB)
=>
    (printout t "Spoločný prvok: " ?prvok crlf)
)