;ZOZNAM FAKTOV

(deffacts zvierata
 (zvery vrabec liska krtko pes)
)

;ZADAJTE ZOZNAM ZVIERAT

(defrule zadavanie
=>
  (printout t "Zadejte zoznam zvierat:" crlf)
  (bind ?zvierata (readline))
  (assert (zvery (explode$ ?zvierata)))
)

;VYPIS ZOZNAMU

(defrule vypis
  (zvery $?zoznam)
=>
  (printout t "Zoznam:" ?zoznam crlf)
)