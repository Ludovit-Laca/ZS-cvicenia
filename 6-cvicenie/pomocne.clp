
(deffacts info
  (ovocie jablko)
  (ovocie hruska)
  (ovocie pomaranc)
  (ovocie kiwi)
  (ovocie mandarinka)
)


(defrule otazka
=>
  (printout t "Chces vypisat vsetky druhy ovocia z databazy ?" crlf)
  (bind ?odpoved (read))
  (assert (volba ?odpoved))
)


(defrule vypisuj_ano
  (volba ano)
  (ovocie ?niejake)
=>
  (printout t "************" crlf)
  (printout t ?niejake crlf)
)

(defrule vypisuj_nie
  (volba nie)
=>
  (printout t "......................" crlf)
  (printout t "  Koniec programu !!!" crlf)
)


(defrule spatna_volba
  ?odstranit<-(volba ~ano&~nie) 
=>
  (retract ?odstranit)
  (printout t "?????????????????????????????" crlf)
  (printout t "Neznama volba !" crlf)
  (printout t "Chces vypisat vsetky druhy ovocia z databazy ?" crlf)
  (bind ?odpoved (read))
  (assert (volba ?odpoved))
)  