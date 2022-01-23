(deffacts obec_a_okres
	(okres Luzianky Nitra)
	(okres Zirany Nitra)
	(okres Mengusovce Poprad)
	(okres Slavkov Poprad)
	(okres Korytnica Ruzomberok)
)

(deffacts okres_a_kraj
	(kraj Nitra Nitriansky)
	(kraj Topolcany Nitriansky)
	(kraj Poprad Presovsky)
	(kraj Ruzomberok Zilinsky)
)

(defrule nacitanie_mesta
=>
	(printout t "Zadajte nazov hladanej obce: " crlf)
	(bind ?hl_obec (read))
	(assert (chcem_obec ?hl_obec))
)

(defrule vypis_udajov
	(chcem_obec ?mojaobec)
	(okres ?mojaobec ?okres)
	(kraj ?okres ?kraj)
=>
	(printout t "Obec: " ?mojaobec crlf "Okres: " ?okres crlf "Kraj: " ?kraj crlf)
)

(defrule nenasiel_som
	(chcem_obec ?mojaobec)
	(not (okres ?mojaobec ?okres))
=>
	(printout t "Nenasiel som, zadaj nieco ine.." crlf)
	(bind ?hl_obec (read))
	(assert (chcem_obec ?hl_obec))
)