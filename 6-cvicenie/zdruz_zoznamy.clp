(deffacts zvery
    (zoznam A lev macka pes had)
    (zoznam B opica tiger)
    (zoznam C pes ryba had)
    (spolocny)
)

;zjednot zoznamy do jedneho zoznamu 'spolocny'
(defrule zjednot
    ?prec1<-(spolocny $?prvky)
    ?prec2<-(zoznam ?x $?zvierata)
=>
    (retract ?prec1 ?prec2)
    (assert(spolocny ?prvky ?zvierata))
)

;odstran duplicitne prvky zo zoznamu 'spolocny'
(defrule odstran_duplicitu
    (declare (salience -10))
    ?prec<-(spolocny $?pred ?prvok $?stred ?prvok $?za)
=>
    (retract ?prec)
    (assert (spolocny $?pred ?prvok $?stred $?za))
)

;vypis zoznam 'spolocny'
(defrule vypis
    (declare (salience -20))
    (spolocny $?vsetky)
=>
    (printout t $?vsetky crlf)
)