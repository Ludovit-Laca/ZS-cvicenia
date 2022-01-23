(deffacts zoznamy
    (zoznam A a b c d e)
    (zoznam B a b)
    (zoznam C a b c)
)

;spocitaj prvky zoznamu
(defrule pocet_prvkov
    (zoznam ?nazov $?prvky)
=>
    (bind ?dlzka (length$ $?prvky))
    (assert (dlzka_zoznamu ?nazov ?dlzka))
)

;zisti najdlhsi zoznam
(defrule zisti_max
    (dlzka_zoznamu A ?cisloA)
    (dlzka_zoznamu B ?cisloB)
    (dlzka_zoznamu C ?cisloC)
=>
    (bind ?maximum (max ?cisloA ?cisloB ?cisloC))
    (assert (maximum_je ?maximum))
)

;vypis najdlhsi zoznam
(defrule vypis_max_zoznam
    (maximum_je ?maximum)
    (dlzka_zoznamu ?nazov ?maximum)
=>
    (printout t "Zoznam " ?nazov " je najdlhsi s hodnotou: " ?maximum crlf)
)