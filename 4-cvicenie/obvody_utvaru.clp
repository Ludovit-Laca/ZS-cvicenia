;******************************************
;
;	VYPOCTY OBVODU ROVINNYCH UTVARU
;		(MH 2004)
;	
;	Urcovani obvodu OBDELNIKU
;			TROJUHELNIKU
;		 	KRUHU
;	
;******************************************

(deffacts Utvary
	(utvar obdelnik)
	(utvar trojuhelnik)
	(utvar kruh) 
		
)

;---------------<OBDELNÍK>----------------

(defrule Zadani_utvaru
=>
	(printout t "-------------------------------" crlf)
	(printout t "Zadejte nazev rovinneho utvaru:" crlf)
	(printout t "obdelnik---trojuhelnik---kruh" crlf)
	(printout t "-------------------------------" crlf)
	(bind ?utvar (read))
	;to co uzivatel zada se ulozi do promenne utvar
	(assert (chci_obvod ?utvar))
	;do baze faktu se ulozi to co je v promenne utvar
)


(defrule VypocetObdelnik
	(chci_obvod obdelnik)
	;za podminky, ze si uzivatel preje vypocitat
	;obvod obdelnika pak ...
=>
	(printout t "Zadejte stranu a:" crlf)
	(bind ?stranaA (read))
	;stranu, kterou uzivatel zada si uloz do promenne
	;?stranaA
	(assert (obdelnik_strA ?stranaA))
	;tuto stranu si uloz do baze faktu

	(printout t "Zadejte stranu b:" crlf)
	(bind ?stranaB (read))
	(assert (obdelnik_strB ?stranaB))
	
	(bind ?vysledek (+ (* 2 ?stranaA) (* 2 ?stranaB))) ;PREFIXOVY ZAPIS !!!
	;do promenne ?vysledek uloz vysledek ze vzorce
	(assert (obvod_obdel je ?vysledek))
	;vysledek vypoctu uloz do baze prikazem assert
	(printout t "Obvod obdelniku:" ?vysledek crlf)
	;to co je v promenne ?vysledek hned vypis

	;DALSI POZNAMKY
	;nebylo by nutne vubec ukladat jednotlive strany
	;i konecny vysledek do baze - stacilo by jen vypsat
	;ale baze s agendou je mozkem programu, takze
	;se do ni spravne maji promitnout vsechny zmeny
	;tim nam dava program najevo, ze provedl operace
	;s temi a temi fakty a neco mu vyslo
)

;------------<TROJUHELNÍK>------------

(defrule Vypocet_trojuhelniku
	(chci_obvod trojuhelnik)	
=>

	(printout t "Zadejte stranu a:" crlf)
	(bind ?stranaA (read))
	(assert (trojuhelnik_strA ?stranaA))

	(printout t "Zadejte stranu b:" crlf)
	(bind ?stranaB (read))
	(assert (trojuhelnik_strB ?stranaB))

	(printout t "Zadejte stranu c:" crlf)
	(bind ?stranaC (read))
	(assert (trojuhelnik_strC ?stranaC))
	
	(bind ?vysledek (+ ?stranaA ?stranaB ?stranaC))
	(assert (obvod_troj je ?vysledek))

	(printout t "Obvod trojuhelniku:" ?vysledek crlf)

)

;-------------<KRUH>-------------

(defrule Vypocet_KRUH
	(chci_obvod kruh)
=>
	(printout t "Zadejte prumer kruhu:" crlf)
	(bind ?prumer (read))
	(assert (kruh_prumer ?prumer))
	(bind ?vysledek (* (pi) ?prumer))
	;POZOR lze zadat i 3.14, ale ne 3,14	
	(assert (obvod_kruh je ?vysledek))

	(printout t "Obvod kruhu:" ?vysledek crlf)
)

;-----------<ZADANI UTVARU, KTERY V BAZI NENI>--------

(defrule neznam_utvar
	(chci_obvod ?utvar)
	;uzivatel sice zadal utvar
	(not(utvar ?utvar))
	;ale tento utvar neni v bazi evidovany
=>
	(printout t "Neznam tento utvar!" crlf)
	(printout t "Prosim, zadejte ho znovu:" crlf)
	(bind ?utvar (read))
	(assert (chci_obvod ?utvar)))


;Poznamka: pokud nekolikrat zadate stejne spatny nazev utvaru, pak
;vam program skonci - v tomto programu to jeste neni osetreno, protoze prikaz, ktery
;by se pro to mohl pouzit, se tyka az jedne z dalsich lekci