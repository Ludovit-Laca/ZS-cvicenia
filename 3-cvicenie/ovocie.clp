(deffacts ovocie
	(ovocie Hruska)
	(ovocie Jablko)
	(ovocie Pomaranc)
	(ovocie Marhula)
)

(defrule nacitaj_ovocie
=>
 	(printout t "Zadajte nejaky druh ovocia: " crlf)
	(bind ?mojeovocie (read))
	(assert (ovocie ?mojeovocie))
	(printout t "Udaj bol ulozeny do baze faktov!!!" crlf)
)